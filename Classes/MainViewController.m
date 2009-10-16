//
//  MainViewController.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "ObjectiveResourceConfig.h"
#import "UserInfo.h"
#import "Account.h"
#import "Subscription.h"
#import "Bucket.h"
#import "NSString+Util.h"
#import "SFHFKeychainUtils.h"
#import "FileUtil.h"
#import "NSObject+XMLSerializableSupport.h"

static NSString *BUCKETVIEW_SAVED_SUBSCRIPTION = @"bucketview_last_subscription_search.xml";
static NSString *BUCKETVIEW_SAVED_ACCOUNTS = @"bucketview_last_account_search.xml";
static NSString *BUCKETVIEW_LAST_UPDATE = @"bucketview_last_update.xml";

@implementation MainViewController

#pragma mark UIView overridden methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	userInfo = [[UserInfo alloc] init];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[self syncUserDefaults];
	newUser = [userInfo isNewUser];
}

- (void)viewDidUnLoad {
	[userInfo release];
	[subscription release];
	[super viewDidUnload];
}


//the view has to be loaded before programmatically flipping to the info screen
- (void)viewDidAppear:(BOOL)animated {
	if (newUser) {
		[self showInfo];
		newUser = NO;  //only do this once when they first start up
	} else {
		[self refreshView];
	}
}


#pragma mark web services and data manipuplation

- (IBAction)refreshView {
	if (![userInfo isNewUser]) {
		[subscription release];
	
		NSString *formattedDateString = @"?????";
		subscription = [[[Subscription findAllRemote] objectAtIndex:0] retain];		
		if (subscription == nil) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data Error" message:@"Could not update from BucketWise.  Try refreshing later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			subscription = [[Subscription alloc] init];
			subscription.subscriptionId = [FileUtil fileToString:BUCKETVIEW_SAVED_SUBSCRIPTION];
			subscription.accounts = [Account allFromXMLData:[FileUtil fileToData:BUCKETVIEW_SAVED_ACCOUNTS]];
			formattedDateString = [FileUtil fileToString:BUCKETVIEW_LAST_UPDATE];
		} else {		
			NSData *accountsXmlData = [Account findXmlForSubscriptionWithId:[subscription subscriptionId]];
			[FileUtil stringToFile:[subscription subscriptionId] withFileName:BUCKETVIEW_SAVED_SUBSCRIPTION];
			[FileUtil dataToFile:accountsXmlData withFileName:BUCKETVIEW_SAVED_ACCOUNTS];
			subscription.accounts = [Account allFromXMLData:accountsXmlData];			
			[acctTableView reloadData];
			
			NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
			[dateFormatter setDateStyle:NSDateFormatterShortStyle];
			[dateFormatter setTimeStyle:NSDateFormatterShortStyle];		
			NSDate *date = [NSDate date];
			formattedDateString = [dateFormatter stringFromDate:date];		
			[FileUtil stringToFile:formattedDateString withFileName:BUCKETVIEW_LAST_UPDATE];
		}
		lastUpdatedLabel.text = [NSString stringWithFormat:@"Updated %@", formattedDateString];
	}	
}

- (void)syncUserDefaults {
	userInfo.bucketWiseUrl = [self cleanUpUrl:[[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUrl"]];
	userInfo.bucketWiseUserName = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUserName"];
	userInfo.bucketWisePassword = [SFHFKeychainUtils getPasswordForUsername:userInfo.bucketWiseUserName andServiceName:@"BucketView" error:nil];
	
	[ObjectiveResourceConfig setSite:userInfo.bucketWiseUrl];	 
	[ObjectiveResourceConfig setUser:userInfo.bucketWiseUserName];
	[ObjectiveResourceConfig setPassword:userInfo.bucketWisePassword];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
	[self syncUserDefaults];
	[self refreshView];
}


- (IBAction)showInfo {    	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

#pragma mark table view delegate and dataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bucketCell"];
	if(nil == cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"bucketCell"] autorelease];
	}

	Account *acct = [subscription.accounts objectAtIndex:indexPath.section];
	NSString *bucketName = [[acct.buckets objectAtIndex:indexPath.row] name];
	NSString *bucketBalance = [[acct.buckets objectAtIndex:indexPath.row] balance];	
	
	// format balance for currency
	NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
	[currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[currencyStyle setNumberStyle:NSNumberFormatterCurrencyStyle];
	int intBalance = [bucketBalance intValue] / 100;
	NSNumber *amount = [NSNumber numberWithInteger:intBalance];
	
	NSString* formattedBalance = [currencyStyle stringFromNumber:amount];
	[currencyStyle release];
	
	cell.textLabel.font = [UIFont systemFontOfSize:15.0];
	cell.textLabel.text = bucketName;
	cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
	cell.detailTextLabel.text = formattedBalance;
 
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[subscription.accounts objectAtIndex:section] name];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return subscription.accounts.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[subscription.accounts objectAtIndex:section] buckets] count];
}

- (NSString *)cleanUpUrl:(NSString*)url {
	NSInteger length = [url length];
	if (![[[url trim] substringWithRange:NSMakeRange(length - 1, 1)] isEqualToString:@"/"]) {
		url = [NSString stringWithFormat:@"%@%@", url, @"/"];
	}
	return url;
}

#pragma mark object life cycle stuff

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [super dealloc];
}



@end

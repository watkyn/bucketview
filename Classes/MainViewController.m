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
#import "Account.h"
#import "Subscription.h"
#import "Bucket.h"
#import "NSString+Util.h"

@implementation MainViewController

#pragma mark UIView overridden methods

 - (void)viewDidLoad {
	 [super viewDidLoad];
	 self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	 [self syncUserDefaults];
	 
	 //TODO - show busy panel while loading
	 
	 userInfo = [[Subscription alloc] init];
	 [self refreshView];
 }

//the view has to be loaded before programmatically flipping to the info screen
- (void)viewDidAppear:(BOOL)animated {
	//new users should be starting here
	if (![bucketWiseUrl hasData]) {
		[self showInfo];	
	}
}


#pragma mark web services and data manipuplation

- (IBAction)refreshView {
	if (bucketWiseUrl != nil) {
		[userInfo release];
		userInfo = [[[Subscription findAllRemote] objectAtIndex:0] retain];
		userInfo.accounts = [Account findAllForSubscriptionWithId:[userInfo subscriptionId]];
		
		[acctTableView reloadData];
				
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];		
		NSDate *date = [NSDate date];
		NSString *formattedDateString = [dateFormatter stringFromDate:date];		
		lastUpdatedLabel.text = [NSString stringWithFormat:@"Updated %@", formattedDateString];
	}	
}

- (void)syncUserDefaults {
	bucketWiseUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUrl"];
	userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUserName"];
	password = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWisePassword"];
	
	[ObjectiveResourceConfig setSite:bucketWiseUrl];	 
	[ObjectiveResourceConfig setUser:userName];
	[ObjectiveResourceConfig setPassword:password];
}


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
	[self syncUserDefaults];
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

	Account *acct = [userInfo.accounts objectAtIndex:indexPath.section];
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
	return [[userInfo.accounts objectAtIndex:section] name];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return userInfo.accounts.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[userInfo.accounts objectAtIndex:section] buckets] count];
}

#pragma mark object life cycle stuff

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [super dealloc];
}



@end

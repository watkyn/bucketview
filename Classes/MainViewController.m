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

@implementation MainViewController

#pragma mark loading and unloading

 - (void)viewDidLoad {
	 [super viewDidLoad];
	 self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	 [self syncUserDefaults];
	 
	 //TODO - show busy panel while loading
	 //TODO - use core data to keep stale copy of data and have refresh happen in background?
	 
	 userInfo = [[Subscription alloc] init];
	 [self refreshView];
 }

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark web services and data manip

- (IBAction)refreshView {
	if (bucketWiseUrl != nil) {
		[userInfo release];
		userInfo = [[[Subscription findAllRemote] objectAtIndex:0] retain];
		userInfo.accounts = [Account findAllForSubscriptionWithId:[userInfo subscriptionId]];
		for (int i = 0; i < [userInfo.accounts count]; i++) {
			Account *acct = [userInfo.accounts objectAtIndex:i];			
			acct.buckets = [Bucket findAllForAccountWithId:[acct accountId]];
		}
		
		[acctTableView reloadData];
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
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"bucketCell"] autorelease];
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
	
	NSString *cellText = [NSString stringWithFormat:@"%@   %@", bucketName, formattedBalance];
	cell.textLabel.font = [UIFont systemFontOfSize:15.0];
	cell.textLabel.text = cellText;
 
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

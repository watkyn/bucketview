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


 - (void)viewDidLoad {
	 [super viewDidLoad];
	 [self syncUserDefaults];
 }

- (IBAction)refreshView {
	Subscription *subby = [[Subscription findAllRemote] objectAtIndex:0];
	subby.accounts = [Account findAllForSubscriptionWithId:[subby subscriptionId]];
	for (int i = 0; i < [subby.accounts count]; i++) {
		Account *acct = [subby.accounts objectAtIndex:i];
		NSLog([acct name]);
		NSLog([acct balance]);
		
		acct.buckets = [Bucket findAllForAccountWithId:[acct accountId]];
		for (int i = 0; i < [acct.buckets count]; i++) {
			Bucket *bucket = [acct.buckets objectAtIndex:i];
			NSLog([bucket name]);
			NSLog([bucket balance]);			 
		}		
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

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

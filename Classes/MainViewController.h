//
//  MainViewController.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"

@class Subscription;
@class Account;
@class Bucket;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
	NSString *bucketWiseUrl;
	NSString *userName;
	NSString *password;
	Subscription *userInfo;
	IBOutlet UITableView *acctTableView;
	IBOutlet UILabel *lastUpdatedLabel;
}

- (IBAction)showInfo;

- (IBAction)refreshView;

- (void)syncUserDefaults;


@end

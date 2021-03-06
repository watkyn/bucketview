//
//  MainViewController.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"

@class FileUtil;
@class Subscription;
@class UserInfo;
@class SplashScreenView;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
	Subscription *subscription;
	UserInfo *userInfo;
	IBOutlet UITableView *acctTableView;
	IBOutlet UILabel *lastUpdatedLabel;
	BOOL newUser;
}

- (IBAction)showInfo;

- (IBAction)refreshView;

- (void)syncUserDefaults;

- (NSString *)cleanUpUrl:(NSString *)url;

- (NSString *)formatMoney:(NSNumber *)amount;

- (NSString *)formatBalance:(NSString *)amountString;

@end

//
//  MainViewController.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	NSString *bucketWiseUrl;
	NSString *userName;
	NSString *password;
}

- (IBAction)showInfo;

- (void)syncUserDefaults;

@end

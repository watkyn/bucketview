//
//  FlipsideViewController.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"
#import "NSString+Util.h"
#import "SFHFKeychainUtils.h"

@implementation FlipsideViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	
	urlTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUrl"];
	userNameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUserName"];
	passwordTextField.text = [SFHFKeychainUtils getPasswordForUsername:userNameTextField.text andServiceName:@"BucketView" error:nil];
}

- (IBAction)done {
	NSString *username = [userNameTextField.text trim];
	NSString *password = [passwordTextField.text trim];
	[[NSUserDefaults standardUserDefaults] setObject:[urlTextField.text trim] forKey:@"bucketWiseUrl"];
	[[NSUserDefaults standardUserDefaults] setObject:username forKey:@"bucketWiseUserName"];	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	//store password in keychain
	[SFHFKeychainUtils storeUsername:username andPassword:password forServiceName:@"BucketView" updateExisting:TRUE error:nil];	
	
	[self.delegate flipsideViewControllerDidFinish:self];	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end

//
//  FlipsideViewController.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	
	NSString *bucketWiseUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUrl"];
	NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUserName"];
	NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWisePassword"];
	
	urlTextField.text = bucketWiseUrl;
	userNameTextField.text = userName;
	passwordTextField.text = password;
	
}


- (IBAction)done {
	[self.delegate flipsideViewControllerDidFinish:self];	
	
	[[NSUserDefaults standardUserDefaults] setObject:urlTextField.text forKey:@"bucketWiseUrl"];
	[[NSUserDefaults standardUserDefaults] setObject:userNameTextField.text forKey:@"bucketWiseUserName"];	
	[[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:@"bucketWisePassword"];
	[[NSUserDefaults standardUserDefaults] synchronize];
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

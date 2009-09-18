//
//  FlipsideViewController.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FlipsideViewController.h"
#import "NSString+Util.h"

@implementation FlipsideViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	
	urlTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUrl"];
	userNameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUserName"];
	passwordTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWisePassword"];
	
}


- (IBAction)done {
	[[NSUserDefaults standardUserDefaults] setObject:[urlTextField.text trim] forKey:@"bucketWiseUrl"];
	[[NSUserDefaults standardUserDefaults] setObject:[userNameTextField.text trim] forKey:@"bucketWiseUserName"];	
	[[NSUserDefaults standardUserDefaults] setObject:[passwordTextField.text trim] forKey:@"bucketWisePassword"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
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

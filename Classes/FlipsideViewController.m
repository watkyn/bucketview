//
//  FlipsideViewController.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//

#import "FlipsideViewController.h"
#import "NSString+Util.h"

@implementation FlipsideViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];    
	
	NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
	versionLabel.text = [NSString stringWithFormat:@"Version: %@", [infoDictionary valueForKey:@"CFBundleVersion"]];
	
	urlTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUrl"];
	userNameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"bucketWiseUserName"];
	//passwordTextField.text = [SFHFKeychainUtils getPasswordForUsername:userNameTextField.text andServiceName:@"BucketView" error:nil];
}

- (IBAction)done {
	NSString *username = [userNameTextField.text trim];
	//NSString *password = [passwordTextField.text trim];
	[[NSUserDefaults standardUserDefaults] setObject:[urlTextField.text trim] forKey:@"bucketWiseUrl"];
	[[NSUserDefaults standardUserDefaults] setObject:username forKey:@"bucketWiseUserName"];	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	//store password in keychain
	//[SFHFKeychainUtils storeUsername:username andPassword:password forServiceName:@"BucketView" updateExisting:TRUE error:nil];	
	
	[self.delegate flipsideViewControllerDidFinish:self];	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


@end

//
//  BucketViewAppDelegate.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//

#import "BucketViewAppDelegate.h"
#import "MainViewController.h"


@implementation BucketViewAppDelegate


@synthesize window;
@synthesize mainViewController;
@synthesize splashScreen;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	[window addSubview:[mainViewController view]];
    
    self.splashScreen.delegate = self;
    self.splashScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.mainViewController presentModalViewController:splashScreen animated:NO];
    
    [window makeKeyAndVisible];
}



@end

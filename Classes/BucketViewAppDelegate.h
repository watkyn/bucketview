//
//  BucketViewAppDelegate.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//

#import "SplashScreenView.h"

@class MainViewController;


@interface BucketViewAppDelegate : NSObject <UIApplicationDelegate, SplashScreenDelegate> {
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;
@property (nonatomic, retain) IBOutlet SplashScreenView *splashScreen;

@end


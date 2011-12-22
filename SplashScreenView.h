//
//  SplashScreenView.h
//  BucketView
//
//  Created by Tony on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashScreenView;

@protocol SplashScreenDelegate <NSObject>

@optional
- (void)splashScreenDidAppear:(SplashScreenView *)splashScreen;

@end

@interface SplashScreenView : UIViewController

@property (nonatomic, retain) UIImage *splashImage;
@property (nonatomic, assign) BOOL showsStatusBarOnDismissal;
@property (nonatomic, assign) id<SplashScreenDelegate> delegate;

@end

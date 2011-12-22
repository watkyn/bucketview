//
//  SplashScreenView.m
//  BucketView
//
//  Created by Tony on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SplashScreenView.h"

@implementation SplashScreenView

@synthesize splashImage;
@synthesize showsStatusBarOnDismissal;
@synthesize delegate;


- (void)loadView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.splashImage];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeCenter;
    self.view = imageView;
}

- (UIImage *)splashImage {
    if (splashImage == nil) {
        self.splashImage = [UIImage imageNamed:@"Default.png"];
    }
    return splashImage;
}




@end

//
//  Subscription.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Subscription.h"


@implementation Subscription

@synthesize subscriptionId, ownerId, accounts;

- (void)dealloc {
	[accounts release];
	[ownerId release];
	[subscriptionId release];
    [super dealloc];
}

@end

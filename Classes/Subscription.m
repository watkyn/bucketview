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

- (NSArray *)sortedAccounts {
	NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	return [accounts sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByName]];	
}

@end

//
//  Account.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "Subscription.h"
#import "Response.h"
#import "Connection.h"
#import "ObjectiveResourceConfig.h"
#import "NSObject+XMLSerializableSupport.h"

@implementation Account

+ (NSArray *)findAllForSubscriptionWithId:(NSString *)subscriptionId {	
    NSString *accountPath = [NSString stringWithFormat:@"%@subscriptions/%@/accounts.xml?include=buckets", [self getRemoteSite], subscriptionId];
    Response *res = [Connection get:accountPath withUser:[ObjectiveResourceConfig getUser] andPassword:[ObjectiveResourceConfig getPassword]];
    return [self allFromXMLData:res.body];
}


@synthesize name, balance, accountId, buckets;


- (void)dealloc {
	[buckets release];
	[name release];
	[balance release];
	[accountId release];
    [super dealloc];
}


@end


//
//  Account.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "Subscription.h"

@implementation Account

+ (NSData *)findXmlForSubscriptionWithId:(NSString *)subscriptionId {	
//    NSString *accountPath = [NSString stringWithFormat:@"%@subscriptions/%@/accounts.xml?include=buckets", [self getRemoteSite], subscriptionId];
//    Response *res = [Connection get:accountPath withUser:[ObjectiveResourceConfig getUser] andPassword:[ObjectiveResourceConfig getPassword]];
//    return res.body;
    return nil;
}


@synthesize name, balance, accountId, buckets;


@end


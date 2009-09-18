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
    // use ObjectiveResource URL generation methods to construct the nested path of
	// assuming a single account for right now.  If someone needs a second, we can change it.
    NSString *accountPath = [NSString stringWithFormat:@"%@subscriptions/1/accounts.xml?include=buckets", [self getRemoteSite]];
    Response *res = [Connection get:accountPath withUser:[ObjectiveResourceConfig getUser] andPassword:[ObjectiveResourceConfig getPassword]];
    return [self allFromXMLData:res.body];
}


@synthesize name, balance, accountId, buckets;


- (void)dealloc {
    [super dealloc];
}


@end


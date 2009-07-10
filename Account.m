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

@implementation Account

+ (NSArray *)findAllForSubscriptionWithId:(NSString *)subscriptionId {
	
    // use ObjectiveResource URL generation methods to construct the nested path of
    NSString *accountPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
							   [self getRemoteSite],
							   [Subscription getRemoteCollectionName],
							   subscriptionId,
							   [self getRemoteCollectionName],
							   [self getRemoteProtocolExtension]];
	
    Response *res = [Connection get:accountPath withUser:[ObjectiveResourceConfig getUser]
						andPassword:[ObjectiveResourceConfig getPassword]];
    return [self allFromXMLData:res.body];
}


@synthesize name, balance, accountId, buckets;


- (void)dealloc {
    [super dealloc];
}


@end


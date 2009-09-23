//
//  Bucket.m
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Bucket.h"
#import "Account.h"
#import "Response.h"
#import "Connection.h"
#import "ObjectiveResourceConfig.h"
#import "NSObject+XMLSerializableSupport.h"

@implementation Bucket

+ (NSArray *)findAllForAccountWithId:(NSString *)accountId {
	// use ObjectiveResource URL generation methods to construct the nested path of
    NSString *bucketPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
							   [self getRemoteSite],
							   [Account getRemoteCollectionName],
							   accountId,
							   [self getRemoteCollectionName],
							   [self getRemoteProtocolExtension]];
	
    Response *res = [Connection get:bucketPath withUser:[ObjectiveResourceConfig getUser]
						andPassword:[ObjectiveResourceConfig getPassword]];
    return [self allFromXMLData:res.body];
	
}


@synthesize name, balance;

- (void)dealloc {
	[name release];
	[balance release];
	[super dealloc];
}

@end

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

@implementation Bucket

+ (NSArray *)findAllForAccountWithId:(NSString *)accountId {
	// use ObjectiveResource URL generation methods to construct the nested path of
    NSString *bucketPath = [NSString stringWithFormat:@"%@%@/%@/%@%@",
							   [self getRemoteSite],
							   [Account getRemoteCollectionName],
							   accountId,
							   [self getRemoteCollectionName],
							   [self getRemoteProtocolExtension]];
	
	NSLog(bucketPath);
	//accounts/3/buckets.xml
	
    Response *res = [Connection get:bucketPath withUser:[ObjectiveResourceConfig getUser]
						andPassword:[ObjectiveResourceConfig getPassword]];
    return [self allFromXMLData:res.body];
	
}


@synthesize name, balance;



@end
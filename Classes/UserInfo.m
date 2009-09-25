//
//  UserInfo.m
//  BucketView
//
//  Created by Tony Eichelberger on 9/25/09.
//  Copyright 2009 IDEXX Laboratories. All rights reserved.
//

#import "UserInfo.h"
#import "NSString+Util.h"

@implementation UserInfo

@synthesize bucketWiseUrl, bucketWiseUserName, bucketWisePassword;

- (BOOL)isNewUser {
	return (![bucketWiseUrl hasData] || ![bucketWiseUserName hasData] || ![bucketWisePassword hasData]);
}

- (void)dealloc {
	[bucketWiseUrl release];
	[bucketWiseUserName release];
	[bucketWisePassword release];
	[super dealloc];
}

@end

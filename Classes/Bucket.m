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

@synthesize name, balance;

- (void)dealloc {
	[name release];
	[balance release];
	[super dealloc];
}

@end

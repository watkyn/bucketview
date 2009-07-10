//
//  Account.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Account : NSObject {
	NSString *accountId;
	NSString *name;
	NSString *balance;
	NSArray *buckets;
}

+ (NSArray *)findAllForSubscriptionWithId:(NSString *)subscriptionId;

@property (nonatomic, retain) NSString *accountId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *balance;
@property (nonatomic, retain) NSArray *buckets;

@end

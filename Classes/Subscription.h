//
//  Subscription.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Subscription : NSObject {
	NSString *subscriptionId;
	NSString *ownerId;
	NSArray *accounts;
}

@property (nonatomic, retain) NSString *subscriptionId;
@property (nonatomic, retain) NSString *ownerId;
@property (nonatomic, retain) NSArray *accounts;

- (NSArray *)sortedAccounts;

@end

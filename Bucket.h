//
//  Bucket.h
//  BucketView
//
//  Created by Tony Eichelberger on 7/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Bucket : NSObject {
	NSString *name;
	NSString *balance;
}

+ (NSArray *)findAllForAccountWithId:(NSString *)accountId;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *balance;

@end

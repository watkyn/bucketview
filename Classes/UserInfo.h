//
//  UserInfo.h
//  BucketView
//
//  Created by Tony Eichelberger on 9/25/09.
//  Copyright 2009 IDEXX Laboratories. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject {
}

@property (nonatomic, retain) NSString *bucketWiseUrl;
@property (nonatomic, retain) NSString *bucketWiseUserName;
@property (nonatomic, retain) NSString *bucketWisePassword;

- (BOOL)isNewUser;

@end

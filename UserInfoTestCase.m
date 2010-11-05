//
//  UserInfoTestCase.m
//  BucketView
//
//  Created by Tony Eichelberger on 11/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserInfoTestCase.h"
#import "UserInfo.h"

@implementation UserInfoTestCase

- (void)testThatNewUserTrueWhenNoFieldsSet {
	UserInfo *user = [[UserInfo alloc] init];
	STAssertTrue([user isNewUser], nil);
}

- (void)testThatNewUserTrueWhenOnlyUserNameSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWiseUserName = @"ike";
	STAssertTrue([user isNewUser], nil);	
}

- (void)testThatNewUserTrueWhenOnlyPasswordSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWisePassword = @"passcode";
	STAssertTrue([user isNewUser], nil);	
}

- (void)testThatNewUserTrueWhenOnlyUrlSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWiseUrl = @"http://buckets.com";
	STAssertTrue([user isNewUser], nil);	
}

- (void)testThatNewUserTrueWhenOnlyUserNameAndPasswordSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWiseUserName = @"me";
	user.bucketWisePassword = @"somepass";
	STAssertTrue([user isNewUser], nil);	
}

- (void)testThatNewUserTrueWhenOnlyUserNameAndUrlSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWiseUserName = @"me";
	user.bucketWiseUrl = @"http://somepass";
	STAssertTrue([user isNewUser], nil);	
}

- (void)testThatNewUserTrueWhenOnlyPasswordAndUrlSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWisePassword = @"me";
	user.bucketWiseUrl = @"http://somepass";
	STAssertTrue([user isNewUser], nil);	
}

- (void)testThatNewUserFalseWhenAllFieldsSet {
	UserInfo *user = [[UserInfo alloc] init];
	user.bucketWiseUserName = @"me";
	user.bucketWisePassword = @"the pass";
	user.bucketWiseUrl = @"http://somepass";
	STAssertFalse([user isNewUser], nil);	
}

@end

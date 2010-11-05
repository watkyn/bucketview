//
//  StringUtilTestCase.m
//  BucketView
//
//  Created by Tony Eichelberger on 11/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface StringUtilTestCase : SenTestCase {
	
}

@end

#import "NSString+Util.h"

@implementation StringUtilTestCase

- (void)testHasDataWhenStringIsNil {
	NSString *nilString = nil;
	STAssertFalse([nilString hasData], @"should not have data when nil");
}

- (void)testHasDataWhenStringIsEmpty {
	NSString *emptyString = @"";
	STAssertFalse([emptyString hasData], @"should not have data when nil");
}

- (void)testHasDataWhenStringIsSpaces {
	NSString *emptyString = @"   ";
	STAssertFalse([emptyString hasData], @"should not have data when nil");
}

- (void)testHasDataWhenStringIsWhitespace {
	NSString *emptyString = @"   \n\n \t";
	STAssertFalse([emptyString hasData], @"should not have data when nil");
}

@end

//
//  NSString+Util.m
//  LabInbox
//
//  Created by Tony Eichelberger on 8/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSString *)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)hasData {
	return [[self trim] length] > 0;
}

@end

//
//  FileUtil.m
//  BucketView
//
//  Created by Tony Eichelberger on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FileUtil.h"


@implementation FileUtil

+ (NSString *)documentsPath {
	NSString *docPath = NSHomeDirectory();
	return [docPath stringByAppendingPathComponent:@"Documents"];
}

+ (NSData *)fileToData:(NSString *)fileName {
	return [NSData dataWithContentsOfFile:[[self documentsPath] stringByAppendingPathComponent:fileName]];
}

+ (void)dataToFile:(NSData *)data withFileName:(NSString *)fileName {
	NSString *newFilePath = [[self documentsPath] stringByAppendingPathComponent:fileName]; 
	[data writeToFile:newFilePath atomically:YES];
}

+ (NSString *)fileToString:(NSString *)fileName {
	return [NSString stringWithContentsOfFile:[[self documentsPath] stringByAppendingPathComponent:fileName]];
}

+ (void)stringToFile:(NSString *)string withFileName:(NSString *)fileName {
	NSString *newFilePath = [[self documentsPath] stringByAppendingPathComponent:fileName]; 
	[string writeToFile:newFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


@end

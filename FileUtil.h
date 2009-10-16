//
//  FileUtil.h
//  BucketView
//
//  Created by Tony Eichelberger on 10/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileUtil : NSObject {
	NSOutputStream *asyncOutputStream;
	NSData * outputData;
	NSRange outputRange;
	BOOL ready;
}

+ (NSString *)documentsPath;

+ (NSData *)fileToData:(NSString *)fileName;

+ (void)dataToFile:(NSData *)data withFileName:(NSString *)fileName;

+ (NSString *)fileToString:(NSString *)fileName;

+ (void)stringToFile:(NSString *)data withFileName:(NSString *)fileName;

@end

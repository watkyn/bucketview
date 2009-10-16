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
}

+ (NSString *)documentsPath;

- (void)stringToFile:(NSString *)stringData withFileName:(NSString *)fileName;

@end

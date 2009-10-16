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


- (void)stringToFile:(NSString *)stringData withFileName:(NSString *)fileName {
	[asyncOutputStream release]; 
	[outputData release]; 
	outputData = [[stringData dataUsingEncoding:NSUTF8StringEncoding] retain]; 
	outputRange.location = 0; 
	NSString *newFilePath = [[FileUtil documentsPath] stringByAppendingPathComponent:fileName]; 
	[[NSFileManager defaultManager] createFileAtPath:newFilePath contents:nil attributes:nil]; 
	asyncOutputStream = [[NSOutputStream alloc] initToFileAtPath:newFilePath append:NO]; 
	[asyncOutputStream setDelegate:self]; 
	[asyncOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode]; 
	[asyncOutputStream open]; 
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent { 
	NSOutputStream *outputStream = (NSOutputStream*) theStream; 
	BOOL shouldClose = NO; 
	switch (streamEvent) { 
		case NSStreamEventHasSpaceAvailable: { 
			uint8_t outputBuf [1]; 
			outputRange.length = 1; 
			[outputData getBytes:&outputBuf range:outputRange]; 
			[outputStream write:outputBuf maxLength:1]; 
			if (++outputRange.location == [outputData length]) { 
				shouldClose = YES; 
			} 
			break; 
		} 
		case NSStreamEventErrorOccurred: { 
			NSError *error = [theStream streamError]; 
			if (error != NULL) { 
				NSLog([error description]);
			} 
			shouldClose = YES; 
			break; 
		} 
		case NSStreamEventEndEncountered: 
			shouldClose = YES; 
		} 

		if (shouldClose) { 
			[outputStream removeFromRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode]; 
			[theStream close]; 
		} 
} 


- (void)dealloc {
	[asyncOutputStream release];
	[outputData release];
	
	[super dealloc];
}

@end

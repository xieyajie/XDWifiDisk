//------------------------------------------------------------------------------
// Filename:        ASZipEx.m
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-10-21
// Version:         
// Copyright 2011 AlphaStudio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.

#import "ASDirectoryEx.h"
#import "ASFileEx.h"
#import "ASFileType.h"
#import "ASZipEx.h"
#import "ZipArchive.h"

@interface ASZipEx()
-(id) init;
@end

static NSString *const root = @"/Documents/";
static ASZipEx *sharedInstance;

@implementation ASZipEx

+ (ASZipEx *)sharedASZipEx
{
	if(nil == sharedInstance){
		sharedInstance = [[ASZipEx alloc] init];
	}
	
	return sharedInstance;
}

-(id) init
{
	self = [super init];
	if (self) {
		zipArchive = [[ZipArchive alloc] init];
	}
	return self;	
}

- (void) dealloc
{
	[zipArchive release];
	[super dealloc];
}

/*
 @abstract filesPath中的每一项都是相对于local的相对路径；zipPath是绝对路径 currentPath是绝对路径
 @result 是否压缩成功  
 */
- (BOOL)zipFiles:(NSArray *)filesPath toZip:(NSString *)zipPath currentPath:(NSString *)currentPath
{
	BOOL result = YES;
	result = [zipArchive CreateZipFile2:zipPath];
	if (!result) {
		return NO;
	}
	NSInteger currentPathLegth = [currentPath length];
	NSMutableString *LocalPath = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
	[LocalPath appendString:root];
	
	for (NSString *filePath in filesPath) {
		NSString *fileAP = [LocalPath stringByAppendingString:filePath];
		NSString *newName = [fileAP substringFromIndex:currentPathLegth];
		result = [zipArchive addFileToZip:fileAP newname:newName];
		
		if (!result) 
        {
            [LocalPath release];
			return NO;
		}
	}
    
    [LocalPath release];
    
	result = [zipArchive CloseZipFile2];
	
	return result;
}

/*
 @abstract zipPath是绝对路径 newPath是绝对路径
 @result 是否解压缩成功  
 */
- (BOOL)unZipFilePath:(NSString *)zipPath toPath:(NSString *)newPath
{
	BOOL result = [zipArchive UnzipOpenFile:zipPath];
	if (!result) {
		return NO;
	}
	result = [zipArchive UnzipFileTo:newPath overWrite:YES];
	if (!result) {
		return NO;
	}
	result = [zipArchive UnzipCloseFile];
	
	return result;
}

/*
 @abstract files中的每一项是一个id<ASDataObject>；zipPath是绝对路径 currentDirectory是一个ASDirectoryEx的对象
 @result 是否压缩成功  
 */
- (BOOL)zipFiles:(NSArray *)files toZip:(NSString *)zipPath currentDirectory:(ASDirectoryEx *)currentDirectory
{
	NSString *homeDirectory = NSHomeDirectory();
	NSString *currentPath = [[NSString alloc] 
							 initWithFormat:@"%@%@%@",homeDirectory,@"/Documents/",[currentDirectory getFullItemName]];
    
	NSMutableArray *filesPath = [[NSMutableArray alloc] initWithCapacity:[files count]];
	for (ASFileEx *file in files) 
    {
		NSString *filePath;
		if (kDirectory == [file getFileType]) 
        {
            NSArray *tmpArray = [file getFileList:YES];
            for(int i = 0; i < [tmpArray count]; i++)
            {
                ASFileEx *tmpFile = [tmpArray objectAtIndex:i];
                NSString *tmpStr = [tmpFile getFullItemName];
                if(kDirectory == [tmpFile getFileType])
                    filePath = [[NSString alloc] initWithFormat:@"%@/",tmpStr];
                else
                    filePath = [[NSString alloc] initWithFormat:@"%@",tmpStr];
                [filesPath addObject:filePath];
            }
			NSString *tempPath = [file getFullItemName];
			filePath = [[NSString alloc] initWithFormat:@"%@/",tempPath];
		}
		else 
        {
			filePath = [[NSString alloc] initWithString:[file getFullItemName]];
		}

		[filesPath addObject:filePath];
		[filePath release];
	}

    NSLog(@"%s -- %@",__func__,filesPath);
	BOOL result = [self zipFiles:filesPath toZip:zipPath currentPath:currentPath];
	[currentPath release];
	[filesPath release];
	
	return result;
}

/*
 @abstract zipfile newPath是绝对路径
 @result 是否解压缩成功  
 */
- (BOOL)unZipFile:(ASFileEx *)zipfile toPath:(NSString *)newPath
{
	NSString *homeDirectory = NSHomeDirectory();
	NSString *zipfilePath = [[NSString alloc] 
				   initWithFormat:@"%@%@%@",homeDirectory,@"/Documents",[zipfile getFullItemName]];
	BOOL result = [self unZipFilePath:zipfilePath toPath:newPath];	
	[zipfilePath release];
	
	return result;
}
@end

//------------------------------------------------------------------------------
// Filename:        ASZipEx.h
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-10-21
// Version:         
// Copyright 2011 AlphaStudio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
//需要在工程中加入ZipArchive类，minizip文件夹和lib.1.2.3.dylib

#import <Foundation/Foundation.h>
@class ZipArchive;
@class ASDirectoryEx;
@class ASFileEx;
/*
    @abstract	
*/

@interface ASZipEx : NSObject 
{
@private
    
    //Declare instance variaites.
	ZipArchive *zipArchive;
}

+ (ASZipEx *)sharedASZipEx;
- (void) dealloc;
/*
 @abstract filesPath中的每一项都是相对于local的相对路径；zipPath是绝对路径 currentPath是绝对路径
 @result 是否压缩成功  
 */
- (BOOL)zipFiles:(NSArray *)filesPath toZip:(NSString *)zipPath currentPath:(NSString *)currentPath;
/*
 @abstract zipPath是绝对路径 newPath是绝对路径
 @result 是否解压缩成功  
 */
- (BOOL)unZipFilePath:(NSString *)zipPath toPath:(NSString *)newPath;

/*
 @abstract files中的每一项是一个id<ASDataObject>；zipPath是绝对路径 currentDirectory是一个ASDirectoryEx的对象
 @result 是否压缩成功  
 */
- (BOOL)zipFiles:(NSArray *)files toZip:(NSString *)zipPath currentDirectory:(ASDirectoryEx *)currentDirectory;

/*
 @abstract zipfile是一个压缩文件的ASFileEx newPath是绝对路径
 @result 是否解压缩成功  
 */
- (BOOL)unZipFile:(ASFileEx *)zipfile toPath:(NSString *)newPath;
@end

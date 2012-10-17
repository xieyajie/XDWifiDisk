//
//  ASDataObject.h
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ASDataObject <NSObject>

/*------------------------------------------------------------------------------
   copy the file or directory
 @aDst:the copy destion
 @retval:1 is success or 0 is fail.
------------------------------------------------------------------------------*/
- (int) copyTo:(NSString*)aDst;
/*------------------------------------------------------------------------------
 @flag:get all files and directorys (YES)or 
       get files and directorys in level 1(NO) 
 @retval:an list of the directory contain
------------------------------------------------------------------------------*/
- (NSArray*) getFileList:(BOOL)flag;
/*------------------------------------------------------------------------------
 @retval:a file type flag
------------------------------------------------------------------------------*/
- (int) getFileType;
/*------------------------------------------------------------------------------
  move the file or directory
 @aDst:the move destion
 @retval:1 is success or 0 is fail.
------------------------------------------------------------------------------*/
- (int) moveTo:(NSString*)aDst;
/*------------------------------------------------------------------------------
 remove the file or directory
 @retval:1 is success or 0 is fail.
------------------------------------------------------------------------------*/
- (int) remove;
/*------------------------------------------------------------------------------
 rename the file or directory
 @aDst:a new name
 @retval:1 is success or 0 is fail.
------------------------------------------------------------------------------*/
- (int) rename:(NSString*)aDst;
/*------------------------------------------------------------------------------
 @retval:a file type string
------------------------------------------------------------------------------*/
- (NSString* const) getFileTypeString;
/*------------------------------------------------------------------------------
 @retval:a item name
------------------------------------------------------------------------------*/
- (NSString*) getItemName;
/*------------------------------------------------------------------------------
 @retval:a full item name
 ------------------------------------------------------------------------------*/
- (NSString*) getFullItemName;
/*------------------------------------------------------------------------------
 @retval:a item attribute dictionary
 ------------------------------------------------------------------------------*/
- (NSDictionary*) getItemAttr;
/*------------------------------------------------------------------------------
 @retval:YES to exist or NO to not exist
 ------------------------------------------------------------------------------*/
- (BOOL) isExist;
/*------------------------------------------------------------------------------
 @retval:a file extension to special a file's type(it's not neccussely
 ------------------------------------------------------------------------------*/
- (NSString*) getFileTypeExtension;

/*
    @function   - (NSDictionary *) getItemAttribution
    @abstract   get file attribute
    @param      none
    @result     NSDictionary * - a dictionary stored the attribute list
*/
- (NSDictionary *) getItemAttribution;

- (NSString *) getFileCreateDate;
@end

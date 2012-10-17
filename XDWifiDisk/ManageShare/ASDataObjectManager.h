//
//  ASDataObjectManager.h
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDataObject.h"
#import "ASFileEx.h"
#import "ASDirectoryEx.h"
@class ASClipBoard;

@interface ASDataObjectManager : NSObject 
{
    ASClipBoard* clipBoard;
    //id<ASDataObject> currentPath;
    id<ASDataObject> rootPath;
}

@property (nonatomic,retain) ASClipBoard* clipBoard;
//@property (nonatomic,assign) id<ASDataObject> currentPath;
@property (nonatomic,assign) id<ASDataObject> rootPath;

- (id) init;
/*------------------------------------------------------------------------------
 @aSrc:the item is going to copy
 @retval:1 is success or 0 is fail.
------------------------------------------------------------------------------*/
- (int) copyInClipBoard:(id<ASDataObject>)aSrc;
/*------------------------------------------------------------------------------
 @aSrc:the item is going to move
 @retval:1 is success or 0 is fail.
 -----------------------------------------------------------------------------*/
//- (int) move:(NSString*)aSrc;
- (int) moveInClipBoard:(id<ASDataObject>)aSrc;
/*------------------------------------------------------------------------------
 @aDst:the dest item 
 @retval:the number of item that success ot paste
 -----------------------------------------------------------------------------*/
- (int) pasteFromClipBoard:(id<ASDataObject>)aDst;
/*------------------------------------------------------------------------------
 @aFileName:the item is going to remove
 @retval:1 is success or 0 is fail.
 -----------------------------------------------------------------------------*/
- (int) remove:(id<ASDataObject>)aSrc;
/*------------------------------------------------------------------------------
 @aOldName:the item is going to rename
 @aNewName:the new name
 @retval:1 is success or 0 is fail.
 -----------------------------------------------------------------------------*/
- (int) rename:(NSString*)aOldName With:(NSString*)aNewName;
/*------------------------------------------------------------------------------
 @aFileName:the item is going to search
 @aSearchPath:the search path
 @retval:the search result.
 -----------------------------------------------------------------------------*/
- (NSArray*) search:(NSString*)aFileName From:(id<ASDataObject>)aSearchPath;
/*------------------------------------------------------------------------------
 clear the clip board
 -----------------------------------------------------------------------------*/
- (void) clearClipBoard;
/*------------------------------------------------------------------------------
 @aPath:a item path
 @retval:if Item is exist then return YES or return NO if it isn't.
 -----------------------------------------------------------------------------*/
- (BOOL) isItemExist:(id<ASDataObject>)aPath;
/*------------------------------------------------------------------------------
 get the single object
 -----------------------------------------------------------------------------*/
+(id) getDataManagerSingleObject;
/*------------------------------------------------------------------------------
 get the single object
 -----------------------------------------------------------------------------*/
- (id<ASDataObject>) getFileObject:(NSString*)aName 
                               And:(id<ASDataObject>)aParentItem;
/*------------------------------------------------------------------------------
 get the single object
 -----------------------------------------------------------------------------*/
- (id<ASDataObject>) getDirectoryObject:(NSString*)aName 
                                    And:(id<ASDataObject>)aParentItem;
/*------------------------------------------------------------------------------
 get the single object
 -----------------------------------------------------------------------------*/
- (NSString*) getRootPath;

@end

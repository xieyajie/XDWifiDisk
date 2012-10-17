//
//  ASDirectoryEx.h
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASFileEx.h"

@interface ASDirectoryEx : ASFileEx
{

}

/*------------------------------------------------------------------------------
 @aPath:the path to check
 @retval:return YES if the path is contained or return NO if it isn't.
 -----------------------------------------------------------------------------*/
- (BOOL) containDirectory;
/*------------------------------------------------------------------------------
 @retval:return array contains the search result.
 -----------------------------------------------------------------------------*/
- (NSArray*) searchFile:(NSString*)aFileName; 
/*------------------------------------------------------------------------------
 @retval:return array contains the search result.
 -----------------------------------------------------------------------------*/
- (int) addNewItem:(id<ASDataObject>)item;
@end

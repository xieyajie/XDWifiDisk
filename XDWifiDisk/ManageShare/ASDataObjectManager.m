//
//  ASDataObjectManager.m
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDataObjectManager.h"
#import "ASDataObject.h"
#import "ASClipBoard.h"
#import "ASDirectoryEx.h"
#import "ASFileEx.h"


@implementation ASDataObjectManager

@synthesize clipBoard;
//@synthesize currentPath;
@synthesize rootPath;
static ASDataObjectManager* singleObject=nil;

/*----------------------------------------------------------------------------*/
+(id) getDataManagerSingleObject
/*----------------------------------------------------------------------------*/
{
    if(singleObject==nil)
        singleObject=[[ASDataObjectManager alloc] init];
    return singleObject;
}
/*----------------------------------------------------------------------------*/
- (id) init
/*----------------------------------------------------------------------------*/
{
    self=[super init];
    if (self) {
        clipBoard=[[ASClipBoard alloc] init];
        //self.currentPath=[[ASDirectoryEx alloc] initWithFullPath:@""];
        NSMutableString *root=[[NSMutableString alloc] 
                               initWithString:NSHomeDirectory()];
        [root appendString:@"/Documents"];
        rootPath=[[ASDirectoryEx alloc] initWithFullPath:root];
        [root release];
    }
    return self;
}

/*----------------------------------------------------------------------------*/
//record a item
- (int) copyInClipBoard:(id<ASDataObject>)aSrc;
/*----------------------------------------------------------------------------*/
{
    self.clipBoard.copyOrMove=1;
    [self.clipBoard.clipData addObject:aSrc];
    return 1;
}

/*----------------------------------------------------------------------------*/
//move a item
- (int) moveInClipBoard:(id<ASDataObject>)aSrc;
/*----------------------------------------------------------------------------*/
{
    self.clipBoard.copyOrMove=0;
    [self.clipBoard.clipData addObject:aSrc];
    return 1;
}

/*----------------------------------------------------------------------------*/
//paste a item that has be record.
- (int) pasteFromClipBoard:(id<ASDataObject>)aDst;
/*----------------------------------------------------------------------------*/
{
    id<ASDataObject> dataObj=nil;
    int retval=0;
    
    
    for (int index=0; index<[clipBoard.clipData count]; index++) {
        dataObj=[clipBoard.clipData objectAtIndex:index];
 
        NSMutableString* temp=[[NSMutableString alloc] init];
        [temp appendString:[self getRootPath]];
    
        [temp appendString:[aDst getFullItemName]];
        
        [temp appendString:@"/"];
        [temp appendString:[dataObj getItemName]];
        
        retval+=(self.clipBoard.copyOrMove!=0)?
        [dataObj copyTo:temp]:
        [dataObj moveTo:temp];
        [temp release];
    }

    
    return retval;
}

/*----------------------------------------------------------------------------*/
//remove a item
- (int) remove:(id<ASDataObject>)aSrc;
/*----------------------------------------------------------------------------*/
{
    int retval=0;
    retval=[aSrc remove];    
    return retval;
}

/*----------------------------------------------------------------------------*/
//rename a item
- (int) rename:(NSString*)aOldName With:(NSString*)aNewName
/*----------------------------------------------------------------------------*/
{
    int retval=0;
    id<ASDataObject> dataObj=[[ASFileEx alloc] initWithFullPath:aOldName];
    retval=[dataObj rename:aNewName];
    [dataObj release];
    return retval;
}

/*----------------------------------------------------------------------------*/
//search a item in special path
- (NSArray*) search:(NSString*)aFileName From:(id<ASDataObject>)aSearchPath
/*----------------------------------------------------------------------------*/
{
    NSArray* retval=nil;
    if ([[aSearchPath getFileTypeString] isEqualToString:NSFileTypeDirectory]) {
        ASDirectoryEx* dir=(ASDirectoryEx*)aSearchPath;
        retval=[dir searchFile:aFileName];
    }
    return retval;
}

/*----------------------------------------------------------------------------*/
//clear the clip board
- (void) clearClipBoard
/*----------------------------------------------------------------------------*/
{
    [self.clipBoard.clipData removeAllObjects];
}
/*----------------------------------------------------------------------------*/
- (BOOL) isItemExist:(id<ASDataObject>)aPath
/*----------------------------------------------------------------------------*/
{
    BOOL retval=NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSMutableString *path = [[NSMutableString alloc] init];
    
    NSString* root=[self getRootPath];
    [path appendString:root];    
    [path appendString:[aPath getFullItemName]];
    retval=[fileManager fileExistsAtPath:path];
    [fileManager release];
    [path release];
    return retval;
}
/*----------------------------------------------------------------------------*/
- (id<ASDataObject>) getFileObject:(NSString*)aName 
                               And:(id<ASDataObject>)aParentItem
/*----------------------------------------------------------------------------*/
{
    id<ASDataObject> retval=[[[ASFileEx alloc] initWithName:aName And:aParentItem] 
                             autorelease];
    return retval;
}
/*----------------------------------------------------------------------------*/
- (id<ASDataObject>) getDirectoryObject:(NSString*)aName 
                                    And:(id<ASDataObject>)aParentItem
/*----------------------------------------------------------------------------*/
{
    id<ASDataObject> retval=[[[ASDirectoryEx alloc] initWithName:aName 
                                                             And:aParentItem] 
                             autorelease];
    return  retval;
}
/*----------------------------------------------------------------------------*/
- (NSString*) getRootPath
/*----------------------------------------------------------------------------*/
{
    NSString* retval=nil;
    retval=[NSString stringWithString:((ASDirectoryEx*)(self.rootPath)).fullPath];
    return retval;
    
}
@end

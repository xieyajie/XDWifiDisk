//
//  ASFileEx.m
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDeclare.h"
#import "ASFileAttribute.h"
#import "ASFileEx.h"
#import "ASFileType.h"
#import "ASDataObjectManager.h"
#import "ASDirectoryEx.h"
#import "ASIconContain.h"

@interface ASFileEx(private)
- (void) getTheFileType;
@end

@implementation ASFileEx

@synthesize name;
@synthesize fullPath;
@synthesize fileStyle;
@synthesize parentPath;

static const NSString *fileOwnerName = @"admin";

/*----------------------------------------------------------------------------*/
- (id) initWithName:(NSString*)aName And:(id<ASDataObject>) aParentItem
/*----------------------------------------------------------------------------*/
{
    self=[super init];
    if (self) {
        NSString *full = [aParentItem getFullItemName];
        fullPath=[[NSString alloc] initWithString:[full stringByAppendingPathComponent:aName]];
        parentPath=[aParentItem retain];
        name=[[NSString alloc] initWithString:aName];
        [self getTheFileType];
    }
    return self;
}

/*----------------------------------------------------------------------------*/
- (id) initWithFullPath:(NSString*)aFullPath
/*----------------------------------------------------------------------------*/
{
    self=[super init];
    if (self) {
        fullPath = [aFullPath retain];
        fileStyle=-1;
        parentPath=nil;
        name = [[NSString alloc] initWithString:[fullPath lastPathComponent]];
        //[[fullPath lastPathComponent] retain];
//        [self getTheFileType]
        
    }
    return self;
}

//------------------------------------------------------------------------------
// - (BOOL) isDirectory
//------------------------------------------------------------------------------
- (BOOL) isDirectory
{
    NSFileManager* manager=[[NSFileManager alloc] init];
    NSMutableString *path = nil;    
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    NSString *temp_=[dataManager getRootPath];
    
    path=[[NSMutableString alloc] initWithString:temp_];
    [path appendString:@"/"];
    [path appendString:fullPath];
    
    BOOL isDir;
	
	BOOL isExist=[manager fileExistsAtPath:path isDirectory:&isDir];
    [manager release];
    [path release];
    
    if ([self isKindOfClass:[ASDirectoryEx class]]) {
        if (!isExist) {
            isDir=YES;
        }
    }
    return isDir;
}

/*----------------------------------------------------------------------------*/
- (void) getTheFileType
/*----------------------------------------------------------------------------*/
{
    self.fileStyle=-1;
    NSString* extension=[[self.name pathExtension] lowercaseString];
    
    NSDictionary *dict = [[[ASIconContain sharedIconContain] fileTypeList] retain];
    
    if(nil == [dict objectForKey:extension])
    {
        if(YES == [self isDirectory])
        {
            self.fileStyle = kDirectory;
        }
        else
        {
            self.fileStyle = kUnknow;
        }
    }
    else
    {
        self.fileStyle = [[dict objectForKey:extension] intValue];  
    }
    [dict release];
        
}
/*----------------------------------------------------------------------------*/
- (int) copyTo:(NSString*)aDst
/*----------------------------------------------------------------------------*/
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSMutableString *path = [[NSMutableString alloc] init];
    
    NSMutableString *filePath = [[NSMutableString alloc] init];
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    NSString *temp=[dataManager getRootPath];
    
//    BOOL isDire=NO;
    BOOL retval=NO;
    
//    [path appendString:temp];
    [filePath appendString:temp];

    if(aDst != nil)
    {
        [filePath appendString:[self getFullItemName]];
        [path appendString:aDst];
        
//        retval=[fileManager fileExistsAtPath:path isDirectory:&isDire];
//        if (retval&&isDire) 
        NSError *error = nil;
        retval=[fileManager copyItemAtPath:filePath 
                                    toPath:path 
                                     error:&error];
        NSLog(@"%s -- %@ -- %i",__func__,error,retval);
        
        if(0 == retval)
        {
            [fileManager removeItemAtPath:path error:&error];
            retval = [fileManager copyItemAtPath:filePath
                                          toPath:path
                                           error:&error];
        }
    }
    
    [fileManager release];
    [path release];
    [filePath release];
    return retval?1:0;
}

/*----------------------------------------------------------------------------*/
- (NSArray*) getFileList:(BOOL)flag
/*----------------------------------------------------------------------------*/
{
    return nil;
}

/*----------------------------------------------------------------------------*/
- (int) getFileType
/*----------------------------------------------------------------------------*/
{
    [self getTheFileType];
    return self.fileStyle;
}

/*----------------------------------------------------------------------------*/
- (int) moveTo:(NSString*)aDst
/*----------------------------------------------------------------------------*/
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSMutableString *path = [[NSMutableString alloc] init];
    
    NSMutableString *filePath = [[NSMutableString alloc] init];
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    NSString *temp=[dataManager getRootPath];
    
//    BOOL isDire=NO;
    BOOL retval=NO;
    
//    [path appendString:temp];
    [filePath appendString:temp];
//    [path appendString:@"/"];
//    [filePath appendString:@"/"];
    if(aDst != nil)
    {
        [filePath appendString:[self getFullItemName]];
        [path appendString:aDst];
        
//        retval=[fileManager fileExistsAtPath:path isDirectory:&isDire];
//        if (retval&&isDire) 
//        {
        NSError *error = nil;
            retval=[fileManager moveItemAtPath:filePath 
                                        toPath:path 
                                         error:&error];

        if(0 == retval)
        {
            [fileManager removeItemAtPath:path error:&error];
            retval = [fileManager copyItemAtPath:filePath
                                          toPath:path
                                           error:&error];
        }
            self.fullPath=aDst;
//        }
    }
    
    [fileManager release];
    [filePath release];
    [path release];
    return retval?1:0;
}

/*----------------------------------------------------------------------------*/
- (int) remove
/*----------------------------------------------------------------------------*/
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    NSMutableString *filePath = [[NSMutableString alloc] 
//                                 initWithString:NSHomeDirectory()];
    NSMutableString *filePath=nil;
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    
    BOOL retval=NO;
    BOOL isDire=NO;
    NSString *temp=[dataManager getRootPath];
    filePath=[[NSMutableString alloc] initWithString:temp];
    
    [filePath appendString:[self getFullItemName]];
    
    retval=[fileManager fileExistsAtPath:filePath isDirectory:&isDire];
    if (retval) {
        retval=[fileManager removeItemAtPath:filePath error:nil];
    }
    [fileManager release];
    [filePath release];
    return retval?1:0;
}

/*----------------------------------------------------------------------------*/
- (int) rename:(NSString*)aNewName
/*----------------------------------------------------------------------------*/
{
    NSMutableString *filePath = nil;
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    int retval=0;
    NSString *temp=[dataManager getRootPath];
    filePath=[[NSMutableString alloc] initWithString:temp];
//    [filePath appendString:@"/"];
    [filePath appendString:[self getFullItemName]];
    

    NSMutableString *newPath=[[NSMutableString alloc] 
                               initWithString:
                               [filePath stringByDeletingLastPathComponent]];
    [newPath appendString:@"/"];
    [newPath appendString:aNewName];
    
    NSMutableString *newFullPath = [[NSMutableString alloc] 
        initWithString:[[self getFullItemName] stringByDeletingLastPathComponent]];
    [newFullPath appendString:@"/"];
    [newFullPath appendFormat:@"%@",aNewName];
//    NSString* ret=[self getFullItemName];

    retval=[self moveTo:newPath];
    if (self.fullPath) 
    {
        self.fullPath=newFullPath;
    }
    
    self.name=aNewName;
    
    [newFullPath release];
    [filePath release];
    [newPath release];
    
    return retval;
}

/*----------------------------------------------------------------------------*/
- (NSString* const) getFileTypeString
/*----------------------------------------------------------------------------*/
{
    NSFileManager* manager=[[NSFileManager alloc] init];
    NSMutableString *path = nil;    
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    NSString *temp=[dataManager getRootPath];
    
    path=[[NSMutableString alloc] initWithString:temp];
    [path appendString:[self getFullItemName]];
    
    NSDictionary* fileAttr=[manager attributesOfItemAtPath:path 
                                                     error:nil];
    NSString* const filesType=[fileAttr objectForKey:NSFileType];
    [manager release];
    [path release];
    return filesType;
}
/*----------------------------------------------------------------------------*/
- (void)dealloc 
/*----------------------------------------------------------------------------*/
{
    [parentPath release];
    [fullPath release];
    [name release];
    [super dealloc];
}

/*----------------------------------------------------------------------------*/
- (NSString*) getItemName
/*----------------------------------------------------------------------------*/
{
    NSString* retval=[NSString stringWithString:name];
   
    return  retval;
}
/*----------------------------------------------------------------------------*/
- (NSString*) getFullItemName
/*----------------------------------------------------------------------------*/
{
    NSString* retval=nil;
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    

    if (self.parentPath==nil) {

        NSInteger length=[self.fullPath length];
        const char* cString=[self.fullPath cStringUsingEncoding:NSUTF8StringEncoding];
        
        if (cString[length-1]!='/') {
            retval=[NSString stringWithString:self.fullPath];
        }else{
//            retval = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
//            NSString *tmpString =[NSString stringWithCString:cString length:length-1];
//            NSLog(@"tmpString -- %@",tmpString);
            NSString *tmp = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
            retval = [tmp substringWithRange:NSMakeRange(0, length-1)];
//            NSLog(@"retval -- %@",retval);
        }
		
    }
    else
    {
        NSMutableString *temp=[[NSMutableString alloc] init];
        [temp appendString:[self.parentPath getFullItemName]];
        NSInteger length=[temp length];
        const char* cString=[temp cStringUsingEncoding:NSUTF8StringEncoding];
        if (cString[length-1]!='/') {
            [temp appendString:@"/"];
        }
                  
        [temp appendString:[self getItemName]];
        retval=[NSString stringWithString:temp];
        [temp release];
    }
    
    retval=[retval stringByReplacingOccurrencesOfString:[dataManager getRootPath]  
                                             withString:@"/"];
    
    return retval;
}

//------------------------------------------------------------------------------
// - (NSString *) getFileSize:(NSNumber *)aFileSize
//------------------------------------------------------------------------------
- (NSString *) getFileSize:(NSNumber *)aFileSize
{
    
    NSString *fileSize;
	int tmp = [aFileSize intValue];
	
	if(tmp >= 1024 && tmp < 1048576)
    {
		tmp = tmp / 1024;
		fileSize = [NSString stringWithFormat:@"%dKB",tmp];
	}
    else if (tmp >= 1048576) 
    {
		tmp = tmp / (1024*1024);
		fileSize = [NSString stringWithFormat:@"%dMB",tmp];
	}
    else if(tmp < 1024)
    {
		fileSize = [NSString stringWithFormat:@"%dB",tmp];
	}
    
    return fileSize;
}

- (NSString *) getFileCreateDate
{
    NSMutableString *path = [[NSMutableString alloc] init]; 
    NSFileManager* manager=[[NSFileManager alloc] init];
    
    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    NSString *temp=[dataManager getRootPath];
    [path appendString:temp];
    [path appendString:[self getFullItemName]];
    NSDictionary* fileAttr=[manager attributesOfItemAtPath:path 
                                                     error:nil];
    NSDate *create = [fileAttr valueForKey:NSFileCreationDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];
    NSString *fileCreation = [NSString stringWithString:
                              [dateFormatter stringFromDate:create]];
    
    [dateFormatter release];
    [path release];
    [manager release];
    
    return fileCreation;
}

//------------------------------------------------------------------------------
// - (NSString *) getCreateDate:(NSDate *)creation
//------------------------------------------------------------------------------
- (NSString *) getCreationDate:(NSDate *)creation
{
    //creation date
	NSDateFormatter *dateFormatter = [[[ASIconContain sharedIconContain] dateFormatter] retain];
    
    if(creation == nil)
    {
        creation = [NSDate date];
    }
	NSString *fileCreation = [NSString stringWithString:
                              [dateFormatter stringFromDate:creation]];
    
    [dateFormatter release];
    return fileCreation;
}

//------------------------------------------------------------------------------
// - (NSSting *) getModifyDate:(NSDate *)modify
//------------------------------------------------------------------------------
- (NSString *) getModifyDate:(NSDate *)modify
{
    //modify date
    NSDateFormatter *dateFormatter = [[[ASIconContain sharedIconContain] dateFormatter] retain];
    
    if(modify == nil)
    {
        modify = [NSDate date];
    }
	NSString *fileModify = [NSString stringWithString:
                            [dateFormatter stringFromDate:modify]];
    
    [dateFormatter release];
    return fileModify;
}

//------------------------------------------------------------------------------
// - (NSString *) getFileOwner:(NSString *) fileOwner
//------------------------------------------------------------------------------
- (NSString *) getFileOwner:(NSString *) aFileOwner
{
    NSString *fileOwner;
    //file owner
    if(nil == aFileOwner)
    {
        fileOwner = [NSString stringWithFormat:@"%@",fileOwnerName ];
    }
    else 
    {
        fileOwner = [NSString stringWithString:aFileOwner];
    }
    
    return fileOwner;
}

//------------------------------------------------------------------------------
// - (NSDictionary *) getItemAttribution
//------------------------------------------------------------------------------
- (NSDictionary *) getItemAttribution
{
    NSMutableDictionary *fileAttribute = [[[NSMutableDictionary alloc] init]
                                          autorelease];
    NSDictionary *itemAttr = [self getItemAttr];
    
    NSString *fileSize = [self getFileSize:[itemAttr objectForKey:NSFileSize]];
//    NSString *fileLocaion = [[self getFullItemName] 
//        stringByReplacingCharactersInRange:NSMakeRange(0, 1)
//        withString:@""];
    NSString *fileLocation = [self getFullItemName];
    NSString *fileCreate = [self getCreationDate:
                            [itemAttr objectForKey: NSFileCreationDate]];
    NSString *fileModify = [self getModifyDate:
                            [itemAttr objectForKey:NSFileModificationDate]];
    NSString *fileOwner = [self getFileOwner:
                           [itemAttr objectForKey:NSFileOwnerAccountName]];
    
    NSString *fileType = nil;
    NSString *extension = [self.name pathExtension];
    if([extension isEqualToString:@""])
    {
        if(YES == [self isDirectory])
        {
            fileType = [[ASDeclare singletonASDeclare] directoryType];
        }
        else
        {
            fileType = [[ASDeclare singletonASDeclare] UnkonwType];
        }
    }
    else
    {
        fileType = [self getFileTypeExtension];
    }
    
    [fileAttribute setObject:fileSize forKey:kFileSizeValue];
    [fileAttribute setObject:fileLocation forKey:kFileLocationValue];
    [fileAttribute setObject:fileCreate forKey:kFileCreateValue];
    [fileAttribute setObject:fileModify forKey:kFileModifyValue];
    [fileAttribute setObject:fileOwner forKey:kFileOwnerValue];
    [fileAttribute setObject:fileType forKey:kFileTypeValue];
    
    return fileAttribute ;
}

/*----------------------------------------------------------------------------*/
-(NSDictionary*) getItemAttr
/*----------------------------------------------------------------------------*/
{
    NSFileManager* manager=[NSFileManager defaultManager];
    NSDictionary* retval=nil;

    ASDataObjectManager* dataManager=[ASDataObjectManager 
                                      getDataManagerSingleObject];
    NSString *temp=[dataManager getRootPath];
    NSString *path = [NSString stringWithFormat: @"%@%@", temp, [self getFullItemName]];
    NSDictionary* fileAttr=[manager attributesOfItemAtPath:path 
                                                     error:nil];
    
    retval=[[[NSMutableDictionary alloc] initWithDictionary:fileAttr] 
            autorelease];
    
    return retval;
}

/*----------------------------------------------------------------------------*/
- (BOOL) isExist
/*----------------------------------------------------------------------------*/
{
    BOOL retval=NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSMutableString *path = [[NSMutableString alloc] init];
    ASDataObjectManager* dataManager=[ASDataObjectManager getDataManagerSingleObject];
    NSString* rootPath=[dataManager getRootPath];
 
    [path appendString:rootPath];
    [path appendString:[self getFullItemName]];
    retval=[fileManager fileExistsAtPath:path];
    [fileManager release];
    [path release];
    return retval;
}
/*----------------------------------------------------------------------------*/
- (NSString *) getFileTypeExtension
/*----------------------------------------------------------------------------*/
{
    return [[name pathExtension] lowercaseString];
}
@end

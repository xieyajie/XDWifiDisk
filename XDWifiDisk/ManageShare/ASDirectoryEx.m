//
//  ASDirectoryEx.m
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDirectoryEx.h"
#import "ASFileEx.h"
#import "ASDataObjectManager.h"

@implementation ASDirectoryEx

/*----------------------------------------------------------------------------*/
- (BOOL) containDirectory;
/*----------------------------------------------------------------------------*/
{
    BOOL retval=NO;
    BOOL isContain=NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSMutableString* directoryPath=[[NSMutableString alloc] init];
    ASDataObjectManager* dataManager=[ASDataObjectManager getDataManagerSingleObject];
    NSString* rootPath=((ASDirectoryEx*)(dataManager.rootPath)).fullPath;
    
    [directoryPath appendString:rootPath];
    [directoryPath appendString:self.fullPath];
    NSArray *content = [fileManager contentsOfDirectoryAtPath:directoryPath 
                                                        error:nil];
	
	for(int i=0; i < [content count]; i++)
    {
		NSMutableString *path = [[NSMutableString alloc] 
                                 initWithString:directoryPath];
		[path appendString:@"/"];
		[path appendString:[content objectAtIndex:i]];
		
		[fileManager fileExistsAtPath:path isDirectory:&isContain];
        
        retval=isContain?YES:retval;
		[path release];
	}

    [fileManager release];
    [directoryPath release];
    return retval;
}

/*----------------------------------------------------------------------------*/
- (NSArray*) searchFile:(NSString*)aFileName
/*----------------------------------------------------------------------------*/
{
    NSArray* retval=nil;
    if (nil==aFileName||[aFileName length]==0) {
        retval=[self getFileList:NO];
    }
    else
    {
        NSArray* list=[self getFileList:YES];

        NSMutableArray* temp=[[NSMutableArray alloc] init];
        for (int index=0; index<[list count]; index++) {
            id<ASDataObject> item=[list objectAtIndex:index];
            NSRange range=[[item getItemName] rangeOfString:aFileName];
            
            if (range.length!=0&&range.location!=NSNotFound) {
                [temp addObject:item];
            }
        }
        retval=[[[NSArray alloc] initWithArray:temp] autorelease];
        [temp release];
    }

    return retval;
}
/*----------------------------------------------------------------------------*/
- (NSArray*) getFileList:(BOOL)flag
/*----------------------------------------------------------------------------*/
{
    /*declare everything we need.*/
    NSMutableArray* array=[[NSMutableArray alloc] init];
    NSFileManager* manager=[[NSFileManager alloc] init];
    NSMutableString *path = [[NSMutableString alloc] init];
    ASDataObjectManager *dataManager=[ASDataObjectManager getDataManagerSingleObject]; 
    NSString* currentPath=[[NSString alloc] initWithString:[self getFullItemName]];
 //   NSArray* retval=nil;
    NSString* fileName=nil;
    NSString* root=[[dataManager getRootPath] copy];
    [path appendString: root]; 
    [path appendString:[self getFullItemName]];
    NSDirectoryEnumerator *enumer = nil;
    enumer = [manager enumeratorAtPath:path];
    
    while (fileName=[enumer nextObject]) 
    {        
        if (nil==fileName) {
            break;
        }
        
        NSArray* pathComponents=[fileName pathComponents];
        if (NO==flag&&[pathComponents count]>1) {
            continue;
        }
        NSMutableString* fileFullName=[[NSMutableString alloc] 
                                       initWithString:[self getFullItemName]];
        [fileFullName appendString:@"/"];
        [fileFullName appendString:fileName];
        BOOL isDir;
        [manager fileExistsAtPath:path isDirectory:&isDir];

        id<ASDataObject> obj=nil;

        Class cls=(NO==isDir)?[ASFileEx class]:[ASDirectoryEx class];
        obj= [[cls alloc] initWithFullPath:fileFullName];
        [array addObject:obj];
        [obj release];
        [fileFullName release];
        obj=nil;
        fileFullName=nil;
    }
    
//    retval=[[[NSArray arrayWithArray:array] retain] autorelease];
//    [array release];
    
    [currentPath release];
    [manager release];
    [path release];
    [root release];

    return [array autorelease];
}
/*----------------------------------------------------------------------------*/
- (int) addNewItem:(id<ASDataObject>)item
/*----------------------------------------------------------------------------*/
{
    NSMutableDictionary *fileAttribute = [[NSMutableDictionary alloc] init];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDate *createDate = [NSDate date];
    int retval = 0;
    NSMutableString *path = [[NSMutableString alloc] init];
    ASDataObjectManager* dataManager=[ASDataObjectManager getDataManagerSingleObject];
    NSString* rootPath=((ASDirectoryEx*)(dataManager.rootPath)).fullPath;
    [fileAttribute setObject:createDate forKey:NSFileCreationDate];
    
    [path appendString:rootPath];    
    [path appendString:[item getFullItemName]];
    if([ASDirectoryEx class] == [item class])
    {
    retval=[fileManager createDirectoryAtPath:path
                  withIntermediateDirectories:YES 
                                   attributes:fileAttribute
                                        error:nil];
    }
    else if([ASFileEx class] == [item class])
    {
        retval = [fileManager createFileAtPath:path
                                      contents:nil
                                    attributes:fileAttribute];
    }
    [fileAttribute release];
    [fileManager release];
    [path release];
    return retval;
}

///*----------------------------------------------------------------------------*/
//- (int) addNewDirectory:(NSString*)aNewDirectoryName
///*----------------------------------------------------------------------------*/
//{
//    /*all right...we declare values here*/
//    BOOL retval=NO;
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//	NSMutableString *path = [[NSMutableString alloc] 
//                             initWithString:NSHomeDirectory()];
//    [path appendString:@"/Documents/Local/"];
//    [path appendString:self.fullPath];
//    NSArray *filesTmp = [fileManager contentsOfDirectoryAtPath:path error:nil];
//    NSMutableArray *arrayForFile = [[NSMutableArray alloc] init];
//	NSString *file=nil;
//    NSString *regexString = nil;
//    NSRegularExpression *regular=nil;
//    int length=0;
//    NSString *fileForNew;
//	NSString *strFrom;
//	NSString *strTo;
//    int num;
//	int max = 0;
//    NSMutableDictionary *fileAttribute = [[NSMutableDictionary alloc] init];
//    NSDate *createDate = [NSDate date];
//    
//    /*now,declare is end.so the function is begin...*/
//    /*we search those files whose name matches the regular expression...*/
//    regexString=@"^untitled([(][0-9]+[)])?$";
//    [path appendString:@"/"];
//    regular= [[NSRegularExpression alloc] 
//              initWithPattern:regexString
//              options:NSRegularExpressionCaseInsensitive
//              error:nil];
//    for(int i = 0; i < [filesTmp count]; i++)
//    {
//        file = [[filesTmp objectAtIndex:i] lowercaseString];
//        NSUInteger numberOfMatches=0;
//        numberOfMatches=[regular numberOfMatchesInString:file 
//                                                 options:0
//                                                   range:NSMakeRange(0, [file length])];
//        if(numberOfMatches)
//        {
//            [arrayForFile addObject:file];
//        }
//        file=nil;
//    }
//    
//    /*a ha!we found all files whose name match the regular expression*/
//    /*then we will have the new file name and other things...*/
//    /*hold on!the game is going to end...*/
//    length= [@"untitled" length];
//    
//    if([arrayForFile count] >0 )
//    {
//		for (int j = 0; j < [arrayForFile count]; j++) 
//        {
//			NSString *fileN = [arrayForFile objectAtIndex:j];
//			if([fileN length] >= (length+3))
//            {
//				strFrom = [fileN substringFromIndex:length+1];
//				strTo = [strFrom substringToIndex:[strFrom length]-1];
//				num = [strTo intValue];
//                
//				if(num >= max)
//					max = num;
//			}
//		}
//		max++;
//		fileForNew = [NSString stringWithFormat:@"Untitled(%d)",max];
//	}
//    else 
//		fileForNew = [NSString stringWithFormat:@"Untitled"];
//    
//    [arrayForFile release];
//	[path appendString:fileForNew];
//    /*oh! finally,we create this file...it's a big work,isn't it?*/
//    [fileAttribute setObject:createDate forKey:NSFileCreationDate];
//    
//    retval=[fileManager createDirectoryAtPath:path
//                  withIntermediateDirectories:YES 
//                                   attributes:fileAttribute
//                                        error:nil];
//    /*don't forget these guys...*/
//    [fileManager release];
//    [path release];
//    [fileAttribute release];
//    [regular release];
//    /*good bye!*/
//    return retval;
//}


@end

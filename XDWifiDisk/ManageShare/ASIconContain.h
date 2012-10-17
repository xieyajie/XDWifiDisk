//------------------------------------------------------------------------------
//  Filename:       ASIconContain.h
//  Project:        ASVirtualHardDisk
//  Author:         Okay
//  Date:           11-12-30 : last edited by Okay
//  Version:        1.0
//  Copyright       2011年 AlphaStudio. All rights reserved.
//------------------------------------------------------------------------------
//  Quote the standard library header files.




#import <Foundation/Foundation.h>


@interface ASIconContain : NSObject 
{
    NSDictionary *dictplist;
    NSDictionary *fileTypeList;
    NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain) NSDictionary* fileTypeList;
@property (nonatomic, retain) NSDateFormatter* dateFormatter;

+ (id) sharedIconContain;
- (NSString *) getCustom:(NSString *) aSuffix;
@end

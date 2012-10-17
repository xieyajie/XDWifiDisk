//------------------------------------------------------------------------------
//  Filename:          ASIconContain.m
//  Project:           ASVirtualHardDisk
//  Author:            Okay
//  Date:              11-12-30 : last edited by Okay
//  Version:           1.0
//  Copyright:         2011年 AlphaStudio. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASIconContain.h"
#import "ASLocalDefine.h"


@implementation ASIconContain
@synthesize fileTypeList;
@synthesize dateFormatter;

static ASIconContain *iconContain;

+ (id) sharedIconContain
{
    if(nil == iconContain)
    {
        iconContain = [[ASIconContain alloc] init];
    }
    return iconContain;
}

- (NSString *) getCustom:(NSString *)aSuffix
{
    return [dictplist valueForKey:aSuffix];
}

- (void)getLocalTimeFormat
{
    NSLocale *currentLocale=[NSLocale autoupdatingCurrentLocale];
    NSString *localIdentifier = [currentLocale valueForKey: @"identifier"];  
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: localIdentifier];
    [dateFormatter setLocale:locale];
    [locale release];
}

- (id) init
{
    self = [super init];
    if(self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"customicon" ofType:@"plist"];
        dictplist = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"FileTypeList.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"FileTypeList" ofType:@"plist"];
        }
        
        NSDictionary *temp=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
        fileTypeList = [[temp objectForKey:@"TypeList"] copy];
        
        dateFormatter = [[NSDateFormatter alloc] init]; 
        [dateFormatter setTimeStyle:kCFDateFormatterMediumStyle];
        [dateFormatter setDateStyle:kCFDateFormatterShortStyle];
        [self getLocalTimeFormat];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLocalTimeFormat) name:NSCurrentLocaleDidChangeNotification object:nil];
        
        [temp release];
    }
    
    return self;
}

- (void) dealloc
{
    [dictplist release];
    [fileTypeList release];
    [dateFormatter release];
    iconContain = nil;
    [super dealloc];
}

@end

//
//  ASClipBoard.m
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASClipBoard.h"


@implementation ASClipBoard

@synthesize clipData;
@synthesize copyOrMove;

/*----------------------------------------------------------------------------*/
-(id) init
/*----------------------------------------------------------------------------*/
{
    self=[super init];
    if (self) {
        clipData=[[NSMutableArray alloc] init];
    }
    return self;
}
/*----------------------------------------------------------------------------*/
-(void)dealloc
/*----------------------------------------------------------------------------*/
{
    [clipData release];
    [super dealloc];
}

@end

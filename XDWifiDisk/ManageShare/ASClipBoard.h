//
//  ASClipBoard.h
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASClipBoard : NSObject {
    NSMutableArray* clipData;
    NSInteger copyOrMove;
}

@property (nonatomic,retain) NSMutableArray* clipData;
@property NSInteger copyOrMove;

@end

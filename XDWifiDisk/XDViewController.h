//
//  XDViewController.h
//  XDWifiDisk
//
//  Created by yajie xie on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASServerInfo.h"

@interface XDViewController : UIViewController
{
    ASServerInfo *serverInfo;
}

@property (nonatomic, readonly) ASServerInfo *serverInfo;

-(void)startServer;
-(void)stopServer;


@end

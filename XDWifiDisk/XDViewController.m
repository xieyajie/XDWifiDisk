//
//  XDViewController.m
//  XDWifiDisk
//
//  Created by yajie xie on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XDViewController.h"

@interface XDViewController ()

@end

@implementation XDViewController

@synthesize serverInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    serverInfo = [ASServerInfo singletonServer];
    [self startServer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [self stopServer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)startServer
{
    [serverInfo startFtpServer];
    [serverInfo startWebServer];
}

-(void)stopServer
{
    [serverInfo stopFtpServer];
    [serverInfo stopWebServer];
}

@end

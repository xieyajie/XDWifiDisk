//
//  XDViewController.m
//  XDWifiDisk
//
//  Created by yajie xie on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XDViewController.h"
#import "NetworkController.h"

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
    
    UILabel *contentFTPLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 200, self.view.frame.size.width, 200)];
    contentFTPLabel.backgroundColor = [UIColor redColor];
    UILabel *contentHTTPLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 400, self.view.frame.size.width, 200)];
    contentHTTPLabel.backgroundColor = [UIColor yellowColor];
    
    NSString *addr = [NetworkController localWifiIPAddress];
    if(![addr isEqualToString:@"error"])
    {
        contentFTPLabel.text = [NSString stringWithFormat:@"ftp://%@:20000", 
                                addr];
        contentHTTPLabel.text = [NSString stringWithFormat:@"http://%@", 
                                 addr];
    }
    [self.view addSubview: contentFTPLabel];
    [self.view addSubview: contentHTTPLabel];
    
    [contentFTPLabel release];
    [contentHTTPLabel release];
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

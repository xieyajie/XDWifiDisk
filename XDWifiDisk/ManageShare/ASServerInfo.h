//
//  ASServerInfo.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-28.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KREALIMAGE     @"realImage"
#define KSERVERSART    @"serverStart"
#define KSERVERNAME    @"serverName"
#define KEXTENSION     @"showExtension"

@class FtpServer;
@class ASWebServer;

@interface ASServerInfo : NSObject 
{
    @private
    ASWebServer *webServer;
	FtpServer *ftpServer;
	
    BOOL isRealImage;
    
	BOOL isServerStart;
    
    BOOL showExtension;
    
    NSString *serverName;
}

@property (nonatomic, retain) NSString *serverName;
@property (nonatomic, retain) NSFileHandle *file;
@property (nonatomic, retain) FtpServer *ftpServer;
@property (nonatomic) BOOL isServerStart;
@property (nonatomic) BOOL isRealImage;
@property (nonatomic) BOOL showExtension;

/*
    @function   + (id) singletonServer
    @abstract   create the single server
    @param      none
    @result     id - a pointer pointed to server 
*/
+ (id) singletonServer;

/*
    @function   - (void) startServer
    @abstract   start ftp server
    @param      none
    @result     void
*/
- (void) startFtpServer;

/*
    @function   - (void) stopServer
    @abstract   stop ftp server
    @param      none
    @result     void
*/
- (void) stopFtpServer;

- (void) startWebServer;

- (void) stopWebServer;

/*
    @function   - (void) dealloc
    @abstract   dealloc
    @param      none
    @result     void
*/
- (void) dealloc;

- (void) recordStatusOfServer;

#pragma mark -
#pragma mark initial the server info
- (BOOL) isExistConfigFile;
- (void) createConfigFile;
- (void) serverInitial;

@end

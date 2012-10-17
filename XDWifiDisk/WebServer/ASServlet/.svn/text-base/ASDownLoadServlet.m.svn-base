//
//  ASDownLoadServlet.m
//  ASVirtualHardDisk
//
//  Created by Okay on 11-12-1.
//  Copyright (c) 2011年 AlphaStudio. All rights reserved.
//

#import "ASDownLoadServlet.h"
#import "ASDataObjectManager.h"
#import "ASDataObject.h"
#import "ASLocalDefine.h"

@implementation ASDownLoadServlet

- (ServletResponse *)doGet:(ServletRequest *)request 
{
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
	
    NSDictionary *params = request.parameters;
    
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *path = [[params valueForKey:@"filePath"] 
                      stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSString* test = [[params valueForKey:@"filePath"] 
//                      stringByReplacingPercentEscapesUsingEncoding:enc];
    
    ASDataObjectManager *dataManager = [ASDataObjectManager getDataManagerSingleObject];
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:[dataManager getRootPath]];
    [filePath appendString:path];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: filePath]) 
    {
        Servlet *servlet = [[[Servlet alloc] init] autorelease];
        [filePath release];
        return [servlet sendNotFound];
    }
        
    struct mgstat stp;
    mg_stat([filePath UTF8String], &stp);
    handle_download_request(connect, [filePath UTF8String], &stp);

    [filePath release];
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    resp.bodyString = [NSString stringWithCString:[path UTF8String] encoding:NSUTF8StringEncoding];

    [resp addHeader:@"Content-Type" withValue:@"application/octet-stream"];
    [resp addHeader:@"Content-Disposition" withValue:[NSString stringWithFormat:@"attachment;filename=%@",[path lastPathComponent]]];
    return nil;
}

- (ServletResponse *)doPost:(ServletRequest *)request 
{
    return [self doGet:request];
}

- (void)logPath:(NSString *)path 
{
    NSLog(@"ASDownLoadServlet");
}

@end

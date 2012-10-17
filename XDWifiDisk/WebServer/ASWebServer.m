//------------------------------------------------------------------------------
//  Filename:          ASWebServer.m
//  Project:           ASVirtualHardDisk
//  Author:             Okay
//  Date:              11-11-21 : last edited by  Okay
//  Version:           1.0
//  Copyright:         2011年 AlphaStudio. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASCreateFolderServlet.h"
#import "ASDeleteServlet.h"
#import "ASDownLoadServlet.h"
#import "ASFileListServlet.h"
#import "ASFileSearchServlet.h"
#import "ASUploadServlet.h"
#import "ASWebServer.h"
#import "MongooseServer.h"

//servlet path
static  NSString *const kCreateFolderServle = @"/(-mod-)/createfolder.mod";
static  NSString *const kDeleteServlet = @"/(-bin-)/action.tfs";
static  NSString *const kUploadServlet = @"/upload.tfs";
static  NSString *const kFileListServlet = @"/(-xml-)";
static  NSString *const kFileDownLoadServlet = @"/(-bin-)/downLoad.tfs";
static  NSString *const kFileSearchServlet = @"";

@implementation ASWebServer
//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc
{
    
    [webServer release];
    NSLog(@"ASWebServer Release");
    [super dealloc];
}

//------------------------------------------------------------------------------
// - (void) startServer
//------------------------------------------------------------------------------
- (void) startServer
{
    if (!webServer)
    {
        webServer = [[MongooseServer alloc] initWithPort:8000 allowDirectoryListing:YES];
    }
    
    //register the servlets to the webServer
    
    //add the delete servlet to the container
    ASDeleteServlet *deleteServlet = [[ASDeleteServlet alloc] init];
    [webServer addServlet:deleteServlet forPath:kDeleteServlet];
    [deleteServlet release];
    
    //add the create folder servlet to the container
    ASCreateFolderServlet *createFolderServlet = [[ASCreateFolderServlet alloc] init];
    [webServer addServlet:createFolderServlet forPath:kCreateFolderServle];
    [createFolderServlet release];
    
    //add the upload servlet to the container
    ASUploadServlet *uploadServlet = [[ASUploadServlet alloc] init];
    [webServer addServlet:uploadServlet forPath:kUploadServlet];
    [uploadServlet release];
    
    //add the data request servlet to the container
    ASFileListServlet *fileListServlet = [[ASFileListServlet alloc] init];
    [webServer addServlet:fileListServlet forPath:kFileListServlet];
    [fileListServlet release];
    
    //add the search file servlet to the container
    ASFileSearchServlet *searchServlet = [[ASFileSearchServlet alloc] init];
    [webServer addServlet:searchServlet forPath:kFileSearchServlet];
    [searchServlet release];
    
    //add down load servlet to container
    ASDownLoadServlet *downLoadServlet = [[ASDownLoadServlet alloc] init];
    [webServer addServlet:downLoadServlet forPath:kFileDownLoadServlet];
    [downLoadServlet release];
}

//------------------------------------------------------------------------------
// - (void) stopServer
//------------------------------------------------------------------------------
- (void) stopServer
{
     if(webServer)
     {
         //remove servelet from the container
         [webServer removeServletForPath:kDeleteServlet];
         [webServer removeServletForPath:kCreateFolderServle];
         [webServer removeServletForPath:kUploadServlet];
         [webServer removeServletForPath:kFileListServlet];
         [webServer removeServletForPath:kFileSearchServlet];
         [webServer removeServletForPath:kFileDownLoadServlet];
         
         [webServer release];
         webServer = nil;
     }
}

@end

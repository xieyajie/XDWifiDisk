//
//  MoongoseServer.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "MongooseServer.h"

@implementation MongooseServer

#define kRequestMethodPost 0
#define kRequestMethodGet 1

const char *getFileRootPath(ServletRequest *postRequest);
char *getFileDataByPost(struct mg_connection *conn, ServletRequest *postRequest);

void *handleRequest(enum mg_event event,
                    struct mg_connection *conn,
                    const struct mg_request_info *request_info);

@synthesize servlets;
@synthesize ctx;

char *getFileDataByPost(struct mg_connection *conn, ServletRequest *postRequest)
{
    const char *cl;
    int len;
    
    if ((cl = mg_get_header(conn, "Content-Length")) != NULL) {   
        printf("%s",cl);
        len = atoi(cl);
        return mg_readByPage(conn, len, kRequestMethodPost, getFileRootPath(postRequest));
    }
    
    return nil;
}

const char *getFileRootPath(ServletRequest *postRequest)
{
    NSDictionary *params = postRequest.parameters;
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *directory = [[params valueForKey:@"filePath"] 
                           stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileRootPath = [[[NSString alloc] initWithFormat:@"%@%@", documentsDirectory, directory] autorelease];
    
    return [fileRootPath UTF8String];
}


void *handleRequest(enum mg_event event,
                    struct mg_connection *conn,
                    const struct mg_request_info *request_info) 
{
    
    ServletResponse *response = nil;
    
    MongooseServer *server = (MongooseServer *)request_info->user_data;
    
    // Reads the body of the request
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    
    
    NSString *path = [NSString stringWithUTF8String:request_info->uri];
    
    if ([path rangeOfString:@"/(-bin-)/downLoad.tfs"].location != NSNotFound)
    {
        path = @"/(-bin-)/downLoad.tfs";
    }
    
    // Search for a servlet to respond to the exact path
    
    Servlet *servlet = [server.servlets valueForKey:path];
    
    // If an exact match is not found, tries to match wildcard servlets
    if (!servlet) {
        for (NSString *servletPath in server.servlets) {
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"self LIKE %@", servletPath];
            if ([pred evaluateWithObject:path]) {
                servlet = [server.servlets valueForKey:servletPath];
            }
        }
    }
    
    if (servlet) 
    {
        servlet.connect = conn;
        ServletRequest *request = [[[ServletRequest alloc] initWithRequestInfo:request_info body: nil] autorelease];
        
        if (strcmp(request_info->request_method, "GET") == 0) 
        {
            response = [servlet doGet:request];
        } 
        else if (strcmp(request_info->request_method, "POST") == 0) 
        {
            //response = [servlet doPost:postRequest];
            char *filename = getFileDataByPost(conn, request);
            response = [servlet returnPostResult:filename];
            free(filename);
        }
        
    } 
    else
    {
        
        // If directory listing is enabled and no servlet was found, let
        // Mongoose handle it
        
        if (strcmp(mg_get_option(server.ctx, "enable_directory_listing"), "yes") == 0) {
            
            return NULL;
            
        } 
        else 
        {
            
            // If no servlets were found to respond, sends a 404 error
            
            servlet = [[[Servlet alloc] init] autorelease];
            response = [servlet sendNotFound];
        }
    }
    
    //memory is not leak
    //it is freed by C
    NSData *resp = [[response toBinary] retain];
    
    mg_write(conn, [resp bytes], [resp length]);
    
    [resp release];
    [pool release];
    
    return "handled";
}


- (id)initWithPort:(int)port allowDirectoryListing:(BOOL)listing {
    if ((self = [super init])) {
        
        NSString *portStr = [NSString stringWithFormat:@"%d", port];
        
        //----------------------------------------------------------
        // Modified by dai Yunxing
        NSString *webPage = @"/Library/webPage/webCh";
        NSMutableString *rootPath = [[NSMutableString alloc] 
                                     initWithString:NSHomeDirectory()];
        [rootPath appendString:webPage];
        NSLog(@"RootPath -- %@",rootPath);
        //----------------------------------------------------------
        
        const char *options[] = {
            "document_root", [rootPath UTF8String],//[NSHomeDirectory() UTF8String],
            "listening_ports", [portStr UTF8String],
            "enable_directory_listing", listing ? "yes" : "no",
            NULL
        };
        
        //---
        [rootPath release];
        
        ctx = mg_start(handleRequest, self, options);
        
        servlets = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (id)initWithOptions:(const char *[])options {
    
    if ((self = [super init])) {
        
        ctx = mg_start(handleRequest, self, options);
        
        servlets = [[NSMutableDictionary alloc] init];
        
    }
    return self;

}

- (void)dealloc {
    
    mg_stop(ctx);
    [servlets release];
    NSLog(@"MongooseServer Release");
    [super dealloc];
}

- (void)addServlet:(Servlet *)servlet forPath:(NSString *)path {
    [servlets setValue:servlet forKey:path];
}

- (void)removeServletForPath:(NSString *)path {
    [servlets removeObjectForKey:path];
}

@end

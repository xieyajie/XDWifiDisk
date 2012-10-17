//------------------------------------------------------------------------------
//  Filename:          ASFileSearchServlet.m
//  Project:           MongooseWrapper
//  Author:             Okay
//  Date:              11-11-15 : last edited by  Okay
//  Version:           1.0
//  Copyright:         2011年 __MyCompanyName__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASFileSearchServlet.h"
#import "ASFileListXML.h"
#import "ASLocalDefine.h"

@implementation ASFileSearchServlet


- (ServletResponse *)doGet:(ServletRequest *)request {
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
	
//    NSDictionary *params = request.parameters;
    
//    NSString *directory = [params valueForKey:@"directory"];
    
    ASFileListXML *fileXML = [ASFileListXML getFileListXMLSingleObject];
    [fileXML makeFileListXML:@"/"];
    NSData *xmlData = [fileXML xmlDataFromRequest:@"/"];
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    //    resp.bodyString = [NSString stringWithFormat:@"%@ upload successfully.", @"AA"];
    resp.bodyString = [NSString stringWithCString:[xmlData bytes] encoding:NSUTF8StringEncoding];
    [resp addHeader:@"Content-Type" withValue:@"text/xml"];
    
    return resp;
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    return [self doGet:request];
}

- (void)logPath:(NSString *)path 
{
    NSLog(@"%@",Kfilerequest);
}

@end

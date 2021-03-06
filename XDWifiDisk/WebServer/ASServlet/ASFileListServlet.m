//------------------------------------------------------------------------------
//  Filename:          ASFileListServlet.m
//  Project:           MongooseWrapper
//  Author:             Okay
//  Date:              11-11-13 : last edited by  Okay
//  Version:           1.0
//  Copyright:         2011年 __MyCompanyName__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASFileListServlet.h"
#import "ASFileListXML.h"
#import "ASLocalDefine.h"

@implementation ASFileListServlet

- (ServletResponse *)doGet:(ServletRequest *)request {
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
	
    NSDictionary *params = request.parameters;
    
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *path = [[params valueForKey:@"filePath"] 
                      stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //xieyajie add
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:documentsDirectory];
    [filePath appendString: path];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *tmpStatusCode;
    if (![fm fileExistsAtPath:filePath]) 
    {
        tmpStatusCode = [[NSString alloc] initWithString:@"404 Not Found"];
    }
    else
    {
        tmpStatusCode = [[NSString alloc] initWithString: @"200 OK"];
    }
    [filePath release];    
    //end
    
    ASFileListXML *fileXML = [ASFileListXML getFileListXMLSingleObject];
//    [fileXML makeFileListXML:path];
    NSData *xmlData = [fileXML xmlDataFromRequest:path];
    //NSData *xmlData = [fileXML xmlDataFromRequest:filePath];
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = tmpStatusCode;
    resp.bodyString = [NSString stringWithCString:[xmlData bytes] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resp.bodyString);
    [resp addHeader:@"Content-Type" withValue:@"text/xml"];
    
    [tmpStatusCode release];
    return resp;
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    return [self doGet:request];
}

- (void)logPath:(NSString *)path 
{
    NSLog(@"ASFileListServlet");
}


@end

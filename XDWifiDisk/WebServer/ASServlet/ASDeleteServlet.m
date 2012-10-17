// Quote the header file(s).

#import "ASDeleteServlet.h"
#import "ASDataObjectManager.h"
#import "ASDirectoryEx.h"
#import "ASDataObject.h"
#import "ASLocalDefine.h"

@implementation ASDeleteServlet

- (ServletResponse *)doGet:(ServletRequest *)request 
{
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    NSDictionary *params = request.parameters;
    
//    NSString *action = [params valueForKey:@"action"];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *fileName = [[params valueForKey:@"filename"] 
                          stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    ASDataObjectManager *dataManager = [ASDataObjectManager getDataManagerSingleObject];
    
    ASFileEx *file = [[ASFileEx alloc] initWithFullPath:fileName];
    
    [dataManager remove:file];
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    resp.bodyString = [NSString stringWithFormat:@"%@ delete",fileName ];
    [resp addHeader:@"Content-Type" withValue:@"text/plain"];
    [file release];
    return resp;
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    return [self doGet:request];
}

- (void)logPath:(NSString *)path {
    NSLog(@"ASDeleteServlet");
}

@end

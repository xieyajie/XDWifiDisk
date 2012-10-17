//
//  UploadServlet.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/13/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "ASUploadServlet.h"
#import "ASLocalDefine.h"

char *subContent(const char *s,int n1,int n2);


@implementation ASUploadServlet

/*从s中提取下标为n1~n2的字符组成一个新字符串，然后返回这个新串的首地址*/
char *subContent(const char *s,int start,int len) 
{ 
    char *sp=malloc(sizeof(char)*(len + 1)); 
    int i,j=0; 
    for (i=start; i<(start + len); i++) { 
        sp[j]=s[i]; 
        j++;
    } 
    sp[j]=0; 
    return sp; 
} 


- (ServletResponse *)returnPostResult:(char *)filename 
{
    NSString *fileNameStr = [[NSString alloc] initWithCString:filename encoding:NSUTF8StringEncoding];
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    resp.bodyString = [NSString stringWithFormat:@"%@ upload successfully.", fileNameStr];
    [resp addHeader:@"Content-Type" withValue:@"text/plain"];
    
    return resp;
}

- (ServletResponse *)doPost:(ServletRequest *)request 
{
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    // WARNING: This is not a particularly robust implementation of the multipart
    // form data standard. It should work only for cases where there is a single
    // file element in the request.
    
    NSDictionary *params = request.parameters;
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *directory = [[params valueForKey:@"filePath"] 
                           stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    NSString *contentType = [request.headers valueForKey:@"Content-Type"];
//    NSArray *comps = [contentType componentsSeparatedByString:@";"];
    
    if ([contentType rangeOfString:@"multipart/form-data"].location == NSNotFound) {
        return [self sendInternalError];
    }
    
//    NSArray *bounds = [[comps objectAtIndex:1] componentsSeparatedByString:@"="];
//    NSString *boundary = [bounds objectAtIndex:1];
    
    //get file name
    const char *beginPostData = [request.body bytes];
    const char *upfilePostdata = beginPostData;
    const char *tmpPostData = beginPostData;
    int postDataLength = [request.body length];
    
    //upfilePostdata = findNewLine(upfilePostdata);
    
    for(int i = 0; i < 3; i++)
    {
        upfilePostdata += 2;
        tmpPostData = upfilePostdata; 
        
        //upfilePostdata = findNewLine(upfilePostdata);
    }
    
    int fileNameLength = upfilePostdata - tmpPostData;
    
    char *fileName_ = (char*)malloc(fileNameLength + 1);
    memcpy(fileName_, tmpPostData, fileNameLength);
    fileName_[fileNameLength] = '\0';
    NSString *fileNameStr = [NSString stringWithCString:fileName_ encoding:NSUTF8StringEncoding];
    NSLog(@"%s -- %@",__func__,fileNameStr);
    free(fileName_);
    
    // Reads the actual data
    for(int j = 0; j < 4; j++)
    {
        upfilePostdata += 2;
        upfilePostdata = findNewLine(upfilePostdata);
    }
    
    upfilePostdata += 2;
    
    int endFixLength = 153;
    int startFixLength = upfilePostdata - beginPostData;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:documentsDirectory];
    [filePath appendString:@"/"];
    [filePath appendString:directory];
    [filePath appendString:fileNameStr];
    
    int totalLenth = postDataLength - startFixLength - endFixLength;
    int start =  0;
    int size = 1 * 1024 * 1024;
    const char *header = upfilePostdata;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: filePath]) 
    {
        [[NSFileManager defaultManager] createFileAtPath: filePath contents:nil attributes:nil];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath: filePath]; 
    NSData *tmpData = [[NSData alloc] init];
    while (start < totalLenth) 
    {
        
        int s = (totalLenth - start - size) < 0 ? (totalLenth % size) : size;
        char *content = subContent(header, start, s);
        tmpData = [tmpData initWithBytes: content length: s];
        //save        
        [fileHandle seekToEndOfFile];
        [fileHandle writeData: tmpData];

        start = start + s;
        free(content);
    }    
    
    [tmpData release];
    [filePath release];
    filePath = nil;
    
    
    // Saves the file to the documents folder
    
    /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:documentsDirectory];
    [filePath appendString:@"/"];
    [filePath appendString:directory];
    [filePath appendString:fileNameStr];*/
    
//  NSString *file = [documentsDirectory stringByAppendingPathComponent:fileNameStr];
    /*NSLog(@"UPLOAD TO PATH %@",filePath);
    BOOL resule = [actualData writeToFile:filePath atomically:YES];
    [actualData release];
    actualData = nil;
    [filePath release];
    filePath = nil;*/
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    resp.bodyString = [NSString stringWithFormat:@"%@ upload successfully.", fileNameStr];
    [resp addHeader:@"Content-Type" withValue:@"text/plain"];
    
    return resp;
}

- (void)logPath:(NSString *)path {
    NSLog(@"ASUploadServlet");
}

@end

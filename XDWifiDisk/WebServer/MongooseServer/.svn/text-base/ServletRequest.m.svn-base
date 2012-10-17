//
//  ServletRequest.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "ServletRequest.h"


@implementation ServletRequest

@synthesize requestInfo;
@synthesize path;
@synthesize headers;
@synthesize parameters;
@synthesize body;

- (void)extractParametersFrom:(NSString *)string {
    
    NSArray *paramsStr = [string componentsSeparatedByString:@"&"];
   
    for (NSString *param in paramsStr) {
        NSArray *vals = [param componentsSeparatedByString:@"="];
        [parameters setValue:[vals objectAtIndex:1] forKey:[vals objectAtIndex:0]];
    }
}

- (id)initWithRequestInfo:(const struct mg_request_info *)ri body:(NSData *)bd {
    self = [super init];
    if (self) 
    {
        
        requestInfo = ri;
        body = [bd retain];
        
        path = [[NSString stringWithUTF8String:ri->uri] retain];
        
        BOOL isPost = strcmp(ri->request_method, "POST") == 0;
        
        headers = [[NSMutableDictionary alloc] initWithCapacity:ri->num_headers];
        parameters = [[NSMutableDictionary alloc] init];
        
        // Extract all headers from the request
        
        for (int i = 0; i < ri->num_headers; i++) {
            
            NSString *name = [NSString stringWithUTF8String:ri->http_headers[i].name];
            NSString *val = [NSString stringWithUTF8String:ri->http_headers[i].value];
            
            [headers setValue:val forKey:name];
            
            // If it's a form POST, extract parameters from the request body
            
            if (isPost && [name isEqualToString:@"Content-Type"] && [val isEqualToString:@"application/x-www-form-urlencoded"]) {
                NSString *strBody = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                [self extractParametersFrom:strBody];
                [strBody release];
            }
        }
        
        // Extract parameters from query string, if any
        
        if (ri->query_string != NULL) {
            
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSString *filePath = [[NSString alloc] initWithCString: (const char*)ri->query_string
                                                          encoding: NSUTF8StringEncoding];
            if (filePath) {
                [filePath release];
                filePath = [[NSString alloc] initWithCString: (const char*)ri->query_string
                                                    encoding: enc];
            }
            
            NSString *query = [NSString stringWithString: filePath];
            [self extractParametersFrom:query];
            [filePath release];
        }
    }
    
//    NSLog(@"From %s Hearders: %@ Parameters: %@",__func__,headers,parameters);
    
    return self;
}

- (void)dealloc {
    [path release];
    [headers release];
    [parameters release];
    [body release];
    [super dealloc];
}

@end

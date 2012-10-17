//------------------------------------------------------------------------------
//  Filename:       ASFileListServlet.h
//  Project:        MongooseWrapper
//  Author:          Okay
//  Date:           11-11-13 : last edited by  Okay
//  Version:        1.0
//  Copyright       2011年 __MyCompanyName__. All rights reserved.
//------------------------------------------------------------------------------
//  Quote the standard library header files.




#import <Foundation/Foundation.h>
#import "Servlet.h"

@interface ASFileListServlet : Servlet 
{
   
}

- (void)logPath:(NSString *)path;

@end

//------------------------------------------------------------------------------
//  Filename:          ASFileListXML.m
//  Project:           MongooseWrapper
//  Author:             Okay
//  Date:              11-11-13 : last edited by  Okay
//  Version:           1.0
//  Copyright:         2011年 __MyCompanyName__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASFileListXML.h"
#import "ASDataObjectManager.h"
#import "ASDataObject.h"
#import "ASFileAttribute.h"
#include <libxml/encoding.h>
#include <libxml/xmlwriter.h>


@implementation ASFileListXML

static ASFileListXML *fileListXML = nil; 

+ (id) getFileListXMLSingleObject
{
    if(fileListXML == nil)
        fileListXML = [[ASFileListXML alloc] init];
    
    return fileListXML;
}

- (void) dealloc
{
    fileListXML = nil;
    
    [super dealloc];
}

- (xmlChar *) xmlCharPtrForInput:(const char *)_input withEncoding:(const char *)_encoding  
{
    xmlChar *_output;
    int _ret;
    int _size;
    int _outputSize;
    int _temp; 
    xmlCharEncodingHandlerPtr _handler; 
    
    if (_input == 0)
        return 0;  
    
    _handler = xmlFindCharEncodingHandler(_encoding);
    
    if (!_handler)
    { 
        NSLog(@"convertInput: no encoding handler found for '%s'\n", (_encoding ? _encoding : ""));
        return 0;
    }
    
    _size = (int) strlen(_input) + 1;
    _outputSize = _size * 2 - 1;
    _output = (unsigned char *) xmlMalloc((size_t) _outputSize);
    
    if (_output != 0)
    { 
        _temp = _size - 1;
        _ret = _handler->input(_output, &_outputSize, (const xmlChar *) _input, &_temp);
        
        if ((_ret < 0) || (_temp - _size + 1)) 
        { 
            if (_ret < 0)
            {   
                NSLog(@"convertInput: conversion wasn't successful.\n");   
            } 
            else
            {
                NSLog(@"convertInput: conversion wasn't successful. Converted: %i octets.\n", _temp);
            }
            
            xmlFree(_output);
            _output = 0;
        } 
        else 
        {
            _output = (unsigned char *) xmlRealloc(_output, _outputSize + 1);
            _output[_outputSize] = 0;  /*null terminating out */ 
        }
    }
    else
    {
        NSLog(@"convertInput: no memory\n");
    }
    return _output;
} 

- (NSData *) xmlDataForSearch : (NSString *) aFileName
{
    //get the search result
    id<ASDataObject> root = [[ASDirectoryEx alloc] initWithFullPath:@"/"];
    ASDataObjectManager *dataManager = [ASDataObjectManager getDataManagerSingleObject];
    NSArray *searchResult = [dataManager search:aFileName From:root];
    [root release];
    
    //create the xml file
    xmlTextWriterPtr _writer;
    xmlBufferPtr     _buf;
    xmlChar         *_tmp;
    const char *_UTF8Encoding = "UTF-8";
    _buf = xmlBufferCreate();
    _writer = xmlNewTextWriterMemory(_buf, 0);
    
    // <?xml version="1.0" encoding="UTF-8"?>     
    xmlTextWriterStartDocument(_writer, "1.0", _UTF8Encoding, NULL); 
    
    //<Files>...</Files>
    xmlTextWriterStartElement(_writer, BAD_CAST "Files");
    
    //<FileData>...</FileData>
    for(int i = 0; i < [searchResult count]; i++)
    {
        id<ASDataObject> dataObj = [searchResult objectAtIndex:i];
        NSDictionary *dic = [dataObj getItemAttribution];
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileData");
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileName");
        _tmp = [self xmlCharPtrForInput:[[NSString stringWithFormat:@"%@",[dataObj getItemName]]
                                         cStringUsingEncoding:NSUTF8StringEncoding]
                           withEncoding:_UTF8Encoding];
        xmlTextWriterWriteString(_writer, _tmp);
        xmlTextWriterEndElement(_writer);
        xmlFree(_tmp);
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileCreation");
        _tmp = [self xmlCharPtrForInput:[[NSString 
                                          stringWithFormat:@"%@",[dic objectForKey:kFileCreateValue]] 
                                         cStringUsingEncoding:NSUTF8StringEncoding] 
                           withEncoding:_UTF8Encoding];
        xmlTextWriterWriteString(_writer, _tmp);
        xmlTextWriterEndElement(_writer);
        xmlFree(_tmp);
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileOwner");
        _tmp = [self xmlCharPtrForInput:[[NSString stringWithFormat:@"Admin"]
                                         cStringUsingEncoding:NSUTF8StringEncoding]
                           withEncoding:_UTF8Encoding];
        xmlTextWriterWriteString(_writer, _tmp);
        xmlTextWriterEndElement(_writer);
        xmlFree(_tmp);
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileLocation");
        _tmp = [self xmlCharPtrForInput:[[NSString stringWithFormat:@"%@",[dic objectForKey:kFileLocationValue]]
                                         cStringUsingEncoding:NSUTF8StringEncoding] 
                           withEncoding:_UTF8Encoding];
        xmlTextWriterWriteString(_writer, _tmp);
        xmlTextWriterEndElement(_writer);
        xmlFree(_tmp);
        
        xmlTextWriterEndElement(_writer);
    }
    
    xmlTextWriterEndDocument(_writer);
    
    xmlFreeTextWriter(_writer);      
    
    // turn libxml2 buffer into NSData* object     
    NSData *_xmlData = [NSData dataWithBytes:(_buf->content) length:(_buf->use)];  
    xmlBufferFree(_buf);
    
    return _xmlData; 
}

- (NSData *) xmlDataFromRequest : (NSString *) aDirectoryPath 
{     
    xmlTextWriterPtr _writer;     
    xmlBufferPtr _buf;     
    xmlChar *_tmp;     
    const char *_UTF8Encoding = "UTF-8";      
    _buf = xmlBufferCreate();    
    _writer = xmlNewTextWriterMemory(_buf, 0);      
    // <?xml version="1.0" encoding="UTF-8"?>     
    xmlTextWriterStartDocument(_writer, "1.0", _UTF8Encoding, NULL);
    
    //<Files>...</Files>
    xmlTextWriterStartElement(_writer, BAD_CAST "Files");
    
    //<FilePath>...</FilePath>
//    xmlTextWriterStartElement(_writer, BAD_CAST "FileData");
    
    xmlTextWriterStartElement(_writer, BAD_CAST "FilePath");
    _tmp = [self xmlCharPtrForInput:[[NSString stringWithString:aDirectoryPath] 
                                     cStringUsingEncoding:NSUTF8StringEncoding] 
                       withEncoding:_UTF8Encoding];     
    xmlTextWriterWriteString(_writer, _tmp);     
    xmlTextWriterEndElement(_writer); 
    xmlFree(_tmp);
//    xmlTextWriterEndElement(_writer);
    
    ASDirectoryEx *directroy = [[ASDirectoryEx alloc] initWithFullPath:aDirectoryPath];
    NSArray *files = [directroy getFileList:NO];
    [directroy release];
    // <FileData>...</fileData>          
    for(int i = 0; i < [files count]; i++)
    {
        id<ASDataObject> dataObj = [files objectAtIndex:i];
        NSDictionary *dic = [dataObj getItemAttribution];
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileData");
        
        //
        xmlTextWriterStartElement(_writer, BAD_CAST "FileName");     
        _tmp = [self xmlCharPtrForInput:[[NSString stringWithFormat:@"%@",[dataObj getItemName]] 
                                         cStringUsingEncoding:NSUTF8StringEncoding] 
                           withEncoding:_UTF8Encoding];     
        xmlTextWriterWriteString(_writer, _tmp);     
        xmlTextWriterEndElement(_writer); 
        
        // closing <username>     
        xmlFree(_tmp);     
        xmlTextWriterStartElement(_writer, BAD_CAST "FileCreate");     
        _tmp = [self xmlCharPtrForInput:[[NSString 
                                          stringWithFormat:@"%@",[dic objectForKey:kFileCreateValue]] 
                                         cStringUsingEncoding:NSUTF8StringEncoding] 
                           withEncoding:_UTF8Encoding];     
        xmlTextWriterWriteString(_writer, _tmp);     
        xmlTextWriterEndElement(_writer);
        // closing <password>     
        xmlFree(_tmp);      
        
        xmlTextWriterStartElement(_writer, BAD_CAST"FileSize");
        _tmp = [self xmlCharPtrForInput:[[NSString stringWithFormat:@"%@",[dic objectForKey:kFileSizeValue]]
                                         cStringUsingEncoding:NSUTF8StringEncoding]
                           withEncoding:_UTF8Encoding];
        xmlTextWriterWriteString(_writer, _tmp);
        xmlTextWriterEndElement(_writer);
        xmlFree(_tmp);
        
        xmlTextWriterStartElement(_writer, BAD_CAST "FileType");
        if(NSFileTypeDirectory == [dataObj getFileTypeString])
        {
            _tmp = [self xmlCharPtrForInput:[[NSString 
                                              stringWithString:@"folder"] 
                                             cStringUsingEncoding:NSUTF8StringEncoding] 
                               withEncoding:_UTF8Encoding]; 
        }
        else
        {
            _tmp = [self xmlCharPtrForInput:[[NSString 
                                              stringWithString:@"file"] 
                                             cStringUsingEncoding:NSUTF8StringEncoding] 
                               withEncoding:_UTF8Encoding]; 
        }
        xmlTextWriterWriteString(_writer, _tmp);
        xmlTextWriterEndElement(_writer);
        xmlFree(_tmp);
        
        //close <FileData>
        xmlTextWriterEndElement(_writer); 
    }
    
    //
    xmlTextWriterEndDocument(_writer);
    // closing <Files>      
    // etc.
    //    xmlTextWriterEndDocument(_writer); 
    xmlFreeTextWriter(_writer);      
    
    // turn libxml2 buffer into NSData* object     
    NSData *_xmlData = [NSData dataWithBytes:(_buf->content) length:(_buf->use)];  
    xmlBufferFree(_buf);
    
    return _xmlData; 
}

- (void) makeFileListXML:(NSString *)aDirectoryPath
{
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
    [filePath appendString:@"/Documents/data.xml"];
    NSData *data = [self xmlDataFromRequest:aDirectoryPath];
    [data writeToFile:filePath atomically:YES];
    
    [filePath release];
}

@end

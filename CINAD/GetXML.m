//
//  GetXML.m
//  KKAJRotate
//
//  Created by josepth on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GetXML.h"
#import "GDataXMLNode.h"
 
@implementation GetXML

 
/////////////////////////////////////////////////////////////////////////////////

+(NSMutableArray *)networkXML1:(NSString *) imgUrl nodes:(NSString *) nodes {
    NSURL *url = [NSURL URLWithString:imgUrl];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse* response;
    
    NSData* data =
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:nil];
    
    NSString *xmlString =
    [[NSString alloc] initWithData:data
                          encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]
                             initWithXMLString: xmlString
                             options:0
                             error:&error];
    if (doc == nil) { return nil ; }
    
    NSArray *partyMembers = [doc.rootElement nodesForXPath:nodes error:nil];
    
    NSMutableArray *array = [[[NSMutableArray alloc] init  ] autorelease ] ;
    
    for (GDataXMLElement *partyMember in partyMembers) {
        NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init  ] autorelease ] ;
        
        NSArray *elementArray = [partyMember elementsForName:@"link"];
        GDataXMLElement *gdataElement = (GDataXMLElement *)[elementArray objectAtIndex:0];
        NSLog(@"gdataElement.stringValue%@",gdataElement.stringValue) ;
        
        if (gdataElement.stringValue ==nil ) {
            [dic setObject: @"" forKey:@"link" ] ;
        }else
            [dic setObject: gdataElement.stringValue forKey:@"link" ] ;
        
        NSArray*elementArray2 = [partyMember elementsForName:@"enclosure"];
        GDataXMLElement*gdataElement2 = (GDataXMLElement *)[elementArray2 objectAtIndex:0];
        GDataXMLNode *imgLink = [gdataElement2 attributeForName:@"url"];
        
        //  NSLog(@"dd%@" , imgLink.stringValue      ) ;
        
        if (imgLink.stringValue ==nil ) {
            [dic setObject: @""  forKey:@"imgURL" ] ;
        }else
            [dic setObject: imgLink.stringValue  forKey:@"imgURL" ] ;
        
        [array addObject:dic ] ;
    }
    
    [xmlString release];
    return array;
}




+(NSMutableArray *)networkXML:(NSString *) imgUrl nodes:(NSString *) nodes {
    NSURL *url = [NSURL URLWithString:imgUrl];
   
     
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];    
    [request setURL:url];    
    [request setHTTPMethod:@"GET"]; 
    
    NSHTTPURLResponse* response;    
    
    NSData* data = 
    [NSURLConnection sendSynchronousRequest:request    
                          returningResponse:&response 
                                      error:nil];   
   
    NSString *xmlString = 
    [[NSString alloc] initWithData:data 
                          encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
 
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] 
                             initWithXMLString: xmlString
                             options:0 
                             error:&error];
    if (doc == nil) { return nil ; }
    
    NSArray *partyMembers = [doc.rootElement nodesForXPath:nodes error:nil];
    
    NSMutableArray *array = [[[NSMutableArray alloc] init  ] autorelease ] ;
    for (GDataXMLElement *partyMember in partyMembers) {
        [array addObject:  [GetXML createImage:  [partyMember stringValue  ]] ];
         
    }
     
    [xmlString release];
    return array;
}
 


+(UIImage * ) createImage:(NSString *) imgPath {
    
	NSData *imgData = [[NSData alloc] initWithContentsOfURL:
                       [NSURL URLWithString:imgPath]];
    UIImage *image =   [[[UIImage alloc] initWithData:imgData] autorelease ] ;
    
    [imgData release];
    return image;
}

@end

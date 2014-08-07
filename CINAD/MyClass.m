//
//  MyClass.m
//  WCHL
//
//  Created by josepth on 11-6-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyClass.h"
#import "TouchXMLKit.h"
@implementation MyClass

 

+(void ) createImage:(NSString *) imgPath:(UIImageView *)imgView{
    
	NSData *imgData = [[NSData alloc] initWithContentsOfURL:
                       [NSURL URLWithString:imgPath]];
    UIImage *image =   [[UIImage alloc] initWithData:imgData];
    
    [imgView setImage:image] ;
    [imgData release];
    [image release];
    
}

+(NSString *) fixHours:(NSString *)str
{ 
    NSString *h = @"";
    NSString *ms = @"";
    NSString *date=@"";
    
    if([str length] ==29   || [str length] ==31 )
    {
        h = [str substringWithRange:NSMakeRange(17, 2)  ];
        ms = [str substringWithRange:NSMakeRange(19, 3)  ];
        date=[str substringToIndex:17 ];
    }
    
    else
    {
        h = [str substringWithRange:NSMakeRange(16, 2)  ];
        ms = [str substringWithRange:NSMakeRange(18, 3)  ];
        date=[str substringToIndex:16];
    }
    NSUInteger number = [h integerValue] ;
   
    if(number>12)
    {
        number=number%12;

        date= [date stringByAppendingString:[NSString stringWithFormat:@"%d" , number]  ];
        date= [date stringByAppendingString:ms];
        date= [date stringByAppendingString:@" PM"];
    }
    else{
        
        date= [date stringByAppendingString:[NSString stringWithFormat:@"%d" , number]  ];       
        date= [date stringByAppendingString:ms];
        date= [date stringByAppendingString:@" AM"];
    }
    return date;
}
+(UIImage *) createImg:(NSString *) imgPath
{
	NSData *imgData = [[NSData alloc] initWithContentsOfURL:
                       [NSURL URLWithString:imgPath]];
    UIImage *image =   [[UIImage alloc] initWithData:imgData];
    [imgData release];
    return image;
    
}

+(NSString *) getListenTitle
{
    return @"Listening to CINAD";
}

+(NSString *) getConnectTitle
{
    return @"Press Play to Listen";
}
 
+(NSString *) getTitle
{
    return @"About CINAD";
}
+(NSString *) getlabel1
{
    return  @"CINAD";
}

+(NSString *) getlabel2
{
    return @" ";
}

+(NSString *) getlabel3
{
    return @" ";
}

+(NSString *) getlabel4
{
    return @" ";
}

+(NSString *) getTel
{
    return @" ";
}

+(NSString *) getlabel5
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"iphone_homeurl" ]    ;
}



+ (NSMutableDictionary *) parseADVRoot
{   //resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
    
    
    NSString * XMLPath =   [[NSUserDefaults standardUserDefaults] objectForKey:@"bannerGroupId"];
    
    //@"http://stagingapp1.intertechmedia.com/appx/bin/zarkAd.php" ;
    
    NSError *theError = NULL;
    NSData *XMLData = [NSData dataWithContentsOfURL: [NSURL URLWithString: XMLPath ]   ];
    CXMLDocument *document = [[CXMLDocument alloc]   initWithData: XMLData  options:0 error:&theError]   ;
    
    CXMLElement *root = [document rootElement];
    
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init]  ;
    
    
    for (CXMLElement *element in  [root children] )
    {
        if ([element isKindOfClass:[CXMLElement class]])
        {
            
            for (int i = 0; i < [element childCount]; i++)
            {
                if ([[element name] isEqualToString:@"image"])
                {
                    [item setObject:[[element childAtIndex:i] stringValue] forKey:[element name] ];
                }
                if ([[element name] isEqualToString:@"url"])
                {
                    NSString *imageURL  =   [[element childAtIndex:i] stringValue] ;
                    imageURL            =   [imageURL stringByReplacingPercentEscapesUsingEncoding:   NSUTF8StringEncoding];
                    [item setObject: imageURL forKey:[element name] ];
                }
            }
            
        }
    }
    
    return item;
    
}



+ (NSMutableDictionary *) parseDefault
{   //resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
    
    
    NSString * XMLPath =   [[NSUserDefaults standardUserDefaults] objectForKey:@"fgUrl"];
    
    NSError *theError = NULL;
    NSData *XMLData = [NSData dataWithContentsOfURL: [NSURL URLWithString: XMLPath ]   ];
    CXMLDocument *document = [[[CXMLDocument alloc]   initWithData: XMLData  options:0 error:&theError] autorelease];
    
    CXMLElement *root = [document nodeForXPath:@"//channel/item" error:nil];
    
    NSMutableDictionary *item = [[[NSMutableDictionary alloc] init] autorelease];
    
    //NSLog(@"[root children]%@",[root children]) ;
    
    
    for (CXMLElement *element in  [root children] )
    {
        
        if ([element isKindOfClass:[CXMLElement class]])
        {
            
            for (int i = 0; i < [element childCount]; i++)
            {
                
                if ([[element name] isEqualToString:@"link"])
                {
                    NSLog(@"name%@", [[element childAtIndex:i] stringValue] );

                    
                    [item setObject:[[element childAtIndex:i] stringValue] forKey:[element name] ];
                }
                
            }
            
        }
    }
    
    return item;
    
}


@end

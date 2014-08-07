//
//  MyClass.h
//  WCHL
//
//  Created by josepth on 11-6-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@interface MyClass : NSObject {
    
}
 
+(void ) createImage:(NSString *) imgPath:(UIImageView *)imgView;
+(NSString *) fixHours:(NSString *)str;
+(UIImage *) createImg:(NSString *) imgPath;
/**
+(NSString *)getStreamingURL;
+(NSString *)getNewsListingURL;
+(NSString *)getNewsURL;
+(NSString *)getLocalURL;
+(NSString *)getPhotoCategoryURL;

+(NSString *)getCalendarsURL;
+(NSString *)getWeatherURL;
+(NSString *)get1360URL;
+(NSString *)getCalendarEventURL;
+(NSString *)getBuzzURL;
+(NSString *)getAboutURL;*/

+(NSString *) getListenTitle;
 

+(NSString *) getConnectTitle;
 

+(NSString *) getTitle;
+(NSString *) getlabel1;
+(NSString *) getlabel2;
+(NSString *) getlabel3;
+(NSString *) getlabel4;
+(NSString *) getTel;
+(NSString *) getlabel5;


+ (NSMutableDictionary *) parseADVRoot;

+ (NSMutableDictionary *) parseDefault ; 

@end

//
//  GetXML.h
//  KKAJRotate
//
//  Created by josepth on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface GetXML : NSObject


+(NSMutableArray *)networkXML1:(NSString *) imgUrl nodes:(NSString *) nodes ;

+(NSMutableArray *)networkXML:(NSString *) imgUrl nodes:(NSString *) nodes ;

+(UIImage * ) createImage:(NSString *) imgPath ;
@end

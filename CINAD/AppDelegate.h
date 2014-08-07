//
//  AppDelegate.h
//  WZIM
//
//  Created by josepth on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

#import "ClockViewController_iPhone.h"
#import "Alarm.h"

@interface AppDelegate : NSObject <UIApplicationDelegate ,TTURLRequestDelegate>
{
    TTNavigator* _navigator;
    ClockViewController_iPhone*clockViewController;
    
    BOOL uiIsVisible;
    
     Alarm*alarm;
}

 
@property (nonatomic, retain) TTNavigator* navigator;

@property (nonatomic) BOOL uiIsVisible;


-(void)updateAlarms ;
@end
 

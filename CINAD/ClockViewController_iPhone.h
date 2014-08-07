//
//  ClockViewController_iPhone.h
//  Sunrise Alarm
//
//  Created by finucane on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"

@interface ClockViewController_iPhone  :UIViewController
{
    
}
@property (nonatomic, retain) IBOutlet Clock*portraitClock;
@property (nonatomic, retain) IBOutlet Clock*landscapeClock;
-(void)setDate:(NSDate*)date;
 
-(void)setOnHidden:(BOOL)hidden;


-(IBAction)setting;

@end

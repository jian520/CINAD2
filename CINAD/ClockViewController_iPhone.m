//
//  ClockViewController_iPhone.m
//  Sunrise Alarm
//
//  Created by finucane on 8/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClockViewController_iPhone.h"
#import "Global.h"
#import "insist.h"
#import "AppDelegate.h"
@implementation ClockViewController_iPhone
@synthesize portraitClock, landscapeClock;



//- (void)viewDidLoad
//{
//  insist (self.portraitClock && self.portraitClock != self.landscapeClock);
//  [self.portraitClock setFontBig:100 medium:40 small:20 tiny:15 symbol:20];
//  [self.landscapeClock setFontBig:130 medium:60 small:23 tiny:18 symbol:23];
//  [super viewDidLoad];
//}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Alarm"
														 image:[UIImage imageNamed:@"clock.png"]
														   tag:0] autorelease];
        
	}
	
	return self;
}



- (void)viewDidLoad
{
    [self.portraitClock didLoad];
   // [self.landscapeClock didLoad];
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
   // AppDelegate*a = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  //  [a updateAlarms];
    
    
    NSString *alarm = [[NSUserDefaults standardUserDefaults ] objectForKey:@"alarm" ] ;
    
    if (  [alarm isEqualToString:@"on" ]   ) {
        portraitClock.onLabel.text = @"Alarm Set" ;
    }else{
        portraitClock.onLabel.text = @"Alarm Not Set" ;
    }
    
    
}

-(void)setDate:(NSDate*)date
{
    if (!portraitClock.view) return; //this can be called before we are set up
    
    insist (portraitClock && landscapeClock && date);
    [portraitClock setDate:date];
  //  [landscapeClock setDate:date];
}

-(void)setOnHidden:(BOOL)hidden
{
   // if (!portraitClock.view) return; //this can be called before we are set up
    //insist (portraitClock && landscapeClock);
   // [portraitClock setOnHidden:hidden];
   // [landscapeClock setOnHidden:hidden];
    
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ///[[Global sharedGlobal] toggleTabBarAnimated:YES];
}


-(IBAction)setting{
    
    TTOpenURL(@"tt://remindEdit" );
    
}

@end

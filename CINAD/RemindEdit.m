//
//  RemindEdit.m
//  Baby
//
//  Created by Jian Zhang on 4/15/13.
//  Copyright (c) 2013 com.cti. All rights reserved.
//

#import "RemindEdit.h"
#import "AppDelegate.h"
 #import "Settings.h"


/**
//////////////////////////////////////////////////
@interface RemindEditTableItem : TTTableSettingsItem
{
}
  
@end

@implementation RemindEditTableItem
 

@end
//////////////////////////////////////////////////
//////////////////////////////////////////////////
@interface RemindEditTableCell : TTTableSettingsItemCell
{
    
    
}
 
@end

@implementation RemindEditTableCell
 



- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
}





@end
///////////////////////////////////////////////


@interface RemindEditDataSource : TTSectionedDataSource
{
    NSString*selectDate;
}
- (id)initWithSearchQuery:(NSString*)selectDate;

@end

@implementation RemindEditDataSource
 


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString *)r  {
    if (self = [super init]) {
        selectDate =  [[NSUserDefaults standardUserDefaults  ] objectForKey:@"alarmTime" ] ;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {

    self.items = [NSMutableArray array];
    self.sections = [NSMutableArray array];


    NSMutableArray* section = [[NSMutableArray alloc] init];
    
    
    UISwitch* switchy = [[[UISwitch alloc] init] autorelease];
    
    NSString *alarm = [[NSUserDefaults standardUserDefaults ] objectForKey:@"alarm" ] ;
    if ( [alarm isEqualToString:@"on" ] ) {
        [switchy setOn:YES ];
    }else
        [switchy setOn:NO ];
    
    
    
    TTTableControlItem* alarmItem = [TTTableControlItem itemWithCaption:@"Alarm" control:switchy];
    [section addObject:alarmItem] ;
    [switchy addTarget:self action:@selector(alarm:) forControlEvents:UIControlEventValueChanged ] ;
    
    
    TTTableSettingsItem* settItem = [TTTableSettingsItem itemWithText:selectDate caption:@"Time" ];

    [section addObject:settItem];
    
    [_sections addObject:@"" ];
    [_items addObject:section];

}

- (void)alarm:(id)sender{
    
    UISwitch* switchy =(UISwitch*)sender;
    if ( switchy.isOn ) {
        [[NSUserDefaults standardUserDefaults ] setObject:@"on" forKey:@"alarm"];
    }else{
        [[NSUserDefaults standardUserDefaults ] removeObjectForKey:@"alarm"];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        [[NSUserDefaults standardUserDefaults  ] setObject:@"" forKey:@"alarmTime" ] ;
        
        [[NSNotificationCenter defaultCenter]  postNotificationName:@"refreshTable" object:self userInfo:nil ];
        
        
    }
    
    
    
    
    
    

}
@end

 */
//////////////////////////////////////////////////////



@interface TextTestStyleSheet : TTDefaultStyleSheet
@end

@implementation TextTestStyleSheet

- (TTStyle*)redText {
    return [TTTextStyle styleWithColor:[UIColor redColor] next:nil];
}


- (TTStyle*)yText {
    return [TTTextStyle styleWithColor:[UIColor yellowColor] next:nil];
}

- (TTStyle*)largeText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:32] next:nil];
}

- (TTStyle*)smallText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:12] next:nil];
}



@end








@interface RemindEdit ()


@property (nonatomic, retain) UIToolbar *toolBar;

@end

@implementation RemindEdit
 
 
@synthesize selectDate;

 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Alarm"
														 image:[UIImage imageNamed:@"clock.png"]
														   tag:0] autorelease];
        
        [TTStyleSheet setGlobalStyleSheet:[[[TextTestStyleSheet alloc] init] autorelease]];
        
	}
	
	return self;
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated] ;
    
    self.navigationController.navigationBarHidden = YES;
  
   
}
- (void) cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil ] ;
}
- (void)loadView
{
    [super loadView];
    
    
    /**
     
    UIBarButtonItem *cancel= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel  target:self action:@selector(cancel)];
    //self.navigationItem.leftBarButtonItem = cancel;
    
     UIBarButtonItem *save= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave  target:self action:@selector(save)];
     //self.navigationItem.rightBarButtonItem = save;
    
  
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(refreshTable:)
                                                  name:@"refreshTable"
                                                object:nil];
     
     */
 
    
   // NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init] ;
    //[dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    ///NSString *dateString = [dateFormat stringFromDate:[NSDate date] ];

  //  self.dataSource = [[RemindEditDataSource  alloc] initWithSearchQuery:@""  ];
    
    /////////////////////////////////////////////////
    
    NSString*headerImage      =  [[NSUserDefaults standardUserDefaults]  objectForKey:@"headerImage"];
    
    TTImageView*imgV1= [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    imgV1.urlPath =  headerImage;
    // imgV1.image = [UIImage imageNamed:@"img1.png"];
    [self.view addSubview:imgV1];
    
    
 
    NSString* kText = @" <span class=\"redText\">If app is open,the stream will start at alarm time. If app is in background mode or closed, an alert will appear at alarm time.</span><br>\
    <span class=\"yText\">Please keep phone unmuted.</span>";
 
    
    TTStyledTextLabel* label1 = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
    label1.top = imgV1.bottom;
    label1.font = [UIFont systemFontOfSize:17];
    label1.text = [TTStyledText textFromXHTML:kText lineBreaks:YES URLs:YES];
    label1.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    label1.backgroundColor = [UIColor clearColor];
    label1.textAlignment = UITextAlignmentCenter;
    [label1 sizeToFit];
    [self.view addSubview:label1];
    

    myDatePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,160,0.0,0.0)];
    [myDatePicker setDatePickerMode:UIDatePickerModeDateAndTime ];
    [myDatePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [myDatePicker setDate:[NSDate date] animated:YES ] ;
    [myDatePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    myDatePicker.backgroundColor = [UIColor grayColor] ;
    [self.view addSubview:myDatePicker];
    
    UISwitch* switchy = [[[UISwitch alloc] initWithFrame:CGRectMake(0, myDatePicker.bottom+5, 100,28)] autorelease];
    [switchy addTarget:self action:@selector(alarm:) forControlEvents:UIControlEventValueChanged ] ;
    
    /**
    NSString *alarm = [[NSUserDefaults standardUserDefaults ] objectForKey:@"alarm" ] ;
    if ( [alarm isEqualToString:@"on" ] ) {
        [switchy setOn:YES ];
    }else
        [switchy setOn:NO ];
     */
    
   
    
    [self.view addSubview:switchy ] ;
    
}
- (void)alarm:(id)sender{
    
    UISwitch* switchy =(UISwitch*)sender;
    if ( switchy.isOn ) {
        //[[NSUserDefaults standardUserDefaults ] setObject:@"on" forKey:@"alarm"];
        
        [self save] ; 
        
    }else{
       // [[NSUserDefaults standardUserDefaults ] removeObjectForKey:@"alarm"];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        ///[[NSUserDefaults standardUserDefaults  ] setObject:@"" forKey:@"alarmTime" ] ;
        
       // [[NSNotificationCenter defaultCenter]  postNotificationName:@"refreshTable" object:self userInfo:nil ];
       
        
    }
    
}

-(void)save{
     
     //   NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init] ;
    //    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
     //   NSString *dateString = [dateFormat stringFromDate:[myDatePicker date] ];
     //   NSDate *notificationDate = [dateFormat dateFromString:dateString];

    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
            
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval=0;
        

       // notification.applicationIconBadgeNumber = 1;
        notification.alertAction = NSLocalizedString(@"显示", nil);
        //notification.hasAction = NO;
 
        notification.fireDate = [myDatePicker date];
        
      //  notification.fireDate= [[NSDate date ]  dateByAddingTimeInterval:10];
        
        NSLog(@" notification.fireDate%@", notification.fireDate) ;
        
        notification.alertBody=@"Tap here to go to app";
        
         [notification setSoundName:UILocalNotificationDefaultSoundName];
        
        
      //  Settings*settings = [Settings sharedSettings];
      //  insist (settings);
        notification.soundName = @"alarm-clock-1.mp3";
        
        
        
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
        [notification setUserInfo:dict];
        
        [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
    }
    [notification release];  
   // [self dismissViewControllerAnimated:YES completion:nil ] ;
}


- (IBAction)dateChanged:(id)sender {
    
    UIDatePicker* datePicker = (UIDatePicker*)sender;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //self.selectDate =[formatter stringFromDate: [datePicker date] ];
    
   // self.selectDate =   [myDatePicker date]  ;
    
   // [[NSUserDefaults standardUserDefaults  ] setObject:self.selectDate forKey:@"alarmTime" ] ;
    
 //   self.dataSource = [[RemindEditDataSource  alloc] initWithSearchQuery:@""  ];
    
    
}

- (void)refreshTable:(NSNotification*)notification
{
   // self.dataSource = [[RemindEditDataSource  alloc] initWithSearchQuery:@""  ];
   
}

@end

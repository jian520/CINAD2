//
//  RemindEdit.h
//  Baby
//
//  Created by Jian Zhang on 4/15/13.
//  Copyright (c) 2013 com.cti. All rights reserved.
//

#import <Three20UI/Three20UI.h>
 
@interface RemindEdit : UIViewController
{
   
    
    NSString *selectDate;
    
    TTView *ttview;
    
    UIDatePicker *myDatePicker;
}
 
@property (nonatomic,strong) NSString *selectDate;

@end

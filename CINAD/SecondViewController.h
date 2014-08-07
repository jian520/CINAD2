//
//  SecondViewController.h
//  POST
//
//  Created by John Smith on 9/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface SecondViewController : UIViewController <MBProgressHUDDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UIImageView *imageView;
    UIImage *image;
    NSString *path;
    
    IBOutlet UITextField *desc;
    IBOutlet UITextField *name;
    
    IBOutlet UIProgressView *progressIndicator;
    
    BOOL _movedUp;
    
}
@property(nonatomic,retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) UIImage *image;
@property(nonatomic,retain) NSString *path;
@property(nonatomic,retain) IBOutlet UITextField *desc;
@property(nonatomic,retain) IBOutlet UITextField *name;
@property(nonatomic,retain) IBOutlet UIProgressView *progressIndicator;


- (IBAction ) ok:(id)sender;

+ (void)showModal:(UINavigationController*)parentController :(UIImage *) image ;
+ (void)showModal2:(UINavigationController*)parentController :(NSString *) url :(UIImage *) image ;

-(IBAction) textFieldDoneEditing:(id)sender;
-(IBAction) cancelKeyboardClick;

@end

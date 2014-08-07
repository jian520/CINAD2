//
//  FirstViewController.h
//  POST
//
//  Created by John Smith on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h> 

#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/UTCoreTypes.h>

#import "MBProgressHUD.h"


@interface STeamViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate  ,MBProgressHUDDelegate >
{
     
    MBProgressHUD *HUD;
    UIImage *_image;
  
    UIImagePickerController *currentPickerController;
    
}

@property(nonatomic,retain)   UIImage *_image;

- (IBAction) pickImage: (id) sender ;
- (IBAction)  takePhoto: (id) sender; 
- (IBAction)  takeVideo: (id) sender;
//- (IBAction)  showMap: (id) sender; 

 
-(void)rotateVideo :(NSURL* )videoURL;
-(NSString*) videoAssetURLToTempFile:(NSURL*)url;
-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time ;
-(UIImage *)rotateImage:(UIImage *)aImage;
- (UIInterfaceOrientation)orientationForTrack:(AVAsset *)asset;
@end

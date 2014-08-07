//
//  FirstViewController.m
//  POST
//
//  Created by John Smith on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "STeamViewController.h"
#import "SecondViewController.h"
 
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

@implementation STeamViewController
@synthesize _image;
 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Street Team" 
														 image:[UIImage imageNamed:@"tabicon-steam.png"] 
														   tag:0] autorelease];
        self.title=@"Street Team";

	}
    
	return self;
}

-(void) getSecondView2: (NSString *) url
{
    [SecondViewController showModal2:self.navigationController:url: self._image  ] ;
    
}
 
  
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
       
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];
  
    if([mediaType isEqualToString:@"public.image"])
    {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        if ( [picker title] ==nil  )  
        {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        image =  [self rotateImage:image];
        
        CGSize size = CGSizeMake(640.0f, 960.0f);
        image = [self imageByScalingAndCroppingForSize:size sourceImage:image ];
        
        
        [self dismissModalViewControllerAnimated:NO];
        [SecondViewController showModal:self.navigationController:image ] ;
             
    }
    else if([mediaType isEqualToString:@"public.movie"])
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Loading";
        [HUD show:YES];
      
        
        NSURL *videoURL = [info objectForKey:@"UIImagePickerControllerMediaURL" ];
        NSString *savedVideoPath = [videoURL path];
 
        self._image =  [self thumbnailImageForVideo: videoURL atTime:1]; 
        
        
        AVURLAsset* incomingVideo = [[AVURLAsset alloc] initWithURL:[NSURL  fileURLWithPath:[videoURL path]] options:nil];
        NSLog(@"orientationForTrack=%d", [self orientationForTrack: incomingVideo] );
        
              
        if ( [picker title] ==nil )  
        {  
            UISaveVideoAtPathToSavedPhotosAlbum(savedVideoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), NULL);
        
          
            [self dismissModalViewControllerAnimated:NO];
            if (  [self orientationForTrack: incomingVideo] ==4) {
                [HUD hide:YES];
                [self getSecondView2:savedVideoPath];
          
            }else  if (  [self orientationForTrack: incomingVideo] ==3) {
                
                [self rotateVideo:videoURL];
                
            }else  if (  [self orientationForTrack: incomingVideo] ==1) {
                [self rotateVideo:videoURL];
            }else  if (  [self orientationForTrack: incomingVideo] ==2) {
                [self rotateVideo:videoURL];
            }


            
        } 
        else{               
            [self dismissModalViewControllerAnimated:NO];
          
            NSURL *referenceURL =[info objectForKey:UIImagePickerControllerReferenceURL];
           
            if (  [self orientationForTrack: incomingVideo] ==4) {
                [HUD hide:YES];
                [self getSecondView2:savedVideoPath];
            }else if (  [self orientationForTrack: incomingVideo] ==3) {
                
                [self videoAssetURLToTempFile:referenceURL];
            }else if (  [self orientationForTrack: incomingVideo] ==1) {
                [self videoAssetURLToTempFile:referenceURL];
            }else if (  [self orientationForTrack: incomingVideo] ==2) {
                [self videoAssetURLToTempFile:referenceURL];
            }
            
            
        }
     
    }  
}


- (IBAction) takePhoto: (id) sender
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
		UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
		imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
		imagePickerController.delegate = self;
		currentPickerController = imagePickerController;
		[self presentModalViewController:imagePickerController animated:YES];
		[imagePickerController release];
	}
    
}
- (IBAction) takeVideo: (id) sender
{
 
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	if([mediaTypes containsObject:@"public.movie"]){
		UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
		 
	    imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
		imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePickerController.videoQuality = UIImagePickerControllerQualityType640x480 ;
	    [imagePickerController setAllowsEditing:YES] ;
        imagePickerController.delegate = self;
        
		currentPickerController = imagePickerController;
		[self presentModalViewController:imagePickerController animated:YES];
		[imagePickerController release];
	}
    
}

- (IBAction ) pickImage: (id) sender
{  
    
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
		imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie,nil];
		imagePickerController.sourceType=    UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.delegate = self;
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
		currentPickerController = imagePickerController;
		[self presentModalViewController:imagePickerController animated:YES];
		[imagePickerController release];
	}
}
 

-(UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {  
    AVURLAsset *asset = [[[AVURLAsset alloc] initWithURL:videoURL options:nil] autorelease];  
    NSParameterAssert(asset);  
    AVAssetImageGenerator *assetImageGenerator = [[[AVAssetImageGenerator alloc] initWithAsset:asset] autorelease];  
    assetImageGenerator.appliesPreferredTrackTransform = YES;  
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;  
    
    CGImageRef thumbnailImageRef = NULL;  
    CFTimeInterval thumbnailImageTime = time;  
    NSError *thumbnailImageGenerationError = nil;  
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];  
    
    if (!thumbnailImageRef)  
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);  
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[[UIImage alloc] initWithCGImage:thumbnailImageRef] autorelease] : nil;  
    
    return thumbnailImage; 
}

- (void) screenWillRorate:(NSNotification *)notification
{  
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
  //  NSLog(@"orientation%d" , orientation);
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight   )
    {
        // if (_flag ==2)   v.hidden = YES;
    }  
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
   //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenWillRorate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    
    [self.navigationController.navigationBar setHidden:YES];
    
    
 
    
    
    [[NSUserDefaults standardUserDefaults]
     setObject:@"http://vortal3.intertechmedia.com/appx/ugc/android_upload.php"      forKey:@"uploadurl" ];
    [[NSUserDefaults standardUserDefaults] setObject:@"3680"      forKey:@"stationid" ];
    [[NSUserDefaults standardUserDefaults] setObject:@"132371"    forKey:@"photocontentid" ];
    [[NSUserDefaults standardUserDefaults] setObject:@"2236"       forKey:@"videocontentid" ];
    
 
    
    
    
}

/**
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{ 
    
    return interfaceOrientation == UIInterfaceOrientationPortrait  ;
}
*/
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [super dealloc];
    
    [_image release];
  
    
}
 

- (void)image:(UIImage *)image   didFinishSavingWithError:(NSError *)error   contextInfo:(void *)contextInfo
{  
  //   NSLog(@"Finished saving image with erro:-%@", error);
}
 
- (void) video: (NSString *) videoPath didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
  //  NSLog(@"Finished saving video with erro:-%@", error);
} 
 
 
 
-(UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}
 
 
-(void)rotateVideo :(NSURL* )videoURL
{ 
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    /// COMPOSING
    NSError *error;
    CGSize videoSize = CGSizeMake(640,480);
   
    //AVURLAsset* incomingVideo = [AVURLAsset URLAssetWithURL:videoURL options:nil]; // video urla
    AVURLAsset* incomingVideo = [[AVURLAsset alloc] initWithURL:[NSURL  fileURLWithPath:[videoURL path]] options:nil];
    
    NSLog(@"incomingVideo: %@", incomingVideo);
    
    /// AVSWEETNESS
    AVMutableComposition *composition = [AVMutableComposition composition];
    AVMutableCompositionTrack *compositionVideoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *clipVideoTrack = [[incomingVideo tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [incomingVideo duration])  ofTrack:clipVideoTrack atTime:kCMTimeZero error:&error];
    
    
    AVMutableVideoComposition* videoComp = [[AVMutableVideoComposition videoComposition] retain];
    videoComp.renderSize = videoSize; // or CGSizeMake(640, 480);
    videoComp.frameDuration = CMTimeMake(1, 30); /// 30fps
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    videoLayer.frame  = CGRectMake(100, 0, videoSize.width, videoSize.height);
    [parentLayer addSublayer:videoLayer];
    
    videoComp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
    /// INSTRUCTION
    AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(60, 30) );
    AVMutableVideoCompositionLayerInstruction* layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:clipVideoTrack];
    instruction.layerInstructions = [NSArray arrayWithObject:layerInstruction];
    videoComp.instructions = [NSArray arrayWithObject: instruction];
    
    /// rotation instruction 
    
    AVMutableVideoCompositionLayerInstruction* rotator =
    [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:   clipVideoTrack ];
    
    CGAffineTransform translateToCenter = CGAffineTransformMakeTranslation(0,-380);  
    CGAffineTransform rotateByDegrees        = CGAffineTransformMakeRotation(  M_PI_2 );
    
    
    if ([self orientationForTrack:incomingVideo ]  == 1) {
        
        translateToCenter = CGAffineTransformMakeTranslation(0,-380);
        rotateByDegrees = CGAffineTransformMakeRotation(   M_PI_2  );
    }else if ([self orientationForTrack:incomingVideo ]  == 2) {
        
        translateToCenter = CGAffineTransformMakeTranslation(0,-100);
        rotateByDegrees = CGAffineTransformMakeRotation(   M_PI * -0.50  );
    }else  if ([self orientationForTrack:incomingVideo ]  == 3) {    
        translateToCenter = CGAffineTransformMakeTranslation(-400,-401); 
        rotateByDegrees        = CGAffineTransformMakeRotation(  M_PI );
    }
    
  
    CGAffineTransform shrinkWidth = CGAffineTransformMakeScale(0.66, 0.66); // needed because Apple does a "stretch" by default - really, we should find and undo apple's stretch - I suspect it'll be a CALayer defaultTransform, or UIView property causing this
    CGAffineTransform finalTransform = CGAffineTransformConcat( shrinkWidth, CGAffineTransformConcat(translateToCenter, rotateByDegrees) );
    [rotator setTransform:finalTransform atTime:kCMTimeZero];
    instruction.layerInstructions = [NSArray arrayWithObject: rotator];
    
    /// OUTPUT
    NSString *filePath = nil;
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:@"temp.mov"]; 
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSLog(@"exporting to: %@", filePath);
    if ([fileManager fileExistsAtPath:filePath]) 
    {
        BOOL success = [fileManager removeItemAtPath:filePath error:&error];
        if (!success) NSLog(@"FM error: %@", [error localizedDescription]);
    }
    
    /// EXPORT
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:composition presetName: AVAssetExportPresetHighestQuality  ] ;
    exporter.videoComposition = videoComp;
    exporter.outputURL=[NSURL   fileURLWithPath:filePath];
    exporter.outputFileType=AVFileTypeQuickTimeMovie;
    
    [exporter exportAsynchronouslyWithCompletionHandler:^
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSLog(@"Export Finished: %@", exporter.error);
             if (exporter.error) {
                 [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
             } 
             else 
                 
                 [self getSecondView2: filePath ] ;
             [HUD hide:YES  ];
             
         });
     }];

    
}

-(NSString*) videoAssetURLToTempFile:(NSURL*)url
{
    NSString * surl = [url absoluteString];
    NSString * ext = [surl substringFromIndex:[surl rangeOfString:@"ext="].location + 4];
    NSTimeInterval ti = [[NSDate date]timeIntervalSinceReferenceDate];
    NSString * filename = [NSString stringWithFormat: @"%f.%@",ti,ext];
    NSString * tmpfile = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
     
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        
        ALAssetRepresentation * rep = [myasset defaultRepresentation];
         
        NSUInteger size = [rep size];
        const int bufferSize = 8192;
        
        NSLog(@"Writing to %@",tmpfile);
        FILE* f = fopen([tmpfile cStringUsingEncoding:1], "wb+");
        if (f == NULL) {
            NSLog(@"Can not create tmp file.");
            return;
        }
        
        Byte * buffer = (Byte*)malloc(bufferSize);
        int read = 0, offset = 0, written = 0;
        NSError* err;
        if (size != 0) {
            do {
                read = [rep getBytes:buffer
                          fromOffset:offset
                              length:bufferSize 
                               error:&err];
                written = fwrite(buffer, sizeof(char), read, f);
                offset += read;
            } while (read != 0);
              NSLog(@"save  tmp file.");
              
        }
        
        fclose(f);
        [self performSelector:@selector(rotateVideo:) withObject:[NSURL URLWithString:tmpfile] afterDelay:1.0f];
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
      
        
        NSLog(@"Can not get asset - %@",[myerror localizedDescription]);
      //  NSString *errorTitle = [myerror localizedDescription];
      //  NSString *errorMessage = [myerror localizedRecoverySuggestion];
      //  NSString *errorFailureDesc = [myerror localizedFailureReason];
        
       // NSLog(@"Error: %@, Suggestion: %@, Failure desc: %@", errorTitle, errorMessage, errorFailureDesc); 
    
        [HUD hide:YES];
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"Please enabled location service for KTSA(Settings -> Location Services -> KTSA)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
          
        [alert show];
        
        
    };
    
    if(url)
    {
        ALAssetsLibrary* assetslibrary = [[[ALAssetsLibrary alloc] init] autorelease];
        [assetslibrary assetForURL:url 
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
        
    
    return tmpfile;
}

 
- (UIInterfaceOrientation)orientationForTrack:(AVAsset *)asset
{
    AVAssetTrack *videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    CGSize size = [videoTrack naturalSize];
    CGAffineTransform txf = [videoTrack preferredTransform];
    
    if (size.width == txf.tx && size.height == txf.ty)
        return UIInterfaceOrientationLandscapeRight;
    else if (txf.tx == 0 && txf.ty == 0)
        return UIInterfaceOrientationLandscapeLeft;
    else if (txf.tx == 0 && txf.ty == size.width)
        return UIInterfaceOrientationPortraitUpsideDown;
    else
        return UIInterfaceOrientationPortrait;
}






- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImage:(UIImage*)sourceImage
{
   // UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    else
        NSLog(@"scale image");
    
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end

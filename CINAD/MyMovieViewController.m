 
#import "MyMovieViewController.h"
#import "MyClass.h"
#import "GetXML.h"
#import "UIDevice+Resolutions.h"

#import "AudioStreamer.h"
#import "LevelMeterView.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>

#import "AppDelegate.h"

#pragma mark -
@implementation MyMovieViewController

@synthesize moviePlayerController;

 
////
@synthesize imgView, playButton,stopButton,volume, lbLoad;
@synthesize listenliveurl;
@synthesize  xmlString;


@synthesize imagePath ;
@synthesize imageURL  ;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Listen"
														 image:[UIImage imageNamed:@"tabicon-listen.png"]
														   tag:0] autorelease];
        
	}
	
	return self;
}


- (void)viewDidLoad
{   NSLog(@"viewDidLoad") ;
    
    [super viewDidLoad];
    
    int valueDevice = [UIDevice currentResolution] ;

    NSError *audioSessionError = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession setCategory:AVAudioSessionCategoryPlayback
                            error:&audioSessionError] == YES){
        NSLog(@"Successfully set the audio session.");
    } else {
        NSLog(@"Could not set the audio session");
    }
    
    
    self.navigationController.navigationBarHidden = TRUE;   
    
    CGRect appFrame = [UIScreen mainScreen].applicationFrame;
    //  CGFloat x = appFrame.origin.x;
    //   CGFloat y = appFrame.origin.y;
    CGFloat width = appFrame.size.width;
    //   CGFloat height = appFrame.size.height;
     
    NSString*headerImage      =  [[NSUserDefaults standardUserDefaults]  objectForKey:@"headerImage"];
   // NSString*bannerGroupUrl   = [[NSUserDefaults standardUserDefaults]  objectForKey:@"bannerGroupUrl"];
  
    
    TTImageView*imgV1= [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    imgV1.urlPath =  headerImage;
    // imgV1.image = [UIImage imageNamed:@"img1.png"];
    [self.view addSubview:imgV1];
    
    
    
    
    //TTImageView*imgV2= [[TTImageView alloc] initWithFrame:CGRectMake(0, 50, width, 50)];
   // imgV2.image = [UIImage imageNamed:@"img2.png"];
     //imgV2.urlPath = bannerGroupUrl;
   // [self.view addSubview:imgV2];
    
    UIButton*advBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    advBtn.frame = CGRectMake(0, 50, width, 50);
    
    [advBtn addTarget:self action:@selector(openWin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:advBtn];
  
 
    CGRect  scrollerFrame  ;

 
    //CGRect  imgFrame  ;
    CGRect  volumeFrame  ; 
    CGRect  buttonFrame  ;
    CGRect  levelMeterFrame;
    CGRect  labelFrame;
    
         
   // imgFrame =CGRectMake(0, -20, 320, 480);
    

    if (valueDevice == 3) //iphone 5
    {
        scrollerFrame = CGRectMake(0, 100, 320, 370);
        
        buttonFrame =CGRectMake(0 ,470, 50, 50);
        labelFrame   =  CGRectMake(50,470, width, 20) ;
        
        //levelMeterFrame =CGRectMake(50 ,455, 280, 50);
        volumeFrame     =CGRectMake(50, 480, 270, 20) ;

    
    }else if (valueDevice == 2)
    {
        scrollerFrame = CGRectMake(0, 100, 320, 260);
        buttonFrame     =CGRectMake(0 ,370, 50, 50);
       // levelMeterFrame =CGRectMake(50 ,355, 280, 50);
        labelFrame      =CGRectMake(50,360, width, 20) ;
        volumeFrame     =CGRectMake(50, 380, 270, 20) ;

    }
    
    button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= buttonFrame ;
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside ] ;
    [self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];

    [self.view addSubview:button] ;
  
    
    self.lbLoad  = [[UILabel alloc]initWithFrame:labelFrame ];
    
    [self.lbLoad setTextAlignment:NSTextAlignmentCenter] ;
    [self.lbLoad setBackgroundColor:[UIColor clearColor]];
    [self.lbLoad setTextColor:[UIColor whiteColor]];
    [self.lbLoad setText: [MyClass getConnectTitle  ] ];
    
    [self.view addSubview:lbLoad];
    
    
    
    self.volume = [[[MPVolumeView alloc] initWithFrame: volumeFrame  ] autorelease];
    NSArray *tempArray = self.volume.subviews;
    
    for (id current in tempArray){
        if ([current isKindOfClass:[UISlider class]]){
            //UISlider *tempSlider = (UISlider *) current;
            
            
            UIImage *img = [UIImage imageNamed:@"volume_down.png"];
            img = [img stretchableImageWithLeftCapWidth:5.0 topCapHeight:0];
            // [tempSlider setMinimumValueImage:img] ;
            img = [UIImage imageNamed:@"volume_up.png"];
            img = [img stretchableImageWithLeftCapWidth:5.0 topCapHeight:0];
            //[tempSlider setMaximumValueImage:img];
            
            //   img = [UIImage imageNamed:@"volume_bg.png"];
            
            // [tempSlider setMinimumTrackImage:img forState:UIControlStateNormal];
            //  [tempSlider setMaximumTrackImage:img forState:UIControlStateNormal];
            
            //[tempSlider setThumbImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
            
        }
    }
    [self.view addSubview:self.volume];
    
    /*
    MPVolumeView *volumeView = [[[MPVolumeView alloc] initWithFrame:CGRectMake(0, 0, 300, 20) ] autorelease];
    // volumeView.backgroundColor = [UIColor redColor];
 	[self.view addSubview:volumeView];
	[volumeView sizeToFit];*/
    
    
	
	
    //progressSlider.backgroundColor = [UIColor redColor];
    
	//levelMeterView = [[LevelMeterView alloc] initWithFrame:levelMeterFrame ];
	//[self.view addSubview:levelMeterView];
    
    [self.view bringSubviewToFront:self.volume ] ;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            
        NSDictionary* dic = [MyClass parseADVRoot];
        if (dic.count!=0 ) {
            self.imagePath = [dic objectForKey:@"image"];
            self.imageURL  = [dic objectForKey:@"url"];
        }
        
        NSString*fgUrl =  [[NSUserDefaults standardUserDefaults] objectForKey:@"fgUrl"];
        // return ;
        
        NSLog(@"fgUrl%@",fgUrl) ;
    
        NSArray*array =  [GetXML networkXML1: fgUrl nodes:@"//item"] ;
         NSLog(@"array%@",array) ;
        
        if (array.count ==0 ) {
            return ;
        }
        NSMutableArray *imgArray = [[NSMutableArray alloc] init ] ;
        NSMutableArray *urlArray = [[NSMutableArray alloc] init ] ;
        
        for (NSDictionary*dic in array ) {
            
            [imgArray addObject:  [ dic objectForKey:@"imgURL" ] ] ;
            [urlArray addObject:  [ dic objectForKey:@"link" ] ] ;
        }
      
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:scrollerFrame
                                                                  ImageArray:imgArray
                                                                  TitleArray:[NSArray arrayWithObjects:@"",@"",@"", nil]
                                                                    urlArray: urlArray ];
            scroller.delegate=self;
            [self.view addSubview:scroller];
            
            
            
            [advBtn setBackgroundImage:[MyClass createImg: self.imagePath  ] forState:0 ];

            
            
            
        });
    });
    
 
    
    
}

- (void)openWin {
    TTOpenURL(self.imageURL);
}


- (void)dealloc
{ 
    [imgView release];
    [playButton release];
	[stopButton release];
    [volume release] ;
    [lbLoad release];
    [listenliveurl release ] ;
 
    [self destroyStreamer];
	[self createTimers:NO];
	[levelMeterView release];
    
    
    [super dealloc];
}
 
 





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




- (void)setButtonImage:(UIImage *)image
{
	[button.layer removeAllAnimations];
	if (!image)
	{
		[button setImage:[UIImage imageNamed:@"playbutton.png"] forState:0];
        
        
        
     
        
	}
	else
	{
		[button setImage:image forState:0];
        
		if ([button.currentImage isEqual:[UIImage imageNamed:@"loadingbutton.png"]])
		{
			[self spinButton];
		}
        
	}
}

//
// destroyStreamer
//
// Removes the streamer, the UI update timer and the change notification
//
- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
		[self createTimers:NO];
		
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}

//
// forceUIUpdate
//
// When foregrounded force UI update since we didn't update in the background
//
-(void)forceUIUpdate {
	//if (currentArtist){}
    //metadataArtist.text = currentArtist;
    //	if (currentTitle){}
	//	metadataTitle.text = currentTitle;
    
	if (!streamer) {
		[levelMeterView updateMeterWithLeftValue:0.0
									  rightValue:0.0];
		[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
	}
	else
		[self playbackStateChanged:NULL];
}

//
// createTimers
//
// Creates or destoys the timers
//
-(void)createTimers:(BOOL)create
{
	if (create) {
		if (streamer) {
            [self createTimers:NO];
            
            
            /*
            progressUpdateTimer =
            [NSTimer
             scheduledTimerWithTimeInterval:0.1
             target:self
             selector:@selector(updateProgress:)
             userInfo:nil
             repeats:YES];
            */
            levelMeterUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                                     target:self
                                                                   selector:@selector(updateLevelMeters:)
                                                                   userInfo:nil
                                                                    repeats:YES];
		}
	}
	else {
		if (progressUpdateTimer)
		{
			[progressUpdateTimer invalidate];
			progressUpdateTimer = nil;
		}
		if(levelMeterUpdateTimer) {
			[levelMeterUpdateTimer invalidate];
			levelMeterUpdateTimer = nil;
		}
	}
}

//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer
{
	if (streamer)
	{
		return;
	}
    
	[self destroyStreamer];
    
    
    NSString*iosStreamUrl =  [[NSUserDefaults standardUserDefaults] objectForKey:@"iosStreamUrl"];
	
	NSString *escapedValue =
    [(NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                         nil,
                                                         (CFStringRef)iosStreamUrl,
                                                         NULL,
                                                         NULL,
                                                         kCFStringEncodingUTF8)
     autorelease];
    
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	
	[self createTimers:YES];
    
	[[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(playbackStateChanged:)
     name:ASStatusChangedNotification
     object:streamer];
#ifdef SHOUTCAST_METADATA
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(metadataChanged:)
	 name:ASUpdateMetadataNotification
	 object:streamer];
#endif
}

//
// viewDidLoad
//
// Creates the volume slider, sets the default path for the local file and
// creates the streamer immediately if we already have a file at the local
// location.
//


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
	UIApplication *application = [UIApplication sharedApplication];
	if([application respondsToSelector:@selector(beginReceivingRemoteControlEvents)])
		[application beginReceivingRemoteControlEvents];
	[self becomeFirstResponder]; // this enables listening for events
	// update the UI in case we were in the background
	NSNotification *notification =
	[NSNotification
	 notificationWithName:ASStatusChangedNotification
	 object:self];
	[[NSNotificationCenter defaultCenter]
	 postNotification:notification];
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

//
// spinButton
//
// Shows the spin button when the audio is loading. This is largely irrelevant
// now that the audio is loaded from a local file.
//
- (void)spinButton
{
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];
    
	[CATransaction commit];
}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

//
// buttonPressed:
//
// Handles the play/stop button. Creates, observes and starts the
// audio streamer when it is a play button. Stops the audio streamer when
// it isn't.
//
// Parameters:
//    sender - normally, the play/stop button.
//
- (IBAction)buttonPressed:(id)sender
{
	if ([button.currentImage isEqual:[UIImage imageNamed:@"playbutton.png"]] || [button.currentImage isEqual:[UIImage imageNamed:@"pausebutton.png"]])
	{
        
		
		[self createStreamer];
		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
		[streamer start];
        
       
        [self.lbLoad setText: [MyClass getListenTitle  ] ];
        
	}
	else
	{
		[streamer stop];
         [self.lbLoad setText: [MyClass getConnectTitle  ] ];
	}
}

//
// sliderMoved:
//
// Invoked when the user moves the slider
//
// Parameters:
//    aSlider - the slider (assumed to be the progress slider)
//
- (IBAction)sliderMoved:(UISlider *)aSlider
{
	if (streamer.duration)
	{
		NSLog(@"这是我想要的输出");
        double newSeekTime = (aSlider.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}

- (IBAction)volumeSlider:(id)sender {
    Float32 val = [(UISlider *)sender value];
    [streamer volume:val];
}

//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	AppDelegate *appDelegate =(AppDelegate*) [[UIApplication sharedApplication] delegate];
    
	if ([streamer isWaiting])
	{
		if (appDelegate.uiIsVisible) {
			[levelMeterView updateMeterWithLeftValue:0.0
                                          rightValue:0.0];
			[streamer setMeteringEnabled:NO];
			[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];
		}
	}
	else if ([streamer isPlaying])
	{
		if (appDelegate.uiIsVisible) {
			[streamer setMeteringEnabled:YES];
			[self setButtonImage:[UIImage imageNamed:@"stopbutton.png"]];
		}
	}
	else if ([streamer isPaused]) {
		if (appDelegate.uiIsVisible) {
			[levelMeterView updateMeterWithLeftValue:0.0
                                          rightValue:0.0];
			[streamer setMeteringEnabled:NO];
			[self setButtonImage:[UIImage imageNamed:@"pausebutton.png"]];
		}
	}
	else if ([streamer isIdle])
	{
		if (appDelegate.uiIsVisible) {
			[levelMeterView updateMeterWithLeftValue:0.0
                                          rightValue:0.0];
			[self setButtonImage:[UIImage imageNamed:@"playbutton.png"]];
		}
		[self destroyStreamer];
	}
}

#ifdef SHOUTCAST_METADATA
/** Example metadata
 *
 StreamTitle='Kim Sozzi / Amuka / Livvi Franc - Secret Love / It's Over / Automatik',
 StreamUrl='&artist=Kim%20Sozzi%20%2F%20Amuka%20%2F%20Livvi%20Franc&title=Secret%20Love%20%2F%20It%27s%20Over%20%2F%20Automatik&album=&duration=1133453&songtype=S&overlay=no&buycd=&website=&picture=',
 
 Format is generally "Artist hypen Title" although servers may deliver only one. This code assumes 1 field is artist.
 */
- (void)metadataChanged:(NSNotification *)aNotification
{
	NSString *streamArtist;
	NSString *streamTitle;
	NSString *streamAlbum;
    //NSLog(@"Raw meta data = %@", [[aNotification userInfo] objectForKey:@"metadata"]);
    
	NSArray *metaParts = [[[aNotification userInfo] objectForKey:@"metadata"] componentsSeparatedByString:@";"];
	NSString *item;
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	for (item in metaParts) {
		// split the key/value pair
		NSArray *pair = [item componentsSeparatedByString:@"="];
		// don't bother with bad metadata
		if ([pair count] == 2)
			[hash setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
	}
    
	// do something with the StreamTitle
	NSString *streamString = [[hash objectForKey:@"StreamTitle"] stringByReplacingOccurrencesOfString:@"'" withString:@""];
	
	NSArray *streamParts = [streamString componentsSeparatedByString:@" - "];
	if ([streamParts count] > 0) {
		streamArtist = [streamParts objectAtIndex:0];
	} else {
		streamArtist = @"";
	}
	// this looks odd but not every server will have all artist hyphen title
	if ([streamParts count] >= 2) {
		streamTitle = [streamParts objectAtIndex:1];
		if ([streamParts count] >= 3) {
			streamAlbum = [streamParts objectAtIndex:2];
		} else {
			streamAlbum = @"N/A";
		}
	} else {
		streamTitle = @"";
		streamAlbum = @"";
	}
	NSLog(@"%@ by %@ from %@", streamTitle, streamArtist, streamAlbum);
    
	//// only update the UI if in foreground
	//AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	//if (appDelegate.uiIsVisible) {
		//metadataArtist.text = streamArtist;
		//metadataTitle.text = streamTitle;
		//metadataAlbum.text = streamAlbum;
	//}
	//self.currentArtist = streamArtist;
	//self.currentTitle = streamTitle;
}
#endif

//
// updateProgress:
//
// Invoked when the AudioStreamer
// reports that its playback progress has changed.
//
- (void)updateProgress:(NSTimer *)updatedTimer
{
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		//  [NSString stringWithFormat:@"Time Played: %.1f/%.1f seconds",progress,duration]];
		if (duration > 0)
		{/*
          [positionLabel setText:
          
          [NSString stringWithFormat:@"Time Played: 0%.2f/0%.2f seconds",
          progress/60,
          duration/60]];
          */
            
			//[progressSlider setEnabled:YES];
			//[progressSlider setValue:100 * progress / duration];
		}
		else
		{
            //			[progressSlider setEnabled:NO];
		}
	}
	else
	{
        //	positionLabel.text = @"Time Played:";
	}
}


//
// updateLevelMeters:
//

- (void)updateLevelMeters:(NSTimer *)timer {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	if([streamer isMeteringEnabled] && appDelegate.uiIsVisible) {
		[levelMeterView updateMeterWithLeftValue:[streamer averagePowerForChannel:0]
									  rightValue:[streamer averagePowerForChannel:([streamer numberOfChannels] > 1 ? 1 : 0)]];
	}
}



#pragma mark Remote Control Events
/* The iPod controls will send these events when the app is in the background */
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
	switch (event.subtype) {
		case UIEventSubtypeRemoteControlTogglePlayPause:
			[streamer pause];
			break;
		case UIEventSubtypeRemoteControlPlay:
			[streamer start];
			break;
		case UIEventSubtypeRemoteControlPause:
			[streamer pause];
			break;
		case UIEventSubtypeRemoteControlStop:
			[streamer stop];
			break;
		default:
			break;
	}
}


@end




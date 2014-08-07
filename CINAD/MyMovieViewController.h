 

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "EScrollerView.h"



@class AudioStreamer, LevelMeterView;

@interface MyMovieViewController : UIViewController   <EScrollerViewDelegate>
{
@private
    MPMoviePlayerController *moviePlayerController;
    
   
    NSTimer *timer;
    
    //////////
    UIImageView *imgView;
    UIButton *playButton;
    UIButton *stopButton;
    MPVolumeView *volume;
    UILabel *lbLoad;
    
    NSString *listenliveurl;
    NSUInteger index;
    
    NSString *imagePath;
    NSString *imageURL;
    
    
    //////
    UIButton *button;
    AudioStreamer *streamer;
	NSTimer *progressUpdateTimer;
	NSTimer *levelMeterUpdateTimer;
	LevelMeterView *levelMeterView;
}


@property (nonatomic, strong) NSString *xmlString;

@property (retain) MPMoviePlayerController *moviePlayerController;

 
////////////
@property (nonatomic, retain) UIImageView *imgView;

@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) UIButton *stopButton;
@property (nonatomic, retain) MPVolumeView *volume;
@property (nonatomic, retain) UILabel *lbLoad;

@property (nonatomic, retain) NSString *listenliveurl;

@property(nonatomic,retain)  NSString *imagePath;
@property(nonatomic,retain)  NSString *imageURL;

- (IBAction)buttonPressed:(id)sender;


@end



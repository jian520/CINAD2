 
#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsViewController.h"

@interface NewsDetail :  TTWebController  { 
     
    NewsViewController *newsController;
    UISegmentedControl *_segControl;
    News *news ;
    NSString *cpage;
    NSString *countPage;
    
}

@property(nonatomic,retain) NewsViewController *newsController;
@property(nonatomic,retain) News *news;
@property(nonatomic,retain) NSString *cpage;
@property(nonatomic,retain) NSString *countPage;
 
-(void) reset;
-(void) loadData;

-(void) requestAction ;
    
@end



//
//  NewsDetail.m
//  WCHL
//
//  Created by josepth on 11-6-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NewsDetail.h"
#import "News.h"
 
@implementation NewsDetail
 
@synthesize newsController ;
@synthesize news;
 
@synthesize cpage,countPage; 


- (void)dealloc
{ 
    [_segControl release];
    [news release];
    [cpage release];
    [countPage release];
    [super dealloc];
}


- (id)initWithNavigatorURL:(NSString *)placeholder query:(NSDictionary*)query
{
	if ((self = [self init])) {		
		self.cpage   = [query objectForKey:@"page"];
	    self.countPage   =(NSString *) [query objectForKey:@"count"];
    }	
	return self;
}
 
- (void)loadView {
	
   [super loadView];     
    NSLog(@"loadView") ;
   
    self.news = [[[News alloc] init ] autorelease];
    
  
    _segControl = [[UISegmentedControl alloc]  initWithItems:nil ];
    [_segControl setMomentary:YES];
    _segControl.segmentedControlStyle = UISegmentedControlStyleBar;
	_segControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _segControl.frame = CGRectMake(0, 0, 80.0, _segControl.frame.size.height);
    
    [_segControl insertSegmentWithImage:[UIImage imageNamed:@"arrow-white-up.png"]    atIndex:0 animated:YES];
    [_segControl insertSegmentWithImage:[UIImage imageNamed:@"arrow-white-down.png"]  atIndex:1 animated:YES];
    
    [_segControl addTarget:self action:@selector(segmentedActions) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentBarItem= [[UIBarButtonItem alloc] initWithCustomView:_segControl];

    [self.navigationItem setRightBarButtonItem:segmentBarItem animated:YES];

    [_toolbar setHidden:YES];
    
}
 
-(NSString *)changeCurrPage:(NSString  *) page   
{
	page = [ page  stringByAppendingString:@" of "];
	return [page  stringByAppendingString: self.countPage ] ;
    
}

- (void)loadData
{    
   
   
    
    [_segControl setEnabled:[self.newsController canSelectPreviousStory] forSegmentAtIndex:0];
    [_segControl setEnabled:[self.newsController canSelectNextStory]     forSegmentAtIndex:1];
        
    self.title  = [self changeCurrPage:self.cpage];
    
    NSURL *url = [NSURL URLWithString:  self.news.smartmobileLink];
    _webView.scalesPageToFit = NO;
    _webView.autoresizesSubviews = NO;
    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    [self openURL:url] ;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateToolbarWithOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    if(TTIsPad())
        _webView.height = 960.0f;
    else
        _webView.height = 416.0f;
        
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidStartLoad:(UIWebView*)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    self.title  = [self changeCurrPage:self.cpage];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidFinishLoad:(UIWebView*)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    self.title  = [self changeCurrPage:self.cpage];
}

/*
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
      
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) { 
        NSString *URL = [[request URL] absoluteString];
        
        if ([URL hasPrefix:@"http://"])
        {   self.hidesBottomBarWhenPushed = YES ;
            
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            TTWebController1 *webController = [[[TTWebController1 alloc] init] autorelease];
            [webController openURL:[NSURL URLWithString:URL]];
            [self.navigationController pushViewController:webController animated:YES];
            [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Story" style:UIBarButtonItemStylePlain target:nil action:nil]];
            
            return NO;
        }
    }
    
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    // NSLog(@"components%@" , components);
    
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"myweb"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"]) 
        {
            
            NSTimeInterval delaytime = 0.3f;
            if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"start"]) 
            {
                
                NSLog(@"touch start!");
                
                [self performSelector:@selector(singleTap) withObject:nil afterDelay:delaytime];
            }
            else if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"move"])
            {
                
                [self.navigationController setNavigationBarHidden:TRUE animated:YES ];
                [_toolbar setHidden:TRUE] ;
            
                _webView.height =460.0f;  
                

                NSLog(@"you are move");
                
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTap) object:nil];
                
            }
            
        }
        return NO;
    }
    return YES;
}

-(void)singleTap
{
    [self.navigationController setNavigationBarHidden:FALSE animated:YES ];
    //[_toolbar setHidden:FALSE] ;
    
}*/
   

- (void)segmentedActions 
{
    NSInteger page = [self.cpage intValue ] ;
    NSInteger i = _segControl.selectedSegmentIndex;
    
    if (i == 0) { // previous
        page-=1;
        self.news  = [self.newsController selectPreviousStory];
    } else { // next
        page+=1;
        self.news  = [self.newsController selectNextStory ];
    }
    self.cpage = [NSString stringWithFormat:@"%d",page];
 
    [self loadData] ; 
    
}

@end

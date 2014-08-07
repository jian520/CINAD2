//
//  About.m
//  KKAJ
//
//  Created by josepth on 11-7-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "About.h"
 

@implementation About
@synthesize url;
@synthesize webView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                                target:self action:@selector(dismiss)] autorelease];
    }
    return self;
}
- (void)dismiss {
    
    [self.parentViewController  dismissModalViewControllerAnimated:YES];
     
}

- (void)dealloc
{
    [webView release] ;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    CGRect rect =   [UIScreen mainScreen].applicationFrame ;
    
    webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, rect.origin.y-20, rect.size.width,rect.size.height) ];
    
    webView.scalesPageToFit=YES;
    // [ webView   setUserInteractionEnabled: YES ];  
    
    webView.delegate = self;
    [self.view  addSubview : webView];  
    
    [webView loadRequest: [NSURLRequest requestWithURL: [[ NSURL alloc ] initWithString :@"http://www.intertechmedia.com/contact-us/535719"]
                                                            cachePolicy: NSURLRequestUseProtocolCachePolicy 
                                                        timeoutInterval: 60.0]];     
}

+ (void)showModal:(UINavigationController*)parentController    
{ 
    
	static About* sharedController;
	static UINavigationController *navigationController;
 	if(!sharedController)
	{
		sharedController = [[About alloc]  initWithNibName:nil bundle:nil ];
        
		navigationController = [[UINavigationController alloc] initWithRootViewController:sharedController];
	} 
	[parentController presentModalViewController:navigationController animated:YES];
   
}
 
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;	 
}


@end

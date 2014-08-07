//
//  TTWebViewController.m
//  WCHL
//
//  Created by joseph on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TTWebViewController.h"

@interface TTWebViewController ()

@end

@implementation TTWebViewController
@synthesize flag;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationController.navigationBarHidden = NO;
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    
    
    if (TTIsPad()) {
 
        if (flag == nil ) {
           _webView.top = 63;   
        }
       
    }
	// Do any additional setup after loading the view.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateToolbarWithOrientation:(UIInterfaceOrientation)interfaceOrientation {
    _toolbar.height = TTToolbarHeight();
    if (!TTIsPad()) {
        _webView.height = self.view.height - _toolbar.height;
         
         _toolbar.top = self.view.height - _toolbar.height;
    }else {
        
        if (flag == nil ) {
            _webView.height = 555;
            _toolbar.top = self.view.height -88; 
        } 
       
    }
   
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

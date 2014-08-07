
#import "AdiWebView.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
@implementation AdiWebView


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
       
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                   target:self action:@selector(dismiss)] autorelease];
    }
    return self;
}
- (void)dismiss {
    
    [self.parentViewController  dismissModalViewControllerAnimated:YES];
    
    TTNavigator* navigator = [(AppDelegate *)[[UIApplication sharedApplication] delegate]  navigator ];
    CGRect r = [ UIScreen mainScreen ].applicationFrame;
    
    MainTabBarController *mainTab =  (MainTabBarController *)navigator.rootViewController;
    TTNavigationController *ttnav  = (TTNavigationController *)mainTab.topSubcontroller;
    ttnav.topViewController.navigationController.navigationBar.frame = CGRectMake(0, 20, r.size.width,78 );
    
}


/**
 
 - (void)viewWillAppear:(BOOL)animated {
 
 TTNavigator* navigator = [(AppDelegate *)[[UIApplication sharedApplication] delegate]  navigator ];
 CGRect r = [ UIScreen mainScreen ].applicationFrame;
 
 MainTabBarController *mainTab =  (MainTabBarController *)navigator.rootViewController;
 
 TTNavigationController *ttnav  = (TTNavigationController *)mainTab.topSubcontroller;
 
 NSLog(@"%@", ttnav.topViewController) ;
 
 ttnav.topViewController.navigationController.navigationBar.frame = CGRectMake(0, 20, r.size.width,78 );
 
 }
 */

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidStartLoad:(UIWebView*)webView {
    self.title = TTLocalizedString(@"Loading...", @"");
    if (!self.navigationItem.leftBarButtonItem) {
        [self.navigationItem setLeftBarButtonItem:_activityItem animated:YES];
    }
    [_toolbar replaceItemWithTag:3 withItem:_stopButton];
    _backButton.enabled = [_webView canGoBack];
    _forwardButton.enabled = [_webView canGoForward];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidFinishLoad:(UIWebView*)webView {
    TT_RELEASE_SAFELY(_loadingURL);
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.navigationItem.leftBarButtonItem == _activityItem) {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
    [_toolbar replaceItemWithTag:3 withItem:_refreshButton];
    
    _backButton.enabled = [_webView canGoBack];
    _forwardButton.enabled = [_webView canGoForward];
}


 
@end

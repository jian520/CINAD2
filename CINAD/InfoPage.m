//
//  InfoPage.m
//  WLTJ
//
//  Created by joseph on 13-7-17.
//
//

#import "InfoPage.h"

@interface InfoPage ()

@end

@implementation InfoPage
@synthesize  webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed =  NO;
        
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Info page"
														 image:[UIImage imageNamed:@""]
														   tag:0] autorelease];
        self.title=@"Info page";
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
    webView = [[UIWebView alloc] initWithFrame:   self.view.frame ];
    webView.scalesPageToFit=NO;
    // [ webView   setUserInteractionEnabled: YES ];
    
    webView.backgroundColor = [UIColor clearColor] ;
    
    webView.delegate = self;
    [self.view  addSubview : webView];
    
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",nil];
    
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    [segmentedArray release];
    [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar] ;
    segmentedControl.frame = CGRectMake(0, 0, 70, 30);
    [segmentedControl setImage: [UIImage imageNamed:@"backIcon.png"]    forSegmentAtIndex:0];
    [segmentedControl setImage: [UIImage imageNamed:@"forwardIcon.png"]  forSegmentAtIndex:1];
    //    [segmentedControl setSelected:FALSE];
    //[segmentedControl setEnabled:TR forSegmentAtIndex:0];
    // [segmentedControl setEnabled:FALSE forSegmentAtIndex:1];
    [segmentedControl addTarget:self  action:@selector(segSelect:) forControlEvents:UIControlEventValueChanged ] ;
    
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    self.navigationItem.rightBarButtonItem = segmentBarItem;
    [segmentBarItem release];
    
    
    
    if (TTIsPad()) {
        
    }else {
        NSDictionary *userAgentDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/5.1 Mobile/9A405 Safari/7534.48.3", @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:userAgentDictionary];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:   [[NSUserDefaults standardUserDefaults] objectForKey:@"infoUrl" ]   ]];
    
    [webView loadRequest:  request ];
    
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //  NSLog(@"expected:%d, got:%d", UIWebViewNavigationTypeLinkClicked, navigationType);
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        self.hidesBottomBarWhenPushed = YES ;
        NSString *URL = [[request URL] absoluteString];
        // TTOpenURL(URL);
        [self.navigationController setNavigationBarHidden:NO animated:YES  ];
        
        TTWebController *webController = [[[TTWebController alloc] init] autorelease];
        [webController openURL:[NSURL URLWithString:URL]];
        
        [self.navigationController pushViewController:webController animated:YES];
        
        return NO;
    }
    return YES;
}


-(IBAction) segSelect:(id)sender
{
    //NSLog(@"%d",[sender selectedSegmentIndex]) ;
    
    switch([sender selectedSegmentIndex])
	{
		case 0:
            [webView goBack];
            
            [segmentedControl setSelectedSegmentIndex:0];
            
            break;
		case 1:
            [webView goForward];
            [segmentedControl setSelectedSegmentIndex:1];
            
			break;
		default:
			break;
	}
    [NSTimer scheduledTimerWithTimeInterval:0.05f
                                     target:self
                                   selector:@selector(BeginThread)
                                   userInfo:nil repeats:NO];
}
- (void)BeginThread
{
    [segmentedControl setSelectedSegmentIndex:-1];
    
}
@end

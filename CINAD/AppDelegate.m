//
//  AppDelegate.m
//  WZIM
//
//  Created by josepth on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "MyMovieViewController.h"
#import "ClockViewController_iPhone.h"


#import "NewsViewController.h"
#import "NewsDetail.h"
#import "PhotoViewController.h"
#import "STeamViewController.h"

#import "BNDefaultStylesheet.h"


#import "FBView.h"
#import "TView.h"
#import "Website.h"
#import "InfoPage.h"
#import "SignUpView.h"

#import "Settings.h"

#import "RemindEdit.h"

#import "MyClass.h"
#import "GetXML.h"


#import "AdiWebView.h"
 
@implementation AppDelegate
@synthesize navigator;

@synthesize uiIsVisible;

/*these 2 methods get called periodically to keep stuff up to date*/
-(void)updateClockLoop
{
    [clockViewController setDate:[NSDate date]];
    [self performSelector:@selector(updateClockLoop) withObject:nil afterDelay:1.0];
}


/*reset all the alarms. We call this whenever settings or locations have changed, whenever the app starts or wakes up.*/
-(void)updateAlarms
{
  //  Settings*settings = [Settings sharedSettings];
    //[scheduler rescheduleLatitude:settings.lat longitude:settings.lon];
    
    /*also update the "on" indicator in the clock.*/

    
}

- (void)applicationDidFinishLaunching:(UIApplication*)application  
{
    alarm = [[Alarm alloc] init];
   
    self.uiIsVisible = YES;
    
    [UIApplication sharedApplication ].statusBarStyle  = UIStatusBarStyleBlackTranslucent;
   
    [TTStyleSheet setGlobalStyleSheet:[[[BNDefaultStyleSheet alloc]   
										init] autorelease]];
    
    navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeNone;
    navigator.supportsShakeToReload = YES;
  //  navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    
    TTURLMap* map = navigator.URLMap;
    
    // Any URL that doesn't match will fall back on this one, and open in the web browser
   // [map from:@"*" toModalViewController:[TTWebController class]];
    [map from:@"*" toModalViewController:[AdiWebView class]];
    // The tab bar controller is shared, meaning there will only ever be one created.  Loading
    // This URL will make the existing tab bar controller appear if it was not visible.
    [map from:@"tt://tabBar" toSharedViewController:[MainTabBarController class]];
    
    [map from:@"tt://listen"       toViewController:[MyMovieViewController class]];
    [map from:@"tt://clock"        toViewController:[ClockViewController_iPhone class]];
    [map from:@"tt://remindEdit"   toViewController:[RemindEdit class]];
    
    // [map from:@"tt://news"          toViewController:[NewsViewController    class]];
   // [map from:@"tt://newsDetail/(initWithNavigatorURL:)" toViewController:[NewsDetail class]];
    
   // [map from:@"tt://photo"  toViewController:[PhotoViewController   class]];
    [map from:@"tt://steam"  toViewController:[STeamViewController   class]];
   
    [map from:@"tt://stationFB" toViewController:[FBView     class]];
    [map from:@"tt://stationT"  toViewController:[TView      class]];
    [map from:@"tt://website"   toViewController:[Website    class]];
    [map from:@"tt://infopage"  toViewController:[InfoPage   class]];
    [map from:@"tt://signup"    toViewController:[SignUpView class]];
    
    
   //  [map from:@"tt://test"    toViewController:[TestViewController class]];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[UIApplication sharedApplication ]  setStatusBarStyle:UIStatusBarStyleLightContent];
        //  self.window.clipsToBounds =YES;
        
   //     navigator.window.frame =  CGRectMake(0,20,navigator.window.frame.size.width,navigator.window.frame.size.height-20);
        
        //Added on 19th Sep 2013
        // self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    }
    
    
    

    [self requestAction ] ;
    
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
        [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
        return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{ 
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification") ;
   //  [alarm play] ;
    

    MainTabBarController*main = (MainTabBarController*) navigator.rootViewController;
    TTNavigationController*nav = (TTNavigationController*)[[main viewControllers] objectAtIndex:0 ]  ;
    
    NSLog(@"df%@", nav.topViewController ) ;
    
    MyMovieViewController*my    =(MyMovieViewController*) nav.topViewController ;
    [my buttonPressed:nil ];
    
   
    //[self requestAction ] ;

}





- (void) requestAction   {
    
    TTURLRequest* request = [TTURLRequest requestWithURL:@"http://s3.amazonaws.com/awsstatic/image/cinad/mobile_xml/cinad.xml"
                                                delegate:self];
    request.cachePolicy = TTURLRequestCachePolicyNetwork ;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
    response.isRssFeed = YES;
    request.response = response;
    TT_RELEASE_SAFELY(response);
    
    [request send];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTURLRequestDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    // [_requestButton setTitle:@"Loading..." forState:UIControlStateNormal];
    
    // NSLog(@"Loading...") ;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    
    
    
    
    TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
    
    //  NSLog(@"%@" ,response.rootObject );
    
    
    NSString *iosStreamUrl = [[[response rootObject] objectForKey:@"iosStreamUrl"] objectForXMLNode ];
    
    NSString *facebook     = [[[response rootObject] objectForKey:@"facebook"] objectForXMLNode ];
    NSString *twitter      = [[[response rootObject] objectForKey:@"twitter"] objectForXMLNode ];
    
    NSString *websiteUrl   = [[[response rootObject] objectForKey:@"websiteUrl"] objectForXMLNode ];
    NSString *fgUrl        = [[[response rootObject] objectForKey:@"fgUrl"] objectForXMLNode ];
    
    NSString *signupUrl    = [[[response rootObject] objectForKey:@"signupUrl"] objectForXMLNode ];
    NSString *infoUrl      = [[[response rootObject] objectForKey:@"infoUrl"] objectForXMLNode ];
    
    
    
    NSString *headerImage     = [[[response rootObject] objectForKey:@"headerImage"] objectForXMLNode ];
    NSString *bannerGroupId  = [[[response rootObject] objectForKey:@"bannerGroupId"] objectForXMLNode ];
  //  NSString *featureGroup    = [[[response rootObject] objectForKey:@"featureGroup"] objectForXMLNode ];
    
    /**
    NSString *uploadurl     = [[[response rootObject] objectForKey:@"uploadurl"] objectForXMLNode ];
    NSString *stationid     = [[[response rootObject] objectForKey:@"stationid"] objectForXMLNode ];
    NSString *photocontentid  = [[[response rootObject] objectForKey:@"photocontentid"] objectForXMLNode ];
    NSString *videocontentid  = [[[response rootObject] objectForKey:@"videocontentid"] objectForXMLNode ];
    
    [[NSUserDefaults standardUserDefaults] setObject:uploadurl      forKey:@"uploadurl"];
    [[NSUserDefaults standardUserDefaults] setObject:stationid      forKey:@"stationid"];
    [[NSUserDefaults standardUserDefaults] setObject:photocontentid forKey:@"photocontentid"];
    [[NSUserDefaults standardUserDefaults] setObject:videocontentid forKey:@"videocontentid"];
    
    */
    
   NSLog(@"facebook%@" , facebook);
    NSLog(@"twitter%@" , twitter);
    
    NSLog(@"websiteUrl%@" , websiteUrl);
    NSLog(@"fgUrl%@" , fgUrl);
    NSLog(@"bannerGroupId%@" , bannerGroupId);
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:iosStreamUrl forKey:@"iosStreamUrl"];
    [[NSUserDefaults standardUserDefaults] setObject:facebook forKey:@"facebook"];
    [[NSUserDefaults standardUserDefaults] setObject:twitter  forKey:@"twitter"];
    
    [[NSUserDefaults standardUserDefaults] setObject:websiteUrl forKey:@"websiteUrl"];
    [[NSUserDefaults standardUserDefaults] setObject:fgUrl      forKey:@"fgUrl"];
    
    [[NSUserDefaults standardUserDefaults] setObject:signupUrl  forKey:@"signupUrl"];
    [[NSUserDefaults standardUserDefaults] setObject:infoUrl    forKey:@"infoUrl"];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:headerImage    forKey:@"headerImage"];
    
    [[NSUserDefaults standardUserDefaults] setObject:bannerGroupId forKey:@"bannerGroupId"];
  //  [[NSUserDefaults standardUserDefaults] setObject:featureGroup   forKey:@"featureGroup"];
    
    
   // [MyClass parseDefault];
   
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTable" object:self userInfo:nil ];
    
    
    if (![navigator restoreViewControllers]) {
        // This is the first launch, so we just start with the tab bar
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
        
    }
    
    
    //MainTabBarController*main = (MainTabBarController*) navigator.rootViewController;
    
   // TTNavigationController*nav = (TTNavigationController*)[[main viewControllers] objectAtIndex:1 ]  ;
    
   // NSLog(@"df%@", nav.topViewController ) ;
    
    //clockViewController =(ClockViewController_iPhone*) nav.topViewController ;
    
    //[self updateClockLoop];
    
    
  
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"APP Failed to load, try again.");
}


@end

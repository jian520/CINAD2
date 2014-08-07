 

#import "MainTabBarController.h"
#import "Three20UI/UITabBarControllerAdditions.h"
 

@implementation  MainTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	
    [self setTabURLs:[NSArray arrayWithObjects: @"tt://listen",@"tt://remindEdit",@"tt://stationFB",@"tt://stationT",@"tt://website", @"tt://infopage"  , nil]];
    
    [self setSelectedIndex:0];
     self.moreNavigationController.delegate = self;
     self.delegate = self;
 
     
}

/**- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
 
    
    return NO;
}
  
 
- (void)navigationController: (UINavigationController *)navigationController
      willShowViewController: (UIViewController *)viewController
                    animated: (BOOL)animated {
    UINavigationBar* morenavbar = navigationController.navigationBar;
    UINavigationItem* morenavitem = morenavbar.topItem;
    morenavitem.rightBarButtonItem.title=@"Configure"  ;//= nil;
    
  
}*/

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

  //  NSLog(@"currentController index:%d",viewController.tabBarController.selectedIndex);  
    
}
 
 

@end
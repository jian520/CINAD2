#import "NewsViewController.h"
#import "NewsTableViewDelegate.h"
#import "NewsDataSource.h"
#import "NewsTableItem.h"
#import "NewsModel.h"
@implementation NewsViewController
 
 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"News" 
														 image:[UIImage imageNamed:@"tabicon-news.png"] 
														   tag:0] autorelease];
        self.title=@"News" ;
      
        self.statusBarStyle = UIStatusBarStyleBlackTranslucent;    
	}
 
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (id<UITableViewDelegate>)createDelegate {
   
	return [[[NewsTableViewDelegate alloc] initWithController:self] autorelease];
}

- (void)dealloc {

	[super dealloc];
}

- (void)loadView {
	[super loadView];
     self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTable:)
     name:@"refreshTable"
     object:nil ];
    
    
    
}

-(void)refreshTable:(NSNotification*)notification
{

    
    self.dataSource = [[[NewsDataSource alloc] initWithUrl:  [[NSUserDefaults standardUserDefaults] objectForKey:@"iphone_newsurl" ]  ] autorelease];
}
 
-(void) createModel 
{
    if (  [[NSUserDefaults standardUserDefaults] objectForKey:@"iphone_newsurl" ]   !=nil ) {
        self.dataSource = [[[NewsDataSource alloc] initWithUrl:  [[NSUserDefaults standardUserDefaults] objectForKey:@"iphone_newsurl" ]  ] autorelease]; 
    }
    
    
}

- (BOOL)canSelectPreviousStory {
    NSIndexPath *currentIndexPath = [_tableView indexPathForSelectedRow];
	if (currentIndexPath.row > 0) {
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)canSelectNextStory {
    
    NewsModel *m = (NewsModel *)self.model;
    NSIndexPath *currentIndexPath = [_tableView  indexPathForSelectedRow];
	if (currentIndexPath.row + 1 < [m.newsArray count] ) {
		return YES;
	} else {
		return NO;
	}
}

- (News *)selectPreviousStory  {
	News  *prevStory = nil;
	if ([self canSelectPreviousStory]) {
        NSIndexPath *currentIndexPath = [_tableView indexPathForSelectedRow];
		NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row - 1 inSection:currentIndexPath.section];
        
        prevStory =[self getNewsItem:prevIndexPath]; 
		[_tableView selectRowAtIndexPath:prevIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
	}
	return prevStory;
}
- (News *)selectNextStory     {
    
	News *nextStory = nil;
	if ([self canSelectNextStory]) {
        NSIndexPath *currentIndexPath = [_tableView indexPathForSelectedRow];
		NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row + 1 inSection:currentIndexPath.section];
        nextStory =[self getNewsItem:nextIndexPath];
		[_tableView selectRowAtIndexPath:nextIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
	}
	return nextStory;
}  
- (News *)getNewsItem :(NSIndexPath * )currentIndexPath{
    News *news = nil;
    id<TTTableViewDataSource> dataSource = (id<TTTableViewDataSource>)_tableView.dataSource;
    id object = [dataSource tableView:_tableView  objectForRowAtIndexPath:currentIndexPath];
    if ([object isKindOfClass:[NewsTableItem class]]) {
        NewsTableItem* item = object;
        news =  item.news  ;
    } 
    return news;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    NewsModel *m = (NewsModel *)self.model;
    NSString *count  = [NSString stringWithFormat:@"%d"  , [m.newsArray count ]];
    
    if ([object isKindOfClass:[NewsTableItem class]]) { 
        NSInteger i = [indexPath  row ];
        NSString *page = [NSString stringWithFormat:@"%d" ,++i]; 
		NSDictionary *query = [NSDictionary
							   dictionaryWithObjectsAndKeys:
                               page , @"page",count ,@"count"  , 
                               nil];
            
        TTNavigator* navigator = [TTNavigator navigator];
        [navigator openURLAction:[[[TTURLAction actionWithURLPath:@"tt://newsDetail/1" ] applyQuery:query] applyAnimated:YES]];
        
        NewsDetail * newsDetail = (NewsDetail *) navigator.topViewController;
        newsDetail.newsController = self;
        newsDetail.news = [self getNewsItem:indexPath];
        [newsDetail loadData ];
	}
} 
 

@end

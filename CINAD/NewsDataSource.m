 
#import "NewsDataSource.h"
#import	"NewsModel.h"
#import "News.h"
#import "NewsTableItem.h"
#import "CustomerTableCell.h"
 
 
@implementation NewsDataSource 
 
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
    
    if ([object isKindOfClass:[TTTableSubtitleItem class]]) {
      
        
        return [CustomerTableCell class];
    } else  {
        return [super tableView:tableView cellClassForObject:object];
    }
}
 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithUrl:(NSString*)urlString {
	if (self == [super init]) {
		_searchNewsModel = [[NewsModel alloc] initWithUrl:urlString];
	}
	
	return self;
}
 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_model);
     
	[super dealloc];
}

 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _searchNewsModel;
}
 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
   
    NSMutableArray* items = [[NSMutableArray alloc] init];
    // int i = 0 ;
	for (News* news in _searchNewsModel.newsArray) {
         
      //  NSString * url   =[NSString stringWithFormat:@"wchl://newsDetail/%d" ,++i];
 
        
        NewsTableItem  *tableItem=  
        [NewsTableItem itemWithText:news.title
                       subtitle: news.date 
                       imageURL:news.imgLink 
                       defaultImage:TTIMAGE(@"bundle://icon.png")
                       URL:nil
                       accessoryURL:nil ];                             
        tableItem.news = news;
		[items addObject:tableItem];
             
	}
	self.items = items;
	TT_RELEASE_SAFELY(items);    
}
 
@end

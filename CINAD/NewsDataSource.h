 
@class NewsModel;

@interface NewsDataSource : TTListDataSource  {
	NewsModel	*_searchNewsModel;
	BOOL		_isSearching;
    
}
 
- (id)initWithUrl:(NSString*)urlString;
  
@end

 
#import "Three20/Three20.h"
#import "News.h"
 
 
@interface NewsTableItem : TTTableSubtitleItem {
	News *_news;
}

@property (nonatomic, retain) News *news;

@end

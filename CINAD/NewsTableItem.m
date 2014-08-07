 
#import "NewsTableItem.h"

 
 
@implementation NewsTableItem

@synthesize news	= _news;
 

- (void)dealloc {
	TT_RELEASE_SAFELY(_news);
	[super dealloc];
}

@end

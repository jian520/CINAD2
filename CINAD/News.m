 
#import "News.h"

@implementation News
@synthesize newsId          =   _newsId;
@synthesize link		    =	_link;
@synthesize imgLink         =   _imgLink;
@synthesize smartmobileLink =   _smartmobileLink;
@synthesize description	    =	_description;
@synthesize title		    =	_title;
@synthesize date		    =	_date;

- (void) dealloc {
    TT_RELEASE_SAFELY(_newsId);
	TT_RELEASE_SAFELY(_link);
    TT_RELEASE_SAFELY(_imgLink);
    TT_RELEASE_SAFELY(_smartmobileLink);
	TT_RELEASE_SAFELY(_description);
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_date);
	[super dealloc];
}
@end

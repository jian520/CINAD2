 

#import "Photo.h"

@implementation Photo
 
@synthesize title = _title;
@synthesize caption=_caption;

@synthesize smallImgURL		    =	_smallImgURL;
@synthesize bigImgURL       	=	_bigImgURL;
 
- (void) dealloc {
    TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_caption);
	TT_RELEASE_SAFELY(_smallImgURL);
	TT_RELEASE_SAFELY(_bigImgURL);
	 
	[super dealloc];
}

@end


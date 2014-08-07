
#import "Three20/Three20.h"
 

@interface NewsModel : TTURLRequestModel   {
    NSString       *_urlString;
 
	NSMutableArray *_newsArray;
 
}
@property (nonatomic, copy)   NSString       *urlString;
 
@property (nonatomic, readonly)	NSMutableArray*	newsArray;

- (id)initWithUrl:(NSString*)urlString;
 
-(void)getValue:(NSDictionary*) entry;
@end

 
#import "News.h"
@interface NewsViewController : TTTableViewController  
 

- (BOOL)canSelectPreviousStory;
- (BOOL)canSelectNextStory;
- (News *)selectPreviousStory ;
- (News *)selectNextStory     ;
- (News *)getNewsItem :(NSIndexPath * )currentIndexPath;


 
@end

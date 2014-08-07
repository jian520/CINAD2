
#import "NewsTableViewDelegate.h"

 
@implementation NewsTableViewDelegate


 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if (TTIsPad()) 	return 160.0f;
	
    return 70.0f;
}


@end

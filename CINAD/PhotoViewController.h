 
@interface PhotoViewController : TTThumbsViewController {
    NSMutableArray  *_array;
}

@property(nonatomic,retain)  NSMutableArray  *array;

- (void) requestAction ;
- (void) getValue:(NSDictionary*) entry;
@end

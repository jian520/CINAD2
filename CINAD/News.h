@interface News : NSObject   {
	NSNumber*   _newsId;
    NSString*	_link;
    NSString*	_imgLink;
    NSString*   _smartmobileLink;
	NSString*	_description;
	NSString*	_title;
	NSString*	_date;
}
@property (nonatomic, retain) NSNumber* newsId;
@property (nonatomic, copy)   NSString* link;
@property (nonatomic, copy)   NSString* imgLink;
@property (nonatomic, copy)   NSString* smartmobileLink;

@property (nonatomic, copy)   NSString* description;
@property (nonatomic, copy)   NSString* title;
@property (nonatomic, copy)   NSString* date;
 
@end

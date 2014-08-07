 
@interface Photo : NSObject  {
    NSString *_title;
    NSString *_caption;
	NSString *_smallImgURL;
	NSString *_bigImgURL;
}
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* caption;

@property (nonatomic, copy) NSString* smallImgURL;
@property (nonatomic, copy) NSString* bigImgURL;
 
@end

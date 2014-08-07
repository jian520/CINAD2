#import "PhotoViewController.h"
#import "MockPhotoSource.h"
#import "Photo.h"


@implementation PhotoViewController

 
@synthesize array = _array;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed =  NO;
       
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Photos" 
														 image:[UIImage imageNamed:@"tabicon-gallery.png"] 
														   tag:0] autorelease];
        self.title=@"Photos";
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
       
   [self requestAction] ;
    
}

- (void)dealloc {
	 
    TT_RELEASE_SAFELY(_array);
	[super dealloc];
}


- (void) requestAction   {
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    TTURLRequest* request = [TTURLRequest requestWithURL:  [[NSUserDefaults standardUserDefaults] objectForKey:@"iphone_photosurl" ]    delegate:self];
    
    request.cachePolicy = TTURLRequestCachePolicyNetwork ;
    request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
    response.isRssFeed = YES;
    request.response = response;
    TT_RELEASE_SAFELY(response);
    
    [request send];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTURLRequestDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidStartLoad:(TTURLRequest*)request {
    // [_requestButton setTitle:@"Loading..." forState:UIControlStateNormal];
    
    // NSLog(@"Loading...") ;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
    
    TTURLXMLResponse* response = request.response;
	//TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	NSDictionary* feed = [[response rootObject] objectForKey:@"channel"];
    
	//TTDASSERT([[feed objectForKey:@"item"] isKindOfClass:[NSDictionary class]]);
	NSDictionary* entries = [feed objectForKey:@"item"];
    _array = [[NSMutableArray alloc] initWithCapacity:[entries count]];
    
    if(entries == nil  ){
        entries = feed;
    }
    if ([entries isKindOfClass:[NSDictionary class]]) { 
        
        [self getValue: entries];
    }
    for (NSDictionary* entry in entries) {
            if ([entry isKindOfClass:[NSDictionary class]]) 
                [self getValue: entry];
      
    }
    
       
   [self createPhoto];
    
}

-(void)getValue:(NSDictionary*) entry
{
    Photo* item = [[[Photo alloc] init] autorelease];
    NSArray *str  =  [[entry objectForKey:@"media:group"]  objectForKey:@"media:content"  ] ;
    NSDictionary *str1 =  [str objectAtIndex:0];
    item.bigImgURL  =[str1 objectForKey:@"url"];
    
    str1 =  [str objectAtIndex:1];
    item.smallImgURL=[str1 objectForKey:@"url"];
    
    item.title    = [[entry objectForKey:@"title"] objectForXMLNode];
    item.caption  = [[entry objectForKey:@"caption"] objectForXMLNode];
    item.caption  = [item.caption stringByRemovingHTMLTags ];
    [_array addObject:item];
    
} 

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(TTURLRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"Failed to load, try again.");
}


-(void ) createPhoto {
    
    NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease ];
    for (Photo *feed in  _array ) {
        
        [array addObject:  [[[MockPhoto alloc]
                             initWithURL: feed.bigImgURL
                             smallURL: feed.smallImgURL
                             size:CGSizeMake(500, 375)
                             caption:  feed.caption  ] autorelease]   ] ;
        
    }
    
    self.photoSource = [[MockPhotoSource alloc]
                        initWithType:MockPhotoSourceNormal
                        //initWithType:MockPhotoSourceDelayed
                        // initWithType:MockPhotoSourceLoadError
                        // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
                        title:@"Photos" 
                        photos:array
                        
                        photos2:nil
                        //  photos2:[[NSArray alloc] initWithObjects:
                        //    [[[MockPhoto alloc]
                        //      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
                        //      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
                        //      size:CGSizeMake(800, 533)] autorelease],
                        //    nil]
                        ];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTModelViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didRefreshModel {
    [super didRefreshModel];
    self.title =@"Photos" ;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setPhotoSource:(id<TTPhotoSource>)photoSource {
    if (photoSource != _photoSource) {
        [_photoSource release];
        _photoSource = [photoSource retain];
        
        self.title =@"Photos" ;
        self.dataSource = [self createDataSource];
    }
}

 
@end

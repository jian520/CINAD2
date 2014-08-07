 
#import "NewsModel.h"
#import "News.h"
#import "MyClass.h"
 
@implementation NewsModel
@synthesize urlString =_urlString;

@synthesize newsArray	= _newsArray;
 
- (id)initWithUrl:(NSString *)urlString {
	if (self == [super init]) {
        
        self.urlString = urlString;
        _newsArray = [[NSMutableArray array] retain];
    }
	return self;
}

- (void) dealloc {
 
	TT_RELEASE_SAFELY(_urlString);
	TT_RELEASE_SAFELY(_newsArray);
 
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    
	if (!self.isLoading) {
           
        [_newsArray removeAllObjects];
        TTURLRequest* request = [TTURLRequest requestWithURL:_urlString delegate:self];
        request.cachePolicy = cachePolicy;
        request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
			
        TTURLXMLResponse* response = [[TTURLXMLResponse alloc] init];
        response.isRssFeed = YES;
        request.response = response;
        TT_RELEASE_SAFELY(response);
        
        [request send];
	}
}
 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary *feed = [[response rootObject] objectForKey:@"channel"];
	NSDictionary *entries = [feed objectForKey:@"item"];
   
    if(entries == nil  )
    {
        entries = feed;
    }
    if ([entries isKindOfClass:[NSDictionary class]]) { 
          
          [self getValue: entries];
    }
    int i=0;
	for (NSDictionary* entry in entries) {
		i++;
        if (i>25)  break;         
		if ([entry isKindOfClass:[NSDictionary class]]) 
            [self getValue: entry];
    }
	[super requestDidFinishLoad:request];
}

-(void)getValue:(NSDictionary*) entry
{
        News* item = [[[News alloc] init]autorelease  ];
     //   item.link = [[entry objectForKey:@"link"] objectForXMLNode ];
        
        item.imgLink= [[entry objectForKey:@"media:thumbnail"] objectForKey:@"url"];
        
        if (TTIsPad()) {
            item.smartmobileLink  = [[entry objectForKey:@"link"] objectForXMLNode];
        }else
        {
            item.smartmobileLink  = [[entry objectForKey:@"mobile:appmobileLink"] objectForXMLNode];
            NSRange range =  [item.smartmobileLink    rangeOfString:@"contentType=4" ];
            if (range.length ==13    ) {
                item.smartmobileLink = [item.smartmobileLink stringByAppendingString:@"&hideminify=1"];
                item.smartmobileLink = [item.smartmobileLink stringByAppendingString:@"&hidejquery=1"];
            }
        }
    
    
        item.title = [[entry objectForKey:@"title"] objectForXMLNode];
        NSString *d   = [[entry objectForKey:@"pubDate"] objectForXMLNode];
        item.date =[MyClass fixHours:d];
       [_newsArray addObject:item];
    
    //    [self  add :item ];  
    
    
} 

 

@end

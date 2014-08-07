

#import "SecondViewController.h"
#import "ASIFormDataRequest.h"
 

@implementation SecondViewController
@synthesize imageView;
@synthesize image;
@synthesize path;
@synthesize desc;
@synthesize name;
@synthesize progressIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];	
        [UIApplication sharedApplication ].statusBarStyle  = UIStatusBarStyleBlackTranslucent;
        
    }
    return self;
}

- (void)keyboardWillShow: (NSNotification*) aNotification {	
	
	//if ([userTextField isEditing] || [passTextField isEditing] || [passTextField2 isEditing] ) return;
	
	[UIView  beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration:0.3];
	
	CGRect rect = self.view.frame;
	
	rect.origin.y -= 185; 
    
	
	[[self view] setFrame: rect];
	
	[UIView commitAnimations];
	
	_movedUp = YES;
}

- (void) keyboardWillHide: (NSNotification*) aNotification {
	
	if (!_movedUp) return;
	
	[UIView beginAnimations:nil context:NULL];
	
	[UIView setAnimationDuration:0.3];
	
	CGRect rect = [[self view] frame];
	
	rect.origin.y += 185; 
	
	[[self view] setFrame: rect];
	
	[UIView commitAnimations];
	
	_movedUp = NO;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIBarButtonItem *button=  [[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel  
                               target:self 
                               action:@selector(cancel) ] ;
    self.navigationController.navigationBar.alpha = 0.5f;
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
 
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc
{
    [super dealloc];
    [imageView release];
    [image release];
    [path release];
    [desc release];
    [name release];
    [progressIndicator release];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


 

+ (void)showModal:(UINavigationController*)parentController:(UIImage *) img
{ 
     
	static SecondViewController* sharedController;
	static UINavigationController *navigationController;
 //	if(!sharedController)
	{
		sharedController = [[SecondViewController alloc] initWithNibName:@"SecondViewController"  bundle:nil ];
        
		navigationController = [[UINavigationController alloc] initWithRootViewController:sharedController];
	}
 
	[parentController presentModalViewController:navigationController animated:YES];
     sharedController.path =nil ;
    sharedController.image =  img ;
   // [self performSelector:@selector(displayImage:) withObject:sharedController afterDelay:0.2f];
    CGFloat  height = sharedController.image.size.height;
    CGFloat  width = sharedController.image.size.width;
    if (width>height) {
        
        sharedController.imageView.frame =CGRectMake(20,20, 280, 200); 
    }else
        sharedController.imageView.frame =CGRectMake(60,5, 200, 280); 
    [sharedController.imageView setImage: img ];
    
    sharedController.title=@"Upload Image";     
 
    sharedController.progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(55,290,210,10)];
    
    // [progressIndicator setFrame:CGRectMake(40,10,200,10)];
    [sharedController.view addSubview:sharedController.progressIndicator];
    sharedController.desc.text=@"";
    sharedController.name.text=@"";
    
     sharedController.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
     sharedController.imageView.layer.shadowOffset = CGSizeMake(1, 1);
     sharedController.imageView.layer.shadowOpacity = 0.5;
     sharedController.imageView.layer.shadowRadius = 2.0;
    
    
}

+ (void)showModal2:(UINavigationController*)parentController:(NSString *) url:(UIImage *) img
{ 
  
	static SecondViewController* sharedController;
	static UINavigationController *navigationController;
 	//if(!sharedController)
	//{
		sharedController = [[SecondViewController alloc] initWithNibName:@"SecondViewController"  bundle:nil ];
        
		navigationController = [[UINavigationController alloc] initWithRootViewController:sharedController];
	//}
  
	[parentController presentModalViewController:navigationController animated:YES];
   
    sharedController.path =nil ;
    sharedController.path =  url ;
    sharedController.image =  img ;
    CGFloat  height = sharedController.image.size.height;
    CGFloat  width = sharedController.image.size.width;
    if (width>height) {
        sharedController.imageView.frame =CGRectMake(20,20, 280, 200); 
    }else{   
        sharedController.imageView.frame =CGRectMake(60,5, 200, 280); 
    }   
    [sharedController.imageView setImage: img ];

    sharedController.title=@"Upload Video";
    
    sharedController.progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(55,290,210,10)];
    
    // [progressIndicator setFrame:CGRectMake(40,10,200,10)];
    [sharedController.view addSubview:sharedController.progressIndicator];
    sharedController.desc.text=@"";
    sharedController.name.text=@"";
    
    sharedController.imageView.layer.shadowColor = [UIColor whiteColor].CGColor;
    sharedController.imageView.layer.shadowOffset = CGSizeMake(1, 1);
    sharedController.imageView.layer.shadowOpacity = 0.5;
    sharedController.imageView.layer.shadowRadius = 5.0;
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}
 
- (void)cancel 
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction ) ok :(id)sender
{  
     
    if( [desc.text isEqualToString:@"" ])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please input description !" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil    , nil   ];
        [alert show];
        [alert release];
        return;
    }  
    
    
    /**
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    
	HUD.delegate = self;
    HUD.labelText = @"Uploading";
	
	// myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
    */
 
    
    NSDate *date1=[NSDate date];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyyMMddHHmmss"];
    NSString *valuestr = [formatter1 stringFromDate:date1];
   
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date_time = [formatter1 stringFromDate:date1];
    
    [formatter1 release];

    NSString *picname = desc.text;
    NSString *moviename = desc.text;
    
    NSString *picname1=[NSString stringWithFormat:@"_%@.jpg" ,valuestr];
    picname = [picname stringByAppendingString:picname1];
    
    NSString *moviename1 = [NSString stringWithFormat:@"_%@.mov" ,valuestr];      
    moviename = [moviename stringByAppendingString:moviename1];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: 
                                   [NSURL URLWithString:  [[NSUserDefaults standardUserDefaults] objectForKey:@"uploadurl" ] ] ];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"uploadurl" ]);
    
    
    [request addPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"stationid"]     
                   forKey: @"stationId"];  
     
    [request addPostValue:@"StreetTeam"          forKey: @"first_name"];  
    [request addPostValue:@"iphone"              forKey: @"last_name"]; 
    [request addPostValue:date_time              forKey: @"date_time"]; 
    [request addPostValue:desc.text              forKey: @"photoCaption"]; 
    
    if( self.path ==nil )
    {
        [request addPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"photocontentid" ]   forKey: @"contentId"]; 
        [request addPostValue:@"picture"                                                                forKey: @"send_type"]; 
        [request setData: UIImageJPEGRepresentation(self.image, 0.5f)  withFileName:picname andContentType:@"image/jpeg" forKey:@"uploadFile"];
    }
    else
    {
        [request addPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"videocontentid" ]  forKey: @"contentId"]; 
        [request addPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"videocontentid" ]   forKey: @"videoProgramId"];
        [request addPostValue:desc.text              forKey: @"episodeName"];
        [request addPostValue:@"video"               forKey: @"send_type"]; 
        [request addData: UIImageJPEGRepresentation(self.image, 0.5f)  withFileName:picname andContentType:@"image/jpeg" forKey:@"uploadFile"];
        //[request addData: self.path  withFileName: moviename  andContentType:@"video/quicktime"  forKey:@"videoFileName"]; 
        
        [request setFile:self.path  withFileName: moviename   andContentType:@"video/quicktime" forKey:@"videoFileName"]; 
    }
    
    [request setShouldRedirect:YES];
    [request setUploadProgressDelegate:progressIndicator];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(uploadRequestFinished:)];
    [request setDidFailSelector:@selector(uploadRequestFailed:)];
 
   // [request setShouldAttemptPersistentConnection:NO];
    [request setTimeOutSeconds:60]; 
    [request startAsynchronous];
    

}


- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
}



- (void)uploadRequestFinished:(ASIHTTPRequest *)request{    
    NSString *responseString = [request responseString];
    NSLog(@"upload response%@", responseString);
    [self showMessage:@"Upload success!"];
    [self cancel];
}


- (void)uploadRequestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@" Error -   file upload failed: \"%@\"",[[request error] localizedDescription]); 
    
    [self showMessage:@"Upload failed!"]; 
    [self cancel];
}


-(IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}
-(IBAction)cancelKeyboardClick 
{
	[desc resignFirstResponder];
	[name resignFirstResponder];
 
	
}
-(void)showMessage:(NSString *)msg  
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = msg;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    
    sleep(3);
}

@end

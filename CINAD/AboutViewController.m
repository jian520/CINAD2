//
//  WebsiteViewController.m
//  KKAJ
//
//  Created by josepth on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

#import "About.h"
#import "ModalAlert.h"
#import "AppDelegate.h"
#import "MyClass.h"
#import "Website.h"
@implementation AboutViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:[MyClass getTitle]
														 image:[UIImage imageNamed:@"tabicon-about.png"] 
														   tag:0] autorelease];
        
        
	}
	
	return self;
}


- (void)dealloc
{
    
    
    [super dealloc];
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
    self.view.alpha = 0.85;
    
    self.navigationController.navigationBarHidden = TRUE;
    CGRect appFrame  = [[UIScreen mainScreen] applicationFrame];
    CGFloat width =  appFrame.size.width  ;
     
 
    NSString *imgName=nil;
    
    CGRect imgFrame;
    CGRect  viewFrame;
    
    if (![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) { 
        
        imgFrame = CGRectMake(0, 0, width, 1004);
        imgName = @"Default-Portrait.png";     
        viewFrame = CGRectMake(0, 0, width  ,1004) ; 
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:imgFrame ];
        [imgView setImage:[UIImage imageNamed:imgName]] ;
        [self.view addSubview:imgView];

        
        CGRect frame = CGRectMake(10, 40, width, 20);
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, width, 50) ];
        lb.text = [MyClass getlabel1];
        lb.textColor = [UIColor whiteColor];
        [lb setTextAlignment:UITextAlignmentCenter];
        
        lb.font = [UIFont systemFontOfSize:32];;
        lb.backgroundColor = [UIColor clearColor];
        
        CGFloat bottom = lb.bounds.size.height + lb.bounds.origin.y;
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, width, 50)];
        lb1.text = [MyClass getlabel2];
        lb1.textColor = [UIColor whiteColor];
        [lb1 setTextAlignment:UITextAlignmentCenter];
      
        lb1.font = [UIFont systemFontOfSize:32];
        lb1.backgroundColor = [UIColor clearColor];
        
        
        
        UIButton *btnTel = [UIButton buttonWithType:UIButtonTypeCustom];
        bottom = lb1.bounds.size.height + lb1.bounds.origin.y;
        btnTel.frame = CGRectMake(0, 140, width, 50);
        [btnTel setTitle:[MyClass getlabel3] forState:UIControlStateNormal];
        // [btnTel setTitle:@"580-226-2277" forState:UIControlStateHighlighted];
        [btnTel.titleLabel   setFont: [UIFont  systemFontOfSize:32]]   ;
        [btnTel addTarget:self action:@selector(phoneStore:) forControlEvents:UIControlEventTouchUpInside];
        
     
        UIView *btnTelLine = [[UIView alloc] initWithFrame:CGRectMake(340,180, 192, 1) ] ;
        [btnTelLine setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        UIButton *btnTel2 = [UIButton buttonWithType:UIButtonTypeCustom];
       
        btnTel2.frame = CGRectMake(0, 190, width, 50);
        [btnTel2 setTitle:[MyClass getlabel4]  forState:UIControlStateNormal];
        // [btnTel2 setTitle:@"580-226-0421" forState:UIControlStateHighlighted];
        [btnTel2 addTarget:self action:@selector(phoneStore2:) forControlEvents:UIControlEventTouchUpInside];
        [btnTel2.titleLabel   setFont: [UIFont  systemFontOfSize:32]]   ;
         
       
        UIView *btnTel2Line = [[UIView alloc] initWithFrame:CGRectMake(322, 230, 196, 1) ] ;
        [btnTel2Line setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
        btn3.frame = CGRectMake(0, 230, width, 50);
        [btn3 setTitle:[MyClass getlabel5] forState:UIControlStateNormal];
        // [btnTel2 setTitle:@"580-226-0421" forState:UIControlStateHighlighted];
        [btn3 addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
        [btn3.titleLabel   setFont: [UIFont  systemFontOfSize:32]]   ;
         bottom = btn3.bounds.size.height + btn3.bounds.origin.y;
      //  UIView *btn3Line = [[UIView alloc] initWithFrame:CGRectMake(233, 270, 305, 1) ] ;
     //   [btn3Line setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, width, 50) ];
        lbTitle.font = [UIFont systemFontOfSize:30];
        lbTitle.textColor = [UIColor whiteColor];
        [lbTitle setText:@"Application by InterTech Media, LLC"];
        [lbTitle setTextAlignment:UITextAlignmentCenter];
        lbTitle.backgroundColor = [UIColor clearColor];
        bottom = lbTitle.bounds.size.height + 400;
        
      

        UILabel *lbAbout = [[UILabel alloc] initWithFrame:CGRectMake(0, bottom, width, 400) ];
        [lbAbout setText:@"InterTech provides creative Internet solutions for media companies, including a proprietary web content management system, website development, blogging, live and pre-recorded video and audio streaming, geo-targeted ad insertion, database marketing, texting, coupon marketing, Podcasting, social network integration, and a comprehensive suite of mobile applications. Our web-based tools offer our clients solutions to engage more effectively with their audiences and grow their online and traditional revenue."];
        lbAbout.textColor = [UIColor whiteColor];
        [lbAbout setTextAlignment:UITextAlignmentCenter];
        lbAbout.numberOfLines = 100;
        lbAbout.font = [UIFont systemFontOfSize:30];
        lbAbout.backgroundColor = [UIColor clearColor];
        
        UIButton *btnITM = [UIButton buttonWithType:UIButtonTypeCustom];
        bottom = lbAbout.bounds.size.height + lbAbout.bounds.origin.y;
        btnITM.frame = CGRectMake(0, 860, width, 50);
        
        
        [btnITM setTitle:@"http://www.intertechmedia.com" forState:UIControlStateNormal];
        [btnITM.titleLabel   setFont: [UIFont  fontWithName:@"Helvetica-BoldOblique"  size:30]]   ;
 
        
        
        [btnITM addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
        bottom = btnITM.bounds.size.height + btnITM.bounds.origin.y;

        UIView *btnITMLine = [[UIView alloc] initWithFrame:CGRectMake(162, 900, 445, 1) ] ;
        [btnITMLine setBackgroundColor:[UIColor whiteColor]] ; 
       
    
        frame = [[UIScreen mainScreen] applicationFrame];
        UIView *theView = [[UIView alloc] initWithFrame:viewFrame];
        
        theView.backgroundColor = [UIColor blackColor];
        theView.alpha = 0.85;
        [theView addSubview:lb ];
        [theView addSubview:lb1 ];
        
        
        
        
       // [theView addSubview:btnTel]; 
      //  [theView addSubview:btnTelLine]; 
        
     //   [theView addSubview:btnTel2];
      //  [theView addSubview:btnTel2Line];
        
        [theView addSubview:btn3];
   //     [theView addSubview:btn3Line];
        
        
        [theView addSubview:lbTitle];
        [theView addSubview:lbAbout];
        [theView addSubview:btnITM];
        [theView addSubview:btnITMLine];
        
        [self.view addSubview:theView] ;
        
        
        
    }else      
    {
        
        viewFrame = CGRectMake(0, 0, 320, 480) ; 
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:viewFrame ];
       
        [imgView setImage:[UIImage imageNamed: @"Default.png"]] ;
        [self.view addSubview:imgView];         
        
        
        CGRect frame = CGRectMake(10, 40, 300, 20);
        UILabel *lb = [[UILabel alloc] initWithFrame:frame];
        lb.text =  [MyClass getlabel1];
        lb.textColor = [UIColor whiteColor];
        [lb setTextAlignment:UITextAlignmentCenter];
        lb.numberOfLines = 20;
        lb.font = [UIFont systemFontOfSize:18];;
        lb.backgroundColor = [UIColor clearColor];
        
        frame = CGRectMake(10, 60, 300, 20);
        UILabel *lb1 = [[UILabel alloc] initWithFrame:frame];
        lb1.text =  [MyClass getlabel2];
        lb1.textColor = [UIColor whiteColor];
        [lb1 setTextAlignment:UITextAlignmentCenter];
        lb1.numberOfLines = 20;
        lb1.font = [UIFont systemFontOfSize:18];
        lb1.backgroundColor = [UIColor clearColor];
        
        
        
        UIButton *btnTel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTel.frame = CGRectMake(10, 80, 300, 20);
        [btnTel setTitle: [MyClass getlabel3] forState:UIControlStateNormal];
        // [btnTel setTitle:@"580-226-2277" forState:UIControlStateHighlighted];
        [btnTel.titleLabel   setFont: [UIFont  systemFontOfSize:18]]   ;
        
        
        [btnTel addTarget:self action:@selector(phoneStore:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *btnTelLine = [[UIView alloc] initWithFrame:CGRectMake(133, 97, 112, 1) ] ;
        [btnTelLine setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        UIButton *btnTel2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTel2.frame = CGRectMake(10, 100, 300, 20);
        [btnTel2 setTitle:  [MyClass getlabel4] forState:UIControlStateNormal];
        // [btnTel2 setTitle:@"580-226-0421" forState:UIControlStateHighlighted];
        [btnTel2 addTarget:self action:@selector(phoneStore2:) forControlEvents:UIControlEventTouchUpInside];
        [btnTel2.titleLabel   setFont: [UIFont  systemFontOfSize:18]]   ;
        
        UIView *btnTel2Line = [[UIView alloc] initWithFrame:CGRectMake(125, 117, 112, 1) ] ;
        [btnTel2Line setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(10, 120, 300, 20);
        [btn3 setTitle: [MyClass getlabel5] forState:UIControlStateNormal];
        // [btnTel2 setTitle:@"580-226-0421" forState:UIControlStateHighlighted];
        [btn3 addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
        [btn3.titleLabel   setFont: [UIFont  systemFontOfSize:18]]   ;
        btn3.showsTouchWhenHighlighted = YES;
      //  UIView *btn3Line = [[UIView alloc] initWithFrame:CGRectMake(70, 137, 178, 1) ] ;
     //   [btn3Line setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        
        
        
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 300, 20) ];
        lbTitle.font = [UIFont systemFontOfSize:15];
        lbTitle.textColor = [UIColor whiteColor];
        [lbTitle setText:@"Application by InterTech Media, LLC"];
        [lbTitle setTextAlignment:UITextAlignmentCenter];
        lbTitle.backgroundColor = [UIColor clearColor];
        
        UILabel *lbAbout = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 200) ];
        [lbAbout setText:@"InterTech provides creative Internet solutions for media companies, including a proprietary web content management system, website development, blogging, live and pre-recorded video and audio streaming, geo-targeted ad insertion, database marketing, texting, coupon marketing, Podcasting, social network integration, and a comprehensive suite of mobile applications. Our web-based tools offer our clients solutions to engage more effectively with their audiences and grow their online and traditional revenue."];
        lbAbout.textColor = [UIColor whiteColor];
        [lbAbout setTextAlignment:UITextAlignmentCenter];
        lbAbout.numberOfLines = 20;
        lbAbout.font = [UIFont systemFontOfSize:13];
        lbAbout.backgroundColor = [UIColor clearColor];
        
        UIButton *btnITM = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btnITM.frame = CGRectMake(20, 370, 280, 35);
        
        
        [btnITM setTitle:@"http://www.intertechmedia.com" forState:UIControlStateNormal];
        [btnITM.titleLabel   setFont: [UIFont  fontWithName:@"Helvetica-BoldOblique"  size:16]]   ;
         btnITM.showsTouchWhenHighlighted = YES;
        
        [btnITM addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *btnITMLine = [[UIView alloc] initWithFrame:CGRectMake(40, 395, 240, 1) ] ;
        [btnITMLine setBackgroundColor:[UIColor whiteColor]] ; 
        
        
        
        frame = [[UIScreen mainScreen] applicationFrame];
        UIView *theView = [[UIView alloc] initWithFrame:viewFrame];
        
        theView.backgroundColor = [UIColor blackColor];
        theView.alpha = 0.85;
        [theView addSubview:lb ];
        [theView addSubview:lb1 ];
        
      //  [theView addSubview:btnTel]; 
      //  [theView addSubview:btnTelLine]; 
        
      //  [theView addSubview:btnTel2];
      //  [theView addSubview:btnTel2Line];
        
        [theView addSubview:btn3];
    //    [theView addSubview:btn3Line];
        
        
        [theView addSubview:lbTitle];
        [theView addSubview:lbAbout];
        [theView addSubview:btnITM];
        [theView addSubview:btnITMLine];
        
        [self.view addSubview:theView] ;
    }  
  

  
    
 
    
}
-(IBAction )openAction:(id)sender
{
    [About showModal:self.navigationController ] ;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)phoneStore:(id)sender { 
    
    NSUInteger answer = [ModalAlert confirm: [MyClass getlabel3]];
    if (answer ==1) {
        
        NSString *num = [[NSString alloc] initWithFormat:@"tel://%@", [MyClass getlabel3] ];      
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: num]]; //拨号 
    }
}
-(IBAction)phoneStore2:(id)sender { 
    NSUInteger answer = [ModalAlert confirm: [MyClass getTel]];
    if (answer ==1) {
        
        NSString *num = [[NSString alloc] initWithFormat:@"tel://%@", [MyClass getTel] ];      
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: num]]; //拨号 
    }
}
-(IBAction )openURL:(id)sender 
{
    [Website showModal:self.navigationController ] ;    
}

@end

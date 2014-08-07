//
//  FBView.h
//  WLTJ
//
//  Created by joseph on 13-7-17.
//
//

#import <Three20UI/Three20UI.h>

@interface FBView :  UIViewController    <UIWebViewDelegate>
{
    UIWebView *webView;
    UISegmentedControl *segmentedControl;
}

@property (nonatomic, strong)   UIWebView *webView;


@end

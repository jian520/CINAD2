

#import <UIKit/UIKit.h>

@interface About :  UIViewController    <UIWebViewDelegate>
{
    UIWebView *webView;
}
@property (nonatomic, strong) NSString  *url;
@property (nonatomic, strong)   UIWebView *webView;

 
@end

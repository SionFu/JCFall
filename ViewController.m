//
//  ViewController.m
//  JCFall+
//
//  Created by Fu Sion on 2019/4/24.
//  Copyright © 2019 rarhe. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()<UIWebViewDelegate>{
    NSString *url_str;
    UIProgressView *progress;
}

@property (weak, nonatomic) IBOutlet UIWebView *webview;
//@property (strong,nonatomic)UIWebView *webview;

@end

@implementation ViewController
- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}
-(UIRectEdge)preferredScreenEdgesDeferringSystemGestures {
    return UIRectEdgeAll;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self setlayout];
    url_str = @"https://www.starfall.com/h/";
    [self gotoUrl:url_str];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)gotoUrl:(NSString *)str{
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [webView setScalesPageToFit:YES];
    progress.hidden=NO;
    [progress setProgress:0.9 animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)web{
//    [self.webview setScalesPageToFit:YES];
    [progress setProgress:1 animated:YES];
    progress.hidden=YES;
    [progress setProgress:0 animated:NO];
}
-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    NSLog(@"DidFailLoadWithError");
}
- (void)setlayout {
    [self.view addSubview:self.webview];
//    self.webview.frame=CGRectMake(0, 0, HCSystemWidth, HCSystemHeight - 50 - 64);
    self.webview.delegate=self;
    self.webview.scalesPageToFit=YES;
    self.webview.scrollView.bounces = NO;
//    self.btnview.frame = CGRectMake(0, HCSystemHeight-50-64, HCSystemWidth, 50);
//    [self.btnview.weixinbtn addTarget:self action:@selector(WeChatBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnview.pengyouquanbtn addTarget:self action:@selector(FriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnview.copybtn addTarget:self action:@selector(CopyBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btnview];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    progress=[[UIProgressView alloc]init];
    [self.webview insertSubview:progress atIndex:10];
    progress.frame=CGRectMake(0, 0, HCSystemWidth, 5);
    progress.progressViewStyle= UIProgressViewStyleDefault;
    
    UILongPressGestureRecognizer * longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    longPressed.minimumPressDuration = 0.5;
    [self.webview addGestureRecognizer:longPressed];
}
- (void)longPressed:(UITapGestureRecognizer*)recognizer{
   [self gotoUrl:url_str];
}
@end

//
//  QCWebViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/19.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCWebViewController.h"

@interface QCWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QCWebViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title{
    if (self = [super init]) {
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
        self.title = title;
    }
    return self;
}

+ (QCWebViewController *)webViewWithUrl:(NSString *)url{
    return [self webViewWithUrl:url title:nil];
}

+ (QCWebViewController *)webViewWithUrl:(NSString *)url title:(NSString *)title{
    return [[self alloc] initWithUrl:url title:title];
}

#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (theTitle.length > 10) {
        theTitle = [[theTitle substringToIndex:9] stringByAppendingString:@"…"];
    }
    self.title = theTitle;
}

@end

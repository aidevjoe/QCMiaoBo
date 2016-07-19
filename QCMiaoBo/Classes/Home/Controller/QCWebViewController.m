//
//  QCWebViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/19.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCWebViewController.h"

@interface QCWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QCWebViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
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

+ (QCWebViewController *)webViewWithUrl:(NSString *)url title:(NSString *)title{
    return [[self alloc] initWithUrl:url title:title];
}


@end

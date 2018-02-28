//
//  YZWebViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/27.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZWebViewController.h"

@interface YZWebViewController ()

@end

@implementation YZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    webView.frame = self.view.bounds;
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

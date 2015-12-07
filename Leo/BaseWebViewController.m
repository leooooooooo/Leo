
//
//  BaseWebViewController.m
//  Leo
//
//  Created by zhangchao on 15/8/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "BaseWebViewController.h"
#import "Basic.h"

@interface BaseWebViewController ()
@property BOOL first;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    web.delegate = self;
    web.scalesPageToFit =YES;
    NSURL *url = [[NSURL alloc] initWithString:_URLString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
    self.first = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([webView canGoBack]) {
        //[self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goback)]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

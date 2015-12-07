//
//  Web.m
//  Leo
//
//  Created by zhangchao on 15/8/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "Web.h"
#import "BaseWebViewController.h"
#import "Basic.h"

@implementation Web
+(UIViewController *)BaseWeb:(NSString *)URLString
{
    BaseWebViewController *web = [[BaseWebViewController alloc]init];
    web.URLString = URLString;
    return web;
}

+(UIView *)BaseWebView:(NSString *)URLString
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    web.scalesPageToFit =YES;
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [web loadRequest:request];
    return web;
}
@end

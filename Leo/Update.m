//
//  Update.m
//  Leo
//
//  Created by zhangchao on 15/8/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//


#import "Update.h"
#import "Basic.h"
#import "Post/Post.h"

@implementation Update

-(UIView *)GetUpdateInfo:(NSString *)AppName showVersionMarkAnchorPoint:(CGPoint)point NowVersionColor:(UIColor *)NowVersionColor NewVersionColor:(UIColor *)NewVersionColor
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, 200, 40)];
    
    //当前版本
    UILabel *Version = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 200, 20)];
    Version.text = [NSString stringWithFormat:@"当前版本：%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    Version.font = [UIFont boldSystemFontOfSize:14];
    Version.textColor = NowVersionColor;
    [view addSubview:Version];
    
    //网络请求
    NSString *urlString = [NSString stringWithFormat:BasicServer,@"Update.aspx"];
    NSString *bodyStr = [NSString stringWithFormat:@"AppName=%@&DeviceType=iOS&Build=%@",AppName,[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    NSDictionary *Update = [Post getSynchronousRequestDataJSONSerializationWithURL:urlString withHTTPBody:bodyStr];
    
    self.isUpdate =[[Update objectForKey:@"Update"]isEqualToString:@"Yes"];
    
    if(self.isUpdate)
    {
        self.Url = [Update objectForKey:@"Url"];
        self.Version =[Update objectForKey:@"Version"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到新版本%@，请点击更新安装新版本",[Update objectForKey:@"Version"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        
        //版本更新button
        UIButton *newVersion = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        [newVersion setTitle:[NSString stringWithFormat:@"最新版本：%@",[Update objectForKey:@"Version"]] forState:UIControlStateNormal];
        newVersion.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [newVersion setTitleColor:NewVersionColor forState:UIControlStateNormal];
        newVersion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [newVersion addTarget:self action:@selector(CheckUpdate) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:newVersion];
        [alert show];
    }

    
    return view;
}

- (void)CheckUpdate{

    UIAlertView *alert;
    if (self.isUpdate) {
        
        alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到新版本%@，请点击更新安装新版本",self.Version] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
    }
    else
    {
        alert = [[UIAlertView alloc]initWithTitle:@"更新" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    }
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

        switch (buttonIndex)
        {
            case 1:[self Update];break;
            default:break;
        }
    
}

- (void)Update
{
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    UIView *view =[[UIView alloc]init];
    for (UIWindow *window in frontToBackWindows)
        if (window.windowLevel == UIWindowLevelNormal) {
            view = window.viewForBaselineLayout;
            break;
        }


    UIWebView *up = [[UIWebView alloc]init];
    NSURL *url =[NSURL URLWithString:self.Url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [up loadRequest:request];
    [view addSubview:up];
    NSLog(@"开始更新",nil);
}
@end

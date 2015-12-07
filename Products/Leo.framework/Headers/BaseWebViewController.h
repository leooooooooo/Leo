//
//  BaseWebViewController.h
//  Leo
//
//  Created by zhangchao on 15/8/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,retain)NSString *URLString;
@end

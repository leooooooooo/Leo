//
//  Web.h
//  Leo
//
//  Created by zhangchao on 15/8/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Web : NSObject
+(UIViewController *)BaseWeb:(NSString *)URLString;
+(UIView *)BaseWebView:(NSString *)URLString;
@end

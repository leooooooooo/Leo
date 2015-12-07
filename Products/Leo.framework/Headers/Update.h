//
//  Update.h
//  Leo
//
//  Created by zhangchao on 15/8/20.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Update : NSObject
@property(nonatomic,retain)NSString *Url;
@property(nonatomic,retain)NSString *Version;
@property BOOL isUpdate;
-(UIView *)GetUpdateInfo:(NSString *)AppName showVersionMarkAnchorPoint:(CGPoint)point NowVersionColor:(UIColor *)NowVersionColor NewVersionColor:(UIColor *)NewVersionColor;
@end

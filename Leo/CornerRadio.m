//
//  CornerRadio.m
//  Leo
//
//  Created by zhangchao on 15/8/24.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CornerRadio.h"

@implementation CornerRadio

+(UIView *)cornerRadio:(NSString *)number initWithPoint:(CGPoint)Point
{
    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(Point.x, Point.y, 15+number.length*5, 20)];
    badge.text = number;
    badge.textColor            = [UIColor whiteColor];
    badge.backgroundColor      = [UIColor redColor];
    badge.font                 = [UIFont systemFontOfSize:12.0];
    badge.textAlignment        = NSTextAlignmentCenter;
    badge.layer.cornerRadius = 10;
    badge.layer.masksToBounds = YES;
    if ([number intValue]==0) {
        return nil;
    }
    return badge;
}
@end

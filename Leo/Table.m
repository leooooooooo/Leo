//
//  Table.m
//  Leo
//
//  Created by zhangchao on 15/8/26.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "Table.h"
#import "DetailTableViewController.h"

@implementation Table
+(UIViewController *)DetailTable:(NSDictionary *)Detail
{
    DetailTableViewController *dt = [[DetailTableViewController alloc]init];
    dt.Deatil=Detail;
    return dt;
}
@end

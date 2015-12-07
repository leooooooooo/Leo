//
//  Navigation.m
//  Leo
//
//  Created by zhangchao on 15/8/21.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "Navigation.h"

@implementation Navigation
+(void)NavigationConifigInitialize:(UIViewController *)sender setNavigationBackArrowColor:(UIColor *)NavigationBackArrowColor setNavigationBarColor:(UIColor *)NavigationBarColor setNavigationTitleColor:(UIColor *)NavigationTitleColor
{
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [sender.navigationItem setBackBarButtonItem:backButton];
    [sender.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [sender.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    sender.navigationController.navigationBar.titleTextAttributes=dict;
}
@end

//
//  HYYWTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) NSDictionary *Deatil;

@end


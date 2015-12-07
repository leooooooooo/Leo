//
//  HYYWTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/13.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Basic.h"

@interface DetailTableViewController ()
@property (nonatomic,retain)NSArray *DataArray;
@property (nonatomic,retain)NSArray *Order;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self GetData];
}

-(BOOL)CheakOrder
{


    if (isValid([_Deatil objectForKey:@"Order"])) {
        _Order = [[_Deatil objectForKey:@"Order"] componentsSeparatedByString:@"+"];
        return YES;
    }
    else
    {
        _Order = nil;
        return NO;
    }
}

-(void)GetData
{
    if ([self CheakOrder]) {
        NSArray *value = [_Deatil objectsForKeys:_Order notFoundMarker:[NSNull alloc]];
        _DataArray =[[NSArray alloc]initWithObjects:_Order,value, nil];
    }
    else
    {
        NSArray *name = [[NSArray alloc]initWithArray:[self.Deatil allKeys]];
        NSArray *value =[[NSArray alloc]initWithArray:[self.Deatil allValues]];
        _DataArray = [[NSArray alloc]initWithObjects:name,value, nil];
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[_DataArray objectAtIndex:0 ]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil)
    {
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //Date
        CGRect DateRect = CGRectMake(20,11,120,22);
        CGPoint i = DateRect.origin;
        //CGSize j = DateRect.size;
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel.font = [UIFont systemFontOfSize:16];
        DateLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        DateLabel.textAlignment= NSTextAlignmentLeft;
        
        [cell.contentView addSubview:DateLabel];
        
        //Fund
        CGRect FundRect = CGRectMake(WIDTH-220, i.y, 200, 22);
        UILabel *FundLabel = [[UILabel alloc]initWithFrame:FundRect];
        //i = FundRect.origin;
        //j = FundRect.size;
        FundLabel.font = [UIFont systemFontOfSize:16];
        FundLabel.tag = 2;
        FundLabel.textAlignment= NSTextAlignmentRight;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:FundLabel];
        
    }
    
    

    //Date
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [[_DataArray objectAtIndex:0] objectAtIndex:indexPath.row];
    //Fund
    
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[_DataArray objectAtIndex:1] objectAtIndex:indexPath.row]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,str.length)];
    ((UILabel *)[cell.contentView viewWithTag:2]).attributedText = str;
    //BOOL *st =;
    
    if ([str.string rangeOfString:@"已完成"].location!=NSNotFound) {
        cell.backgroundColor = UULightGreen;
    }
    else if ([str.string isEqualToString:@"待办"]) {
        cell.backgroundColor = UULightYellow;
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
    }
    //cell.backgroundColor = [UIColor blackColor];

    
    cell.userInteractionEnabled = NO;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

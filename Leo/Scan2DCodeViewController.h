//
//  ViewController.h
//  QRCodeReader
//
//  Created by 吴珂 on 15/1/23.
//  Copyright (c) 2015年 吴珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Scan2DCodeDelegate <NSObject>
@required
- (void)Paser2DCode:(NSString *)Paser;
@end

@interface Scan2DCodeViewController : UIViewController
@property(nonatomic,retain)id<Scan2DCodeDelegate>Scan2DCodeDelegate;
@property (retain, nonatomic) NSString *tip;
@end


//
//  Post.h
//  LYGPublic
//
//  Created by zhangchao on 15/8/19.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PostDelegate <NSObject>
@required
@optional
-(void)RequestData:(id)Info;
@end

@interface Post : NSObject

+(id)getSynchronousRequestDataJSONSerializationWithURL:(NSString *)URLString withHTTPBody:(NSString *)bodyStr;
+(void)getAsynchronousRequestDataJSONSerializationWithURL:(NSString *)URLString withHTTPBody:(NSString *)bodyStr Delegate:(id)delegate;
@end

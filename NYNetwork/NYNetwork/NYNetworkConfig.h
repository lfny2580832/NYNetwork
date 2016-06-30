//
//  NYNetworkConfig.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYNetworkConfig : NSObject

/**
 *  获取单例
 *
 *  @return
 */
+ (NYNetworkConfig *)sharedInstance;

//基本地址
@property (nonatomic, copy) NSString *baseUrl;
//用户登录返回的token
@property (nonatomic, copy) NSString *token;
//app版本号
@property (nonatomic, copy) NSString *version;
//请求头添加的内容，根据token和version生成，无法直接设置
@property (nonatomic, strong, readonly) NSDictionary *additionalHeaderFields;

//请求超时时间
@property (nonatomic, assign) NSTimeInterval defaultTimeOutInterval;

@property (nonatomic, strong) NSIndexSet *defaultAcceptableStatusCodes;

@property (nonatomic, strong) NSSet *defaultAcceptableContentTypes;

@end

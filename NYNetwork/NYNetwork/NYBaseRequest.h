//
//  NYBaseRequest.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class NYBaseRequest;
@class NYHTTPConnection;

//--------------------------定义方法序列化枚举，成功失败回调--------------------------
typedef NS_ENUM(NSInteger, NYRequestMethod){
    NYRequestMethodGet = 0,
    NYRequestMethodPost,
    NYRequestMethodPut,
    NYRequestMethodDelete,
};

typedef NS_ENUM(NSInteger, NYRequestSerializerType){
    NYRequestSerializerTypeHTTP = 0,
    NYRequestSerializerTypeJson,
};

typedef NS_ENUM(NSInteger, NYResponseSerializerType){
    NYResponseSerializerTypeHTTP = 0,
    NYResponseSerializerTypeJson,
};

typedef void (^SuccessBlock)(NYBaseRequest *request, id responseObject);
typedef void (^FailureBlock)(NYBaseRequest *request, NSError *error);

//-----------------------------请求完成代理方法----------------------------
@protocol NYRequestDelegate <NSObject>

@optional

- (void)requesetFinished:(NYBaseRequest *)request;
- (void)requestFailed:(NYBaseRequest *)request;

@end

@interface NYBaseRequest : NSObject
//-------------------------------request-------------------------------------
@property (nonatomic, weak) NYHTTPConnection *connection;
//请求方法 Get/Post
@property (nonatomic, assign) NYRequestMethod requestMethod;
//baseUrl之后的请求Url
@property (nonatomic, copy) NSString *requestUrl;
//baseUrl，如http://api.hoomxb.com
@property (nonatomic, copy) NSString *baseUrl;
//最终请求时传的Url，根据baseUrl的有无来生成
@property (nonatomic, copy, readonly) NSURL *url;
//请求参数字典
@property (nonatomic, strong) id requestArgument;
//向请求头中添加的附加信息，除token、version等公共信息
@property (nonatomic, copy) NSDictionary *requestHeaderFieldValueDictionary;
//请求序列化类型
@property (nonatomic, assign) NYRequestSerializerType requestSerializerType;
//请求超时时间
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

//-------------------------------response------------------------------------
//响应序列化类型
@property (nonatomic, assign) NYResponseSerializerType responseSerializerType;
//响应状态码，如403
@property (nonatomic, assign, readonly) NSInteger responseStatusCode;
//响应头
@property (nonatomic, copy, readonly) NSDictionary *responseHeaderFieldValueDictionary;
//回调成功内容
@property (nonatomic, strong) id responseObject;
//回调失败错误
@property (nonatomic, strong) NSError *error;

//--------------------------------callback----------------------------------
//返回成功回调
@property (nonatomic, copy) SuccessBlock success;
//返回失败回调
@property (nonatomic, copy) FailureBlock failure;
//代理
@property (nonatomic, weak) id<NYRequestDelegate> delegate;

//---------------------------------function---------------------------------

- (void)start;

- (void)startWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

- (void)startWithHUDStr:(NSString *)string Success:(SuccessBlock)success failure:(FailureBlock)failure;

@end

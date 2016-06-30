//
//  NYHTTPConnection.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYHTTPConnection.h"
#import "NYNetworkConfig.h"

#import <objc/runtime.h>

#define Config [NYNetworkConfig sharedInstance]

@implementation NYBaseRequest (NYHTTPConnection)

static const char kBaseRequestConnectionKey;

- (NYHTTPConnection *)connection
{
    return objc_getAssociatedObject(self, &kBaseRequestConnectionKey);
}

- (void)setConnection:(NYHTTPConnection *)connection
{
    objc_setAssociatedObject(self, &kBaseRequestConnectionKey, connection, OBJC_ASSOCIATION_ASSIGN);
}

@end

@interface NYHTTPConnection ()

@property (nonatomic, strong, readwrite) NYBaseRequest *request;

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *task;

@property (nonatomic, copy) ConnectionSuccessBlock success;

@property (nonatomic, copy) ConnectionFailureBlock failture;

@end

@implementation NYHTTPConnection

+ (instancetype)connection
{
    return [[self alloc]init];
}

/**
 *  生成headerFieldValueDic
 *
 *  @param request 处理的请求
 *
 */
- (NSDictionary *)headerFieldsValueWithRequest:(NYBaseRequest *)request
{
    NSMutableDictionary *headers = [Config.additionalHeaderFields mutableCopy];

    [request.requestHeaderFieldValueDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [headers setObject:obj forKey:key];
    }];
    return headers;
}

- (void)connectWithRequest:(NYBaseRequest *)request success:(ConnectionSuccessBlock)success failure:(ConnectionFailureBlock)failure
{
    self.request = request;
    self.success = success;
    self.failture = failure;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
//-------------------------------------------request----------------------------------------
    if (request.requestSerializerType == NYRequestSerializerTypeHTTP) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if (request.requestSerializerType == NYRequestSerializerTypeJson){
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    manager.requestSerializer.timeoutInterval = request.timeoutInterval ?: Config.defaultTimeOutInterval ?: 30;
    
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
//--------------------------------------------response----------------------------------------
    if (request.responseSerializerType == NYResponseSerializerTypeHTTP) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else if (request.responseSerializerType == NYResponseSerializerTypeJson){
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    manager.responseSerializer.acceptableStatusCodes = Config.defaultAcceptableStatusCodes;
    manager.responseSerializer.acceptableContentTypes = Config.defaultAcceptableContentTypes;
    
    NSString *urlString = @"";
    if (request.baseUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseUrl]].absoluteString;
    }else{
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:Config.baseUrl]].absoluteString;
    }
    NSDictionary *parameters = request.requestArgument;
    
    NSURLSessionDataTask *task = nil;
    switch (request.requestMethod) {
        case NYRequestMethodGet:
        {
            task = [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestHandleSuccess:request responseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestHandleFailure:request error:error];
            }];
        }
            break;
        case NYRequestMethodPost:
        {
            task = [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestHandleSuccess:request responseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestHandleFailure:request error:error];
            }];
        }
        default:{
            NSLog(@"unsupported request method");
        }
            break;
    }
    self.task = task;
    request.connection = self;
}

- (void)requestHandleSuccess:(NYBaseRequest *)request responseObject:(id)object
{
    if (self.success) {
        self.success(self,object);
    }
}

- (void)requestHandleFailure:(NYBaseRequest *)request error:(NSError *)error
{
    if (self.failture) {
        self.failture(self,error);
    }
}

@end

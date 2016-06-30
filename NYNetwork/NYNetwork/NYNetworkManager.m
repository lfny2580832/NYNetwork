//
//  NYNetworkManager.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager.h"
#import "NYHTTPConnection.h"

#import <objc/runtime.h>

@implementation NYBaseRequest (NYNetworkManager)

static const char kBaseRequestResponseModelKey;
- (id)responseObject{
    return objc_getAssociatedObject(self, &kBaseRequestResponseModelKey);
}
- (void)setResponseObject:(id)responseObject{
    objc_setAssociatedObject(self, &kBaseRequestResponseModelKey, responseObject, OBJC_ASSOCIATION_RETAIN);
}

static const char kBaseRequestErrorKey;
- (NSError *)error{
    return objc_getAssociatedObject(self, &kBaseRequestErrorKey);
}
- (void)setError:(NSError *)error{
    objc_setAssociatedObject(self, &kBaseRequestErrorKey, error, OBJC_ASSOCIATION_RETAIN);
}

@end


@implementation NYNetworkManager

+ (instancetype)sharedManager
{
    static NYNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)addRequest:(NYBaseRequest *)request
{
    __weak typeof(self) weakSelf = self;
    [[NYHTTPConnection connection] connectWithRequest:request success:^(NYHTTPConnection *connection, id responseJsonObject) {
        [weakSelf processConnection:connection withResponseJsonObject:responseJsonObject];
    } failure:^(NYHTTPConnection *connection, NSError *error) {
        [weakSelf processConnection:connection withError:error];
    }];
}

- (void)processConnection:(NYHTTPConnection *)connection withResponseJsonObject:(id)responseJsonObject
{
    NYBaseRequest *request = connection.request;
    request.responseObject = responseJsonObject;
    [self callBackRequestSuccess:request];
}

- (void)processConnection:(NYHTTPConnection *)connection withError:(NSError *)error
{
    NYBaseRequest *request = connection.request;
    request.error = error;
    [self callBackRequestFailure:request];
}

//--------------------------------------------回调--------------------------------------------
/**
 *  成功回调
 *
 *  @param request
 */
- (void)callBackRequestSuccess:(NYBaseRequest *)request
{
    if (request.success) {
        [self defaultMethodRequestSuccessWithRequest:request];
        request.success(request,request.responseObject);
    }
    if ([request.delegate respondsToSelector:@selector(requesetFinished:)]) {
        [request.delegate requesetFinished:request];
    }
    [self clearRequestBlock:request];
}

/**
 *  失败回调
 *
 *  @param request
 */
- (void)callBackRequestFailure:(NYBaseRequest *)request
{    
    if (request.failure) {
        [self defaultMethodRequestFaulureWithRequest:request];
        request.failure(request,request.error);
    }
    if ([request.delegate respondsToSelector:@selector(requestFailed:)]) {
        [request.delegate requestFailed:request];
    }
    [self clearRequestBlock:request];
}

- (void)clearRequestBlock:(NYBaseRequest *)request
{
    request.success = nil;
    request.failure = nil;
}

//---------------------------------在回调中默认执行方法，在扩展中重写--------------------------
- (void)defaultMethodRequestSuccessWithRequest:(NYBaseRequest *)request
{
}

- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request
{
}

@end

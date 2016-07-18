//
//  NYBaseRequest.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYBaseRequest.h"
#import "NYHTTPConnection.h"
#import "NYNetworkManager.h"

@implementation NYBaseRequest

//----------------------------------request---------------------------------
- (NYRequestMethod)requestMethods
{
    return NYRequestMethodGet;
}

- (NSString *)requestUrl{
    return @"";
}

- (NSString *)baseUrl{
    return @"";
}

- (NSDictionary *)requestArgument{
    return @{};
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    return @{};
}

- (NYRequestSerializerType)requestSerializerType{
    return NYRequestSerializerTypeJson;
}

- (NSTimeInterval)timeoutInterval{
    return 30;
}

//----------------------------------response------------------------------------
- (NYResponseSerializerType)responseSerializerType{
    return NYResponseSerializerTypeJson;
}

- (NSInteger)responseStatusCode{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.connection.task.response;
    return response.statusCode;
}

- (NSDictionary *)responseHeaderFieldValueDictionary{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)self.connection.task.response;
    return response.allHeaderFields;
}

//-----------------------------------funtion--------------------------------------
- (void)start{
    [self startWithHUD:nil];
}

- (void)startWithHUD:(NSString *)str
{
    [[NYNetworkManager sharedManager] addRequest:self withHUD:str];
}

- (void)startWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure{
    self.success = [success copy];
    self.failure = [failure copy];
    [self start];
}

- (void)startWithHUDStr:(NSString *)string Success:(SuccessBlock)success failure:(FailureBlock)failure{
    self.success = [success copy];
    self.failure = [failure copy];
    [self startWithHUD:string];
}

@end

//
//  BannerAPI.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "BannerAPI.h"
#import "AFNetworking.h"

@implementation BannerAPI

- (instancetype)init
{
    self = [super init];
    return self;
}

- (NSString *)requestUrl
{
    return @"/banners";
}

- (NYRequestMethod)requestMethod
{
    return NYRequestMethodGet;
}

- (void)startRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *url = @"/banners";
    NSDictionary *dict = [NSDictionary new];
    
    
    [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end

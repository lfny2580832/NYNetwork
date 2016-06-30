//
//  BannerAPI.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "BannerAPI.h"

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

@end

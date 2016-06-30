//
//  LoginAPI.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "LoginAPI.h"

@implementation LoginAPI
{
    NSString *_phone;
    NSString *_loginPwd;
    NSString *_gesture;
    NSNumber *_authMethod;
}

- (id)initWithPhone:(NSString *)phone loginPwd:(NSString *)loginPwd gesture:(NSString *)gesture authMethod:(AuthMethodType)authMethod
{
    self = [super init];
    if (self) {
        _phone = phone;
        _loginPwd = (loginPwd.length)?loginPwd:@"";
        _gesture = (gesture.length)?gesture:@"";
        _authMethod = @(authMethod);
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/login";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"phone": _phone,
             @"loginPwd": _loginPwd,
             @"gesture": _gesture,
             @"authMethod":_authMethod
             };
}

@end

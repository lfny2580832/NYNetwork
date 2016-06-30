//
//  LoginAPI.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/16.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NYNetwork.h"

typedef NS_ENUM(NSInteger, AuthMethodType)
{
    LoginPwd = 0,
    Gesture = 1,
};

@interface LoginAPI : NYBaseRequest

- (id)initWithPhone:(NSString *)phone loginPwd:(NSString *)loginPwd gesture:(NSString *)gesture authMethod:(AuthMethodType)authMethod;

@end

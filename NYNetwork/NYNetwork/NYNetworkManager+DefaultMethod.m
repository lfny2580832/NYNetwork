//
//  NYNetworkManager+DefaultMethod.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/30.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager+DefaultMethod.h"

@implementation NYNetworkManager (DefaultMethod)

- (void)defaultMethodRequestSuccessWithRequest:(NYBaseRequest *)request
{

}

- (void)defaultMethodRequestFaulureWithRequest:(NYBaseRequest *)request
{
    if (request.responseStatusCode == 409) {
        NSLog(@"强制下线");
    }
}

@end

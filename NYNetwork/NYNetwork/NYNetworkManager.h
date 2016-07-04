//
//  NYNetworkManager.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYBaseRequest.h"

@class NYNetworkManager;

@interface NYNetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)addRequest:(NYBaseRequest *)request;

@end

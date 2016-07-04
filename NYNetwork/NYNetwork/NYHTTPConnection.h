//
//  NYHTTPConnection.h
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYBaseRequest.h"

@class NYHTTPConnection;

typedef void (^ConnectionSuccessBlock)(NYHTTPConnection *connection, id responseJsonObject);
typedef void (^ConnectionFailureBlock)(NYHTTPConnection *connection, NSError *error);



@interface NYHTTPConnection : NSObject

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

- (void)connectWithRequest:(NYBaseRequest *)request success:(ConnectionSuccessBlock)success failure:(ConnectionFailureBlock)failure;

@end

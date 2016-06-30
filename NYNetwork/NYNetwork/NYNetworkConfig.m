//
//  NYNetworkConfig.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkConfig.h"

@interface NYNetworkConfig ()

//终端，1代表iOS平台
@property (nonatomic, copy) NSString *terminal;

@property (nonatomic, strong, readwrite) NSDictionary *additionalHeaderFields;

@end

@implementation NYNetworkConfig

+ (NYNetworkConfig *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _additionalHeaderFields = @{};
        self.baseUrl = @"";
        self.defaultAcceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
        self.defaultAcceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/javascript", @"application/json", nil];
    }
    return self;
}

- (NSDictionary *)additionalHeaderFields
{
    return @{
             @"Authorization":self.token,
             @"version":self.version,
             @"terminal":@"1",
             };
}

@end

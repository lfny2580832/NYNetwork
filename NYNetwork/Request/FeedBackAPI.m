//
//  FeedBackAPI.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/17.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "FeedBackAPI.h"

@implementation FeedBackAPI
{
    NSString *_feedback;
    NSString *_remark;
}

- (id)initWithFeedback:(NSString *)feedback remark:(NSString *)remark
{
    self = [super init];
    if (self) {
        _feedback = feedback;
        _remark = (remark.length)?remark:@"";
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/feedbacks";
}

- (NYRequestMethod)requestMethod {
    return NYRequestMethodPost;
}

//- (NSDictionary *)requestHeaderFieldValueDictionary
//{
//    return @{
//             @"Authorization": [KeyChain token],
//             };
//}

- (id)requestArgument {
    return @{
             @"feedback": _feedback,
             @"remark":_remark
             };
}

@end

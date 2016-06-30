//
//  FeedBackAPI.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/6/17.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "NYNetwork.h"

@interface FeedBackAPI : NYBaseRequest

- (id)initWithFeedback:(NSString *)feedback remark:(NSString *)remark;

@end

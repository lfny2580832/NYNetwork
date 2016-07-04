//
//  ViewController.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "ViewController.h"
#import "BannerAPI.h"
#import "LoginAPI.h"
#import "FeedBackAPI.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 200, 200)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(testMemeory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)login
{
    NSString *secrect = [self MD5FromString:@"123456"];
    LoginAPI *api = [[LoginAPI alloc]initWithPhone:@"18035735959" loginPwd:secrect gesture:@"" authMethod:LoginPwd];
    [api startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"success: %@",responseObject);
    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"failure:%@",error);
    }];
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:api];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"api %@", retainCycles);
}

- (void)getBanner
{
    BannerAPI *api = [[BannerAPI alloc]init];
    [api startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"success: %@",responseObject);

    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"failure:%@",error);

    }];
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:api];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"api %@", retainCycles);
}

- (void)feedBack
{
    FeedBackAPI *api = [[FeedBackAPI alloc]initWithFeedback:@"fuck 甘少聪" remark:@"harder"];
    [api startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSLog(@"success: %@",responseObject);

    } failure:^(NYBaseRequest *request, NSError *error) {
        NSLog(@"failure:%@",error);

    }];
}

- (NSString *)MD5FromString:(NSString *)string{
    if(self == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (void)testMemeory
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *url = @"http://api.hoomxb.com/banners";
    NSDictionary *dict = [NSDictionary new];
    
    
    [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"failure:%@",error);

    }];
}
@end

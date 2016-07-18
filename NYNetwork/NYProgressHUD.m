//
//  NYProgressHUD.m
//  GoDo
//
//  Created by 牛严 on 16/4/2.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "NYProgressHUD.h"

@interface NYProgressHUD ()<MBProgressHUDDelegate>
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (assign, nonatomic)int  mTime;
@end

@implementation NYProgressHUD
{
    NSTimer *timer;
}

+ (void)showToastText:(NSString *)text
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithWindow:keyWindow];
    [keyWindow addSubview:HUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    
    int sec = text.length > 6? 2:1;

    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(sec);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

+ (void)showToastText:(NSString *)text completion:(void(^)())completionBlock
{
    [self showToastText:text];
    int sec = text.length > 6? 2:1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completionBlock();
    });
}

- (void)showAnimationWithText:(NSString *)text
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _HUD = [[MBProgressHUD alloc]initWithWindow:keyWindow];
    
    [keyWindow addSubview:_HUD];
    _HUD.labelText = text;
    _HUD.delegate = self;//添加代理
    
    [_HUD show:YES];
    self.mTime =0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:30];
    timer.fireDate = [NSDate distantPast];
    
}

-(void)timerFired:(NSTimer *)time{
 
    self.mTime++;

    NSLog(@">>>>>>>>>>>>>>>%d",self.mTime);
    if (self.mTime >= 12) {
       timer.fireDate = [NSDate distantFuture];
        [self hide];
    }
}

-(void)hide
{
    [_HUD hide:YES];
    if (timer) {
      timer.fireDate = [NSDate distantFuture];
    }
    
}

#pragma mark MBProgressHUD代理方法
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [_HUD removeFromSuperview];
    if (_HUD != nil) {
        _HUD = nil;
    }
}

@end

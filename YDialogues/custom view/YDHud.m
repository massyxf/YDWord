//
//  YDHud.m
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDHud.h"

@interface YDHud ()

@end

static NSString * const animationKey = @"rotaionAniamtion";

@implementation YDHud

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = CGRectGetWidth(frame);
        CGFloat height = CGRectGetHeight(frame);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2.0, height / 2.0)
                                                            radius:width / 2.0
                                                        startAngle:0
                                                          endAngle:2 *M_PI
                                                         clockwise:YES];
        //灰色管道
        CAShapeLayer *bottomLayer = [CAShapeLayer layer];
        bottomLayer.path = path.CGPath;
        bottomLayer.fillColor = [UIColor clearColor].CGColor;
        bottomLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        bottomLayer.lineWidth = 3;
        bottomLayer.strokeStart = 0;
        bottomLayer.strokeEnd = 1.0;
        [self.layer addSublayer:bottomLayer];
        
        //白色管道
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.lineWidth = 3;
        shapeLayer.strokeStart = 0;
        shapeLayer.strokeEnd = 0.33;
        [self.layer addSublayer:shapeLayer];
    }
    return self;
}

-(void)startShow{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = NO;
        [self.layer removeAnimationForKey:animationKey];
        //自旋动画
        CABasicAnimation *viewAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        viewAnimation.toValue = @(-M_PI * 2);
        viewAnimation.duration = 0.8;
        viewAnimation.repeatCount = MAXFLOAT;
        viewAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
        [self.layer addAnimation:viewAnimation forKey:animationKey];
    });
}

-(void)hide{
    self.hidden = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.layer removeAllAnimations];
    });
}

@end

@interface YDHubWindow ()

/** hud*/
@property(nonatomic,weak)YDHud *hud;

@end

@implementation YDHubWindow

+(instancetype)shareInstance{
    static YDHubWindow *hudWindow = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        hudWindow = [[YDHubWindow alloc] initWithFrame:keyWindow.bounds];
        [keyWindow addSubview:hudWindow];
        
        YDHud *hud = [[YDHud alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [hudWindow addSubview:hud];
        hud.center = hudWindow.center;
        hudWindow.hud = hud;
        
        hudWindow.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        hudWindow.hidden = YES;
    });
    return hudWindow;
}

+(void)hudwindowShow{
    YDHubWindow *hudwindow = [YDHubWindow shareInstance];
    hudwindow.hidden = NO;
    [hudwindow.hud startShow];
}

+(void)hudwindowHide{
    YDHubWindow *hudwindow = [YDHubWindow shareInstance];
    [hudwindow.hud hide];
    hudwindow.hidden = YES;
}

@end

//
//  YDWindowView.m
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDWindowView.h"

typedef NS_ENUM(NSInteger, YDBtnLocation) {
    YDBtnLocationLeftTop = 0,
    YDBtnLocationRightTop,
    YDBtnLocationLeftBottom,
    YDBtnLocationRightBottom
};

#define YDWindowMargin 80

@interface YDWindowView ()<UIGestureRecognizerDelegate>

/** note*/
@property(nonatomic,weak)UIButton *noteBtn;

/** trans*/
@property(nonatomic,weak)UIButton *transBtn;

/** bool*/
@property(nonatomic,assign)BOOL animating;

@end

@implementation YDWindowView

+(instancetype)windowView{
    static dispatch_once_t onceToken;
    static YDWindowView *windowView = nil;
    dispatch_once(&onceToken, ^{
        CGFloat length = 40;
        windowView = [[YDWindowView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 60, SCREENHEIGHT - 80, length, length)];
        [[UIApplication sharedApplication].delegate.window addSubview:windowView];
        [windowView addGesture];
        windowView.backgroundColor = [UIColor redColor];
    });
    
    return windowView;
}

-(void)addGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - getter
-(UIButton *)transBtn{
    if (!_transBtn) {
        _transBtn = [self tabButton:@selector(transBtnClicked:) img:@""];
        [_transBtn setBackgroundColor:[UIColor blueColor]];
    }
    return _transBtn;
}

-(UIButton *)noteBtn{
    if (!_noteBtn) {
        _noteBtn = [self tabButton:@selector(noteBtnClicked:) img:@""];
        _noteBtn.backgroundColor = [UIColor orangeColor];
    }
    return _noteBtn;
}

#pragma mark -action
-(IBAction)tap:(UITapGestureRecognizer *)sender{
    if (!_animating) {
        _animating = YES;
        self.noteBtn.isHidden ? [self showSubBtn] : [self hideBtn];
    }
}

-(IBAction)pan:(UIPanGestureRecognizer *)sender{
    
    if (!self.noteBtn.isHidden) {
        [self hideBtn];
    }
    
    if (self.superview) {
       CGPoint point = [sender locationInView:self.superview];
        if (point.x < 20) {
            point.x = 20;
        }
        if (point.x > SCREENWIDTH - 20) {
            point.x = SCREENWIDTH - 20;
        }
        if (point.y < 40) {
            point.y = 40;
        }
        
        if (point.y > SCREENHEIGHT - 40) {
            point.y = SCREENHEIGHT - 40;
        }
        self.center = point;
    }
}

-(IBAction)transBtnClicked:(id)sender{
    [self hideBtn];
    if ([self.delegate respondsToSelector:@selector(windowView:selectIndex:)]) {
        [self.delegate windowView:self selectIndex:YDTabClassTrans];
    }
}

-(IBAction)noteBtnClicked:(id)sender{
    [self hideBtn];
    if ([self.delegate respondsToSelector:@selector(windowView:selectIndex:)]) {
        [self.delegate windowView:self selectIndex:YDTabClassNote];
    }
}

#pragma mark - custom func
-(UIButton *)tabButton:(SEL)action img:(NSString *)img{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [self.superview addSubview:button];
    button.hidden = YES;
    return button;
}

-(YDBtnLocation)suggestBtnLocation{
    if (self.center.x > SCREENWIDTH / 2.0) {//left
        if (self.center.y > SCREENHEIGHT / 2.0) {//下
            return YDBtnLocationLeftTop;
        }else{
            return YDBtnLocationLeftBottom;
        }
    }else{//right
        if (self.center.y > SCREENHEIGHT / 2.0) {//下
            return YDBtnLocationRightTop;
        }else{
            return YDBtnLocationRightBottom;
        }
    }
}

-(CGPoint)noteCenterWithLocation:(YDBtnLocation)location{
    CGPoint point = CGPointZero;
    switch (location) {
        case YDBtnLocationLeftTop:
        {
            point.x = self.yd_x - YDWindowMargin;
            point.y = self.yd_y;
        }
            break;
        case YDBtnLocationLeftBottom:
        {
            point.x = self.yd_x - YDWindowMargin;
            point.y = CGRectGetMaxY(self.frame);
        }
            break;
        case YDBtnLocationRightTop:
        {
            point.x = CGRectGetMaxX(self.frame) + YDWindowMargin;
            point.y = self.yd_y;
        }
            break;
        case YDBtnLocationRightBottom:
        {
            point.x = CGRectGetMaxX(self.frame) + YDWindowMargin;
            point.y = CGRectGetMaxY(self.frame);
        }
        default:
            break;
    }
    
    return point;
}

-(CGPoint)transCenterWithLocation:(YDBtnLocation)location{
    CGPoint point = CGPointZero;
    switch (location) {
        case YDBtnLocationLeftTop:{
            point.y = self.yd_y - YDWindowMargin;
            point.x = self.yd_x;
        }
            break;
        case YDBtnLocationRightTop:{
            point.y = self.yd_y - YDWindowMargin;
            point.x = CGRectGetMaxX(self.frame);
        }
            break;
        case YDBtnLocationLeftBottom:{
            point.y = CGRectGetMaxY(self.frame) + YDWindowMargin;
            point.x = self.yd_x;
        }
            break;
        case YDBtnLocationRightBottom:{
            point.y = CGRectGetMaxY(self.frame) + YDWindowMargin;
            point.x = CGRectGetMaxX(self.frame);
        }
            break;
        default:
            break;
    }
    return point;
}

-(void)showSubBtn{
    CGFloat width = 35;
    YDBtnLocation location = [self suggestBtnLocation];
    self.noteBtn.hidden = NO;
    self.transBtn.hidden = NO;
    self.noteBtn.center = self.center;
    self.transBtn.center = self.center;
    CGPoint noteCenter = [self noteCenterWithLocation:location];
    CGPoint transCenter = [self transCenterWithLocation:location];
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.noteBtn.frame = CGRectMake(0, 0, width, width);
                         self.transBtn.frame = CGRectMake(0, 0, width, width);
                         self.noteBtn.center = noteCenter;
                         self.transBtn.center = transCenter;
                     } completion:^(BOOL finished) {
                         self.animating = NO;
                     }];
}

-(void)hideBtn{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.noteBtn.frame = CGRectZero;
                         self.transBtn.frame = CGRectZero;
                         self.noteBtn.center = self.center;
                         self.transBtn.center = self.center;
                     } completion:^(BOOL finished) {
                         self.noteBtn.hidden = YES;
                         self.transBtn.hidden = YES;
                         self.animating = NO;
                     }];
}

@end

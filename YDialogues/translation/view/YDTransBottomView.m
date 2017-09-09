//
//  YDTransBottomView.m
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTransBottomView.h"
#import "YDLangView.h"
#import "YDTextView.h"
#import <Masonry/Masonry.h>

@interface YDTransBottomView ()<CAAnimationDelegate>

/** keyboard*/
@property(nonatomic,weak)UIButton *keyboardBtn;

/** left */
@property(nonatomic,weak)YDLangView *leftView;

/** right*/
@property(nonatomic,weak)YDLangView *rightView;

/** text view*/
@property(nonatomic,weak)YDTextView *textView;

/** voice view*/
@property(nonatomic,weak)UIView *voiceView;

/** current view*/
@property(nonatomic,weak)UIView *currentView;

@end

@implementation YDTransBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat rate = 66 / 255.0;
        self.backgroundColor = [UIColor colorWithRed:rate green:rate blue:rate alpha:1.0];
        
        YDLangView *leftview = [YDLangView initWithType:YDLangViewFrom lang:1];
        [self addSubview:leftview];
        _leftView = leftview;
        
        UIButton *keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardBtn setImage:[UIImage imageNamed:@"ic_keyboard"] forState:UIControlStateNormal];
        [keyboardBtn setImage:[UIImage imageNamed:@"voice_three"] forState:UIControlStateSelected];
        [keyboardBtn addTarget:self action:@selector(changeTransType:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:keyboardBtn];
        _keyboardBtn = keyboardBtn;
        
        YDLangView *rightview = [YDLangView initWithType:YDLangViewTo lang:2];
        [self addSubview:rightview];
        _rightView = rightview;
        
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        _voiceView = view;
        
        NSString *placeholder = @"请输入需要翻译的内容";
        YDTextView *textView = [[YDTextView alloc] initWithFrame:CGRectZero placeholder:placeholder];
        [self addSubview:textView];
        _textView = textView;
        
        [leftview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(85);
            make.centerY.mas_equalTo(self);
        }];
        
        [rightview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self).offset(-5);
            make.width.height.centerY.mas_equalTo(leftview);
        }];
        
        [keyboardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(10);
            make.width.height.mas_equalTo(25);
            make.centerX.mas_equalTo(self);
        }];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(keyboardBtn.mas_bottom).offset(5);
            make.leading.equalTo(leftview.mas_trailing).offset(5);
            make.trailing.equalTo(rightview.mas_leading).offset(-5);
            make.bottom.mas_equalTo(self).offset(-5);
        }];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        textView.backgroundColor = [UIColor blueColor];
        view.backgroundColor = [UIColor redColor];
        view.hidden = YES;
    }
    return self;
}

-(IBAction)changeTransType:(UIButton *)button{
    _currentView = button.isSelected ? _voiceView : _textView;
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.startProgress = 0;
    animation.endProgress = 1.0;
    animation.duration = 0.25;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [_currentView.layer addAnimation:animation forKey:@"niamation"];
}

-(void)animationDidStart:(CAAnimation *)anim{

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        _keyboardBtn.selected = !_keyboardBtn.isSelected;
    }
    [_currentView.layer removeAllAnimations];
    _voiceView.hidden = !_keyboardBtn.isSelected;
    _textView.hidden = _keyboardBtn.isSelected;
}

@end

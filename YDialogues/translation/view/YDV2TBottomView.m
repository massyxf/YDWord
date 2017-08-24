//
//  YDV2TBottomView.m
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDV2TBottomView.h"
#import "YDLangView.h"

@interface YDV2TBottomView ()

/** keyboard*/
@property(nonatomic,weak)UIButton *keyboardBtn;

/** left */
@property(nonatomic,weak)YDLangView *leftView;

/** right*/
@property(nonatomic,weak)YDLangView *rightView;

@end

@implementation YDV2TBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        void (^block)() = ^(){
        
        };
        YDLangView *leftview = [YDLangView initWithTitle:@"" langBtnAction:block];
        [self addSubview:leftview];
        _leftView = leftview;
        
        UIButton *keyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:keyboardBtn];
        _keyboardBtn = keyboardBtn;
        
        YDLangView *rightview = [YDLangView initWithTitle:@"" langBtnAction:block];
        [self addSubview:rightview];
        _rightView = rightview;
    }
    return self;
}

@end

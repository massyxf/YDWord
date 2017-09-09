//
//  YDLangView.m
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDLangView.h"
#import "YDLangBtn.h"
#import <Masonry/Masonry.h>

@interface YDLangView ()

/** flag*/
@property(nonatomic,weak)UIImageView *flagView;

/** lang*/
@property(nonatomic,weak)YDLangBtn *langBtn;

/** action lang*/
@property(nonatomic,copy)void (^langAction)();

@end

@implementation YDLangView

+(instancetype)initWithTitle:(NSString *)title langBtnAction:(void (^)())langAction{
    YDLangView *langView = [[YDLangView alloc] initWithFrame:CGRectZero];
    if (langView) {
        langView.langAction = langAction;
        UIImageView *flagView = [[UIImageView alloc] init];
        [langView addSubview:flagView];
        langView.flagView = flagView;
        
        YDLangBtn *langBtn = [YDLangBtn buttonWithTitle:title target:self action:@selector(langBtnClicked:)];
        [langView addSubview:langBtn];
        langView.langBtn = langBtn;
        
        [flagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.mas_equalTo(langView);
            make.bottom.mas_equalTo(langBtn.mas_top).offset(-5);
        }];
        
        [langBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(langView);
            make.height.mas_equalTo(20);
        }];
    }
    return langView;
}

-(void)flagViewAddGesture:(UIGestureRecognizer *)gesture{
    _flagView.userInteractionEnabled = YES;
    [_flagView addGestureRecognizer:gesture];
}

-(IBAction)langBtnClicked:(id)sender{
    !_langAction ? : _langAction();
}

@end

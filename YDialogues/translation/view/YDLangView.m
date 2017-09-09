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
#import "NSString+YDCountryLang.h"

@interface YDLangView ()

/** flag*/
@property(nonatomic,weak)UIButton *flagBtn;

/** lang*/
@property(nonatomic,weak)YDLangBtn *langBtn;

/** type*/
@property(nonatomic,assign)YDLangViewType type;

@end

@implementation YDLangView

+(instancetype)initWithType:(YDLangViewType)langType lang:(NSInteger)lang{
    YDLangView *langView = [[YDLangView alloc] initWithFrame:CGRectZero];
    if (langView) {
        langView.type = langType;
        
        UIButton *flagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *img = [NSString countryImgWithId:lang];
        [flagBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [flagBtn addTarget:self action:@selector(flagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [langView addSubview:flagBtn];
        langView.flagBtn = flagBtn;
        
        NSString *title = [NSString languageWithId:lang];
        YDLangBtn *langBtn = [YDLangBtn buttonWithTitle:title target:self action:@selector(langBtnClicked:)];
        [langView addSubview:langBtn];
        langView.langBtn = langBtn;
        
        [flagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)setLang:(NSInteger)lang{
    if (_lang != lang) {
        _lang = lang;
        NSString *img = [NSString countryImgWithId:lang];
        [_flagBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        NSString *title = [NSString languageWithId:lang];
        [_langBtn setTitle:title forState:UIControlStateNormal];
        [_langBtn layoutIfNeeded];
    }
}

-(IBAction)langBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(langViewChangeCountry:)]) {
        [self.delegate langViewChangeCountry:self];
    }
}

-(IBAction)flagBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(langViewSendMsg:)]) {
        [self.delegate langViewSendMsg:self];
    }
}

@end

//
//  YDEditNoteHeadView.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDEditNoteHeadView.h"
#import <Masonry/Masonry.h>

@interface YDEditNoteHeadView ()

@end

@implementation YDEditNoteHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *wordLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
        [self addSubview:wordLabel];
        wordLabel.text = @"单词";
        
        UILabel *transLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
        [self addSubview:transLabel];
        transLabel.text = @"翻译";
        
        [wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(5);
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(100);
        }];
        
        [transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.trailing.mas_equalTo(self).offset(-5);
            make.leading.mas_equalTo(wordLabel.mas_trailing).offset(10);
        }];
    }
    return self;
}

@end

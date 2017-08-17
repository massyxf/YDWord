//
//  YDEditNoteFootView.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDEditNoteFootView.h"
#import <Masonry/Masonry.h>
#import "YDNoteWordModel.h"
#import "YDRadiusView.h"

#define YDTextMargin 5

@interface YDEditNoteFootView ()<UITextFieldDelegate>

/** 单词*/
@property(nonatomic,weak)UITextField *wordTextField;

/** 翻译*/
@property(nonatomic,weak)UITextField *transTextField;

/** 添加按钮*/
@property(nonatomic,weak)UIButton *addBtn;

@end

@implementation YDEditNoteFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        YDRadiusView *radiusview = [[YDRadiusView alloc] initWithFrame:CGRectZero];
        [self addSubview:radiusview];
        radiusview.radius = 3;
        radiusview.backgroundColor = [UIColor whiteColor];
        [radiusview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addWord:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        _addBtn = addBtn;
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.centerX.equalTo(self);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(80);
        }];
        _wordTextField = [self textViewWithPlaceholder:@"请输入单词"];
        _transTextField = [self textViewWithPlaceholder:@"请输入单词的翻译"];
        
        [_wordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self).offset(YDTextMargin);
            make.trailing.mas_equalTo(self).offset(-YDTextMargin);
            make.height.mas_equalTo(30);
        }];
        
        [_transTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.leading.mas_equalTo(_wordTextField);
            make.top.mas_equalTo(_wordTextField.mas_bottom).offset(YDTextMargin);
        }];
        
    }
    return self;
}


-(UITextField *)textViewWithPlaceholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    textField.placeholder = placeholder;
    [self addSubview:textField];
    return textField;
}

-(IBAction)addWord:(id)sender{

    if (_wordTextField.text.length > 0 && _transTextField.text.length > 0) {
        if ([self.delegate respondsToSelector:@selector(editnoteFootview:addWordModel:)]) {
            YDNoteWordModel *wordModel = [[YDNoteWordModel alloc] init];
            wordModel.title = _wordTextField.text;
            wordModel.trans = _transTextField.text;
            NSInteger dateId = (NSInteger)[[NSDate date] timeIntervalSince1970];
            wordModel.uniqId = dateId;
            wordModel.dateId = dateId;
            [self.delegate editnoteFootview:self addWordModel:wordModel];
            
            [self endEditing:YES];
            _wordTextField.text = @"";
            _transTextField.text = @"";
        }
    }
}

@end

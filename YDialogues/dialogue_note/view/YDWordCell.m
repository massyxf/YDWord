//
//  YDWordCell.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDWordCell.h"
#import <Masonry/Masonry.h>
#import "YDNoteWordModel.h"

@interface YDWordCell ()

/** 单词*/
@property(nonatomic,weak)UILabel *wordLabel;

/** 翻译*/
@property(nonatomic,weak)UILabel *transLabel;

@end

@implementation YDWordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *wordLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor] numberOfLines:0];
        [self.contentView addSubview:wordLabel];
        _wordLabel = wordLabel;
        
        UILabel *transLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor] numberOfLines:0];
        [self.contentView addSubview:transLabel];
        _transLabel = transLabel;
        
        [wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView).offset(5);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(100);
        }];
        
        [transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.trailing.mas_equalTo(self.contentView).offset(-5);
            make.leading.equalTo(wordLabel.mas_trailing).offset(10);
        }];
    }
    return self;
}

-(void)setWordModel:(YDNoteWordModel *)wordModel{
    _wordModel = wordModel;
    _wordLabel.text = wordModel.title;
    _transLabel.text = wordModel.trans;
}

-(CGFloat)heightWithModel:(YDNoteWordModel *)model{
    CGFloat height = 0;
    self.wordModel = model;
    [self layoutIfNeeded];
    
    CGFloat wordY = CGRectGetHeight(_wordLabel.frame);
    CGFloat transY = CGRectGetHeight(_transLabel.frame);
    
    height = MAX(wordY, transY) + 10;
    
    if (height < 44) {
        height = 44;
    }
    
    model.height = height;
    
    return height;
}


@end

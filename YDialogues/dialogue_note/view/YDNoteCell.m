//
//  YDNoteCell.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDNoteCell.h"
#import <Masonry/Masonry.h>

@interface YDNoteCell ()

/** 标题*/
@property(nonatomic,weak)UILabel *titleLabel;

/** 日期*/
@property(nonatomic,weak)UILabel *dateLabel;

@end

@implementation YDNoteCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        UILabel *titleLabel = [UILabel labelWithFontSize:18
                                               textColor:[UIColor blackColor]
                                           numberOfLines:0];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.text = @"title title title title title title title title title title title title ";
        
        UILabel *dateLabel = [UILabel labelWithFontSize:14
                                              textColor:[UIColor grayColor]];
        [self.contentView addSubview:dateLabel];
        self.dateLabel = dateLabel;
        dateLabel.text = @"2017-06-08";
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView).offset(5);
            make.top.bottom.mas_equalTo(self.contentView);
            make.trailing.equalTo(dateLabel.mas_leading).offset(-5);
        }];
        
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.contentView).offset(-5);
            make.bottom.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
    }
    return self;
}

@end

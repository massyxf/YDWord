//
//  YDV2TCell.m
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDV2TCell.h"
#import "YDV2TModel.h"

@interface YDV2TCell ()

/** 翻译文字*/
@property(nonatomic,weak)UILabel *transLabel;

/** 文字转语音按钮*/
@property(nonatomic,weak)UIButton *transBtn;

/** lang image*/
@property(nonatomic,weak)UIImageView *langImgView;

@end

@implementation YDV2TCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        imgView.frame = CGRectMake(0, 0, 30, 30);
        imgView.backgroundColor = [UIColor redColor];
        _langImgView = imgView;
        
        UILabel *transLabel = [UILabel labelWithFontSize:14
                                               textColor:[UIColor blackColor]
                                           numberOfLines:0];
        [self.contentView addSubview:transLabel];
        transLabel.backgroundColor = [UIColor blueColor];
        _transLabel = transLabel;
        
        
        UIButton *transBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [transBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.contentView addSubview:transBtn];
        transBtn.backgroundColor = [UIColor orangeColor];
        _transBtn = transBtn;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentWidth = self.contentView.yd_width;
    //左10，右20
    _langImgView.yd_centerX = contentWidth / 2.0;
    CGFloat labelWidth = contentWidth - 30;
    CGFloat labelHeight = [_transLabel sizeThatFits:CGSizeMake(labelWidth, MAXFLOAT)].height;
    _transLabel.frame = CGRectMake(10, 30, labelWidth, labelHeight);
    _transBtn.frame = CGRectMake(contentWidth - 20, CGRectGetMaxY(_transLabel.frame), 20, 20);
}

-(void)setModel:(YDV2TModel *)model{
    _model = model;
    NSMutableAttributedString *transText = [[NSMutableAttributedString alloc] init];
    if (model.text.length > 0) {
        NSAttributedString *textAtt =[[NSAttributedString alloc] initWithString:model.text attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
        [transText appendAttributedString:textAtt];
    }
    if (transText.length > 0) {
        NSAttributedString *enterAtt = [[NSAttributedString alloc] initWithString:@"\n"];
        [transText appendAttributedString:enterAtt];
    }
    if (model.transText.length > 0) {
        NSAttributedString *transAtt = [[NSAttributedString alloc] initWithString:model.transText attributes:nil];
        [transText appendAttributedString:transAtt];
    }else{
        NSAttributedString *notransAtt = [[NSAttributedString alloc] initWithString:@"翻译失败" attributes:nil];
        [transText appendAttributedString:notransAtt];
    }
    _transLabel.attributedText = transText;
}

-(IBAction)vtcBtnClicked:(id)sender{
    !self.v2tBlock ? : self.v2tBlock(_model);
}

-(CGFloat)heightWithModel:(YDV2TModel *)model{
    self.model = model;
    [self layoutIfNeeded];
    model.height = CGRectGetMaxY(_transBtn.frame);
    return model.height;
}

@end

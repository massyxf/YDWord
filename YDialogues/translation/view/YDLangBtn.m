//
//  YDLangBtn.m
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDLangBtn.h"

@implementation YDLangBtn

+(instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    YDLangBtn *btn = [YDLangBtn buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"ic_pull_down"] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat padding = 2;
    CGFloat imgLength = 10;
    CGFloat width = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, imgLength * padding)].width;
    CGFloat maxWidth = width + imgLength + padding * 3;
    CGFloat height = self.yd_height - padding * 2;
    if (maxWidth <= self.yd_width) {
        CGFloat x = (self.yd_width - maxWidth) / 2.0 + padding;
        self.titleLabel.frame = CGRectMake(x, padding, width, height);
        self.imageView.frame = CGRectMake(x + width + padding,0, imgLength, imgLength);
    }else{
        self.imageView.frame = CGRectMake(self.yd_width - 2 * padding - imgLength, 0, imgLength, imgLength);
        self.titleLabel.frame = CGRectMake(padding, padding, self.imageView.yd_x - padding - padding, height);
    }
    self.imageView.yd_centerY = self.yd_height / 2.0 + 3;
}

@end

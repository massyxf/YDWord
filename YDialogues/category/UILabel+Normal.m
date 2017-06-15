//
//  UILabel+Normal.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "UILabel+Normal.h"

@implementation UILabel (Normal)

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    return label;
}

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
                textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [self labelWithFontSize:fontSize textColor:color];
    label.textAlignment = textAlignment;
    return label;
}

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
                numberOfLines:(NSInteger)numberOfLines
{
    UILabel *label = [self labelWithFontSize:fontSize textColor:color];
    label.numberOfLines = numberOfLines;
    return label;
}

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLines
{
    UILabel *label = [self labelWithFontSize:fontSize textColor:color];
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    return label;
}

@end

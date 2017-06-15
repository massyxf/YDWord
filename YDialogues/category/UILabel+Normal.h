//
//  UILabel+Normal.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Normal)

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color;

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
                textAlignment:(NSTextAlignment)textAlignment;

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
                numberOfLines:(NSInteger)numberOfLines;

+(UILabel *)labelWithFontSize:(CGFloat)fontSize
                    textColor:(UIColor *)color
                textAlignment:(NSTextAlignment)textAlignment
                numberOfLines:(NSInteger)numberOfLines;

@end

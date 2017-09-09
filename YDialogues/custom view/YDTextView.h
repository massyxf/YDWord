//
//  YDTextView.h
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDTextView : UITextView

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)textColor font:(CGFloat)fontSize;



@end

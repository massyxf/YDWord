//
//  YDTextView.m
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTextView.h"

@interface YDTextView ()<UITextViewDelegate>

/** placeholder label*/
@property(nonatomic,weak)UILabel *placeholderLabel;

@end

@implementation YDTextView

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    return [self initWithFrame:frame placeholder:placeholder textColor:[UIColor redColor] font:15];
}

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)textColor font:(CGFloat)fontSize{
    self = [super initWithFrame:frame];
    if (self) {
        _placeholderLabel.text = placeholder;
        _placeholderLabel.textColor = textColor;
        _placeholderLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, 100, 20)];
        [self addSubview:placeLabel];
        _placeholderLabel = placeLabel;
        self.delegate = self;
    }
    return self;
}

-(void)textViewDidChange:(UITextView *)textView{
    _placeholderLabel.hidden = textView.text.length > 0;
    if ([textView.text hasSuffix:@"\n"]) {
        [textView endEditing:YES];
    }
}

@end

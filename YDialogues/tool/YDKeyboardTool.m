//
//  YDKeyboardTool.m
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDKeyboardTool.h"

@implementation YDKeyboardTool

+(instancetype)shareInstance{
    static YDKeyboardTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

-(void)startObserving{
    [self removeObserving];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];}

-(void)removeObserving{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardShow:(NSNotification *)note{
    CGFloat keyboardY = CGRectGetMinY([note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]  doubleValue];
    if ([self.delegate respondsToSelector:@selector(keyboardTool:willShow:duration:)]) {
        [self.delegate keyboardTool:self willShow:keyboardY duration:time];
    }
}

-(void)keyboardHide:(NSNotification *)note{
    if ([self.delegate respondsToSelector:@selector(keyboardToolWillHide:)]) {
        [self.delegate keyboardToolWillHide:self];
    }
}

-(void)dealloc{
    [self removeObserving];
}

@end

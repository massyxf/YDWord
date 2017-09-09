//
//  YDKeyboardTool.h
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDKeyboardTool;

@protocol YDKeyboardToolDelegate <NSObject>

-(void)keyboardTool:(YDKeyboardTool *)tool willShow:(CGFloat)keyboardMinY duration:(CGFloat)duration;

-(void)keyboardToolWillHide:(YDKeyboardTool *)tool;

@end

@interface YDKeyboardTool : NSObject

/** delegate*/
@property(nonatomic,weak)id<YDKeyboardToolDelegate> delegate;

+(instancetype)shareInstance;

-(void)startObserving;

-(void)removeObserving;

@end

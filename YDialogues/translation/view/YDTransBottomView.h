//
//  YDTransBottomView.h
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDLangView;

@interface YDTransBottomView : UIView

/** left */
@property(nonatomic,weak,readonly)YDLangView *leftView;

/** right*/
@property(nonatomic,weak,readonly)YDLangView *rightView;

@end

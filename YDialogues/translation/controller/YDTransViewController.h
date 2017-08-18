//
//  YDTransViewController.h
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDTransSubVcProtocol.h"

#define YDTransTag 999

@interface YDTransViewController : UIViewController<YDTransSubVcProtocol>

/** 翻译*/
@property(nonatomic,weak,readonly)UILabel *transLabel;

/** 翻译的滚动视图*/
@property(nonatomic,weak,readonly)UIScrollView *transScrollView;

@end

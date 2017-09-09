//
//  YDTranslationViewController.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDTransSubVcProtocol.h"

@interface YDTranslationViewController : UIViewController

/** child vcs*/
@property(nonatomic,strong)NSArray<UIViewController<YDTransSubVcProtocol> *> *subVcs;

@end

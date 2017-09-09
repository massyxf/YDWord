//
//  YDOcrTool.h
//  YDialogues
//
//  Created by yxf on 2017/8/21.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDOcrTool : NSObject

+(void)transPic:(UIImage *)image completion:(YDTransCompletion)completion;

@end

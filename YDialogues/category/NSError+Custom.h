//
//  NSError+Custom.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSInteger YXFPayError;


@interface NSError (Custom)

+(instancetype)errorWithCode:(NSInteger)code text:(NSString *)error;

@end

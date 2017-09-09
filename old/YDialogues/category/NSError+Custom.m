//
//  NSError+Custom.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "NSError+Custom.h"

NSInteger YXFPayError = 300001;

@implementation NSError (Custom)

+(instancetype)errorWithCode:(NSInteger)code text:(NSString *)errorText{
    NSErrorDomain domain = @"hoomao.cn";
    NSError *error = [[NSError alloc] initWithDomain:domain
                                                code:code
                                            userInfo:@{NSLocalizedDescriptionKey : errorText}];
    return error;
}

@end

//
//  NSString+YDHandle.m
//  YDialogues
//
//  Created by yxf on 2017/6/15.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "NSString+YDHandle.h"

@implementation NSString (YDHandle)

+(NSString *)removeSpaceAndNewlineAtPrefixAndSuffix:(NSString *)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

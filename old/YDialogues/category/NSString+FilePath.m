//
//  NSString+FilePath.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "NSString+FilePath.h"

@implementation NSString (FilePath)

+(NSString *)cacheDirectory
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}

+(NSString *)docDirectory{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}

+(NSString *)tempDirectory{
    return NSTemporaryDirectory();
}

+(NSString *)cachePath:(NSString *)fileName{
    NSString *cachePath = [self cacheDirectory];
    return [cachePath stringByAppendingPathComponent:fileName];
}


@end

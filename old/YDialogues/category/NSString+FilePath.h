//
//  NSString+FilePath.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FilePath)

+(NSString *)cacheDirectory;

+(NSString *)docDirectory;

+(NSString *)tempDirectory;

+(NSString *)cachePath:(NSString *)fileName;


@end

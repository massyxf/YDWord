//
//  YDYoudaoConfig.m
//  YDialogues
//
//  Created by yxf on 2017/8/21.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDYoudaoConfig.h"

@interface YDYoudaoConfig ()

/** id*/
@property(nonatomic,copy)NSString *youdaoId;

/** key*/
@property(nonatomic,copy)NSString *youdaokey;

/** host*/
@property(nonatomic,copy)NSString *youdaoHost;

@end

@implementation YDYoudaoConfig

-(instancetype)init{
    self = [super init];
    if (self) {
       _youdaoId = @"22abdb49f3ec3b29";
        _youdaokey = @"I1to04WGsAZizsKBVLgKURa6tkigbVvb";
    }
    return self;
}

+(instancetype)initForTrans:(BOOL)trans{
    YDYoudaoConfig *config = [[self alloc] init];
    config.youdaoHost = trans ? @"https://openapi.youdao.com/api":@"https://openapi.youdao.com/ocrapi";
    return config;
}

@end

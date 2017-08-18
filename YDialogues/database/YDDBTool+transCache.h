//
//  YDDBTool+transCache.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool.h"

@class YDYoudaoModel;

@interface YDDBTool (transCache)

+(BOOL)initialTransTable;

+(BOOL)saveYoudaoModel:(YDYoudaoModel *)model;

@end

//
//  YDDBTool.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YDEnWordModel;
@class YDCnWordModel;

@interface YDDBTool : NSObject

+(instancetype)shareInstance;

+(void)saveEnWord:(YDEnWordModel *)word;

+(void)saveCnWord:(YDCnWordModel *)word;

@end

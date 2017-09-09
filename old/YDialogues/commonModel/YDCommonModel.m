//
//  YDCommonModel.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDCommonModel.h"

@implementation YDCommonModel

-(NSInteger)uniqId{
    if (!_uniqId) {
        _uniqId = (NSInteger)[[NSDate date] timeIntervalSince1970];
    }
    return _uniqId;
}

@end

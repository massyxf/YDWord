//
//  YDTimeTool.m
//  YDialogues
//
//  Created by 燕雪峰 on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTimeTool.h"

@interface YDTimeTool ()

/*time*/
@property (nonatomic,strong)NSDateFormatter *formater;

@end

@implementation YDTimeTool


+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static YDTimeTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[YDTimeTool alloc] init];
    });
    return tool;
    
}

#pragma mark - getter
-(NSDateFormatter *)formater{
    if (!_formater) {
        _formater = [[NSDateFormatter alloc] init];
    }
    return _formater;
}

#pragma mark - publlic func
+(NSString *)dateFormateWithTimeams:(NSInteger)timeams formate:(NSString *)formate{
    YDTimeTool *tool = [YDTimeTool shareInstance];
    [tool.formater setDateFormat:formate];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeams];
    return [tool.formater stringFromDate:date];
}

@end

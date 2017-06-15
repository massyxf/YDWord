//
//  YDNetServerManager.h
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YDNetSuccess)(id obj);

typedef void(^YDNetFail)(NSError *error);

@interface YDNetServerManager : NSObject


/**
 获取翻译

 @param words 单词
 @param success 成功的回调
 @param fail 失败的回调
 */
+(void)getWords:(NSString *)words
        success:(YDNetSuccess)success
           fail:(YDNetFail)fail;

@end

//
//  YDV2TTool.h
//  YDialogues
//
//  Created by 燕雪峰 on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDV2TTool : NSObject

//调用此方法前，必须先调用 initial 方法
+(instancetype)shareInstance;

//获取语音授权功能是否可用
+(void)initial:(void(^)(BOOL authorized))getAuth;

+(void)emptyV2TTool;

-(void)start;

-(void)cancel;

-(void)end;

@end

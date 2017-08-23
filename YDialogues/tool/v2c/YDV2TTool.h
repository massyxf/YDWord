//
//  YDV2TTool.h
//  YDialogues
//
//  Created by 燕雪峰 on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDV2TTool : NSObject

+(instancetype)shareInstance;

-(void)start;

-(void)cancel;

-(void)end;

@end

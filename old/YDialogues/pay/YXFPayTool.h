//
//  YXFPayTool.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YXFPayBlock)(id info,NSError *error);

@interface YXFPayTool : NSObject

+(instancetype)shareInstance;

-(void)buyProduct:(NSString *)productId success:(YXFPayBlock)success fail:(YXFPayBlock)fail;

@end

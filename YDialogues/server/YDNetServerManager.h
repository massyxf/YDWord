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

+(void)transTextWithUrl:(NSString *)url
                 params:(NSDictionary *)params
             completion:(YDTransCompletion)completion;

@end

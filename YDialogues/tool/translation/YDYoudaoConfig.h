//
//  YDYoudaoConfig.h
//  YDialogues
//
//  Created by yxf on 2017/8/21.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDYoudaoConfig : NSObject

/** id*/
@property(nonatomic,copy,readonly)NSString *youdaoId;

/** key*/
@property(nonatomic,copy,readonly)NSString *youdaokey;

/** host*/
@property(nonatomic,copy,readonly)NSString *youdaoHost;

+(instancetype)initForTrans:(BOOL)trans;

@end

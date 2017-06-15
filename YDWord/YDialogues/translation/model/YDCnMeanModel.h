//
//  YDCnMeanModel.h
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBaseModel.h"

@interface YDCnMeanModel : YDBaseModel

/** mean*/
@property(nonatomic,copy)NSString *word_mean;

/** has*/
@property(nonatomic,assign)BOOL has_mean;

/** split*/
@property(nonatomic,assign)NSInteger split;

@end

//
//  YDCommonModel.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBaseModel.h"

//note id 为初次建立这个的时间
//date id 为最新修改这个的时间
@interface YDCommonModel : YDBaseModel

/** id*/
@property(nonatomic,assign)NSInteger uniqId;

/** date id*/
@property(nonatomic,assign)NSInteger dateId;

@end

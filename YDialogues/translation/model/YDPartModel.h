//
//  YDPartModel.h
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBaseModel.h"

@class YDCnMeanModel;

@interface YDPartModel : YDBaseModel

@end

@interface YDEnPartModel : YDPartModel

/** part*/
@property(nonatomic,copy)NSString *part;

/** means*/
@property(nonatomic,strong)NSArray<NSString *> *means;

@end

@protocol YDCnMeanModel;

@interface YDCnPartModel : YDPartModel

/** part*/
@property(nonatomic,copy)NSString *part_name;

/** means*/
@property(nonatomic,strong)NSArray<YDCnMeanModel> *means;

@end

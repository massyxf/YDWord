//
//  YDJSCBWordModel.h
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBaseModel.h"

@class YDExchange;
@class YDEnSymbolModel;
@class YDCnSymbolModel;

@interface YDJSCBWordModel : YDBaseModel

/** 单词原型*/
@property(nonatomic,strong)NSString *word_name;

@end

@protocol YDEnSymbolModel;

@interface YDEnWordModel : YDJSCBWordModel

/** cri*/
@property(nonatomic,assign)BOOL is_CRI;

/** exchange*/
@property(nonatomic,strong)YDExchange *exchange;

/** symbols*/
@property(nonatomic,strong)NSArray <YDEnSymbolModel> *symbols;

@end

@protocol YDCnSymbolModel;

@interface YDCnWordModel : YDJSCBWordModel

/** symbols*/
@property(nonatomic,strong)NSArray <YDCnSymbolModel> *symbols;

@end


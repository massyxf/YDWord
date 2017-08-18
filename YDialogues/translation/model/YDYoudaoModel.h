//
//  YDYoudaoModel.h
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDCommonModel.h"

@protocol YDYoudaoWebModel;

@interface YDYoudaoModel : YDCommonModel

/** 原单词或句子*/
@property(nonatomic,copy)NSString *query;

/** 翻译结果*/
@property(nonatomic,strong)NSArray<NSString *> *translation;

//basic
/** 音标*/
@property(nonatomic,copy)NSString *phonetic;

//美式发音
@property(nonatomic,copy)NSString *usPhonetic;

//英式发音
@property(nonatomic,copy)NSString *ukPhonetic;

/** 解释*/
@property(nonatomic,strong)NSArray<NSString *> *explains;

/** 网络释义*/
@property(nonatomic,strong)NSArray<YDYoudaoWebModel> *web;

@end


@interface YDYoudaoWebModel : YDCommonModel

/** key*/
@property(nonatomic,copy)NSString *key;

/** value*/
@property(nonatomic,copy)NSArray<NSString *> *value;

@end


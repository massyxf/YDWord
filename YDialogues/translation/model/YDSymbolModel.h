//
//  YDSymbolModel.h
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBaseModel.h"

@class YDCnPartModel;
@class YDEnPartModel;

@interface YDSymbolModel : YDBaseModel

/** other*/
@property(nonatomic,copy)NSString *ph_other;

/** en_mp3*/
@property(nonatomic,copy)NSString *ph_en_mp3;

/** am_mp3*/
@property(nonatomic,copy)NSString *ph_am_mp3;

/** tts_mp3*/
@property(nonatomic,copy)NSString *ph_tts_mp3;

@end


@interface YDEnSymbolModel : YDSymbolModel

/** en*/
@property(nonatomic,copy)NSString *ph_en;

/** am*/
@property(nonatomic,copy)NSString *ph_am;

/** parts*/
@property(nonatomic,strong)NSArray<YDEnPartModel *> *parts;

@end


@interface YDCnSymbolModel : YDSymbolModel

/** parts*/
@property(nonatomic,strong)NSArray<YDCnPartModel *> *parts;

/** symbol*/
@property(nonatomic,copy)NSString *word_symbol;

/** mp3*/
@property(nonatomic,copy)NSString *symbol_mp3;

@end



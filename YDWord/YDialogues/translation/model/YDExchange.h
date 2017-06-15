//
//  YDExchange.h
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBaseModel.h"

@interface YDExchange : YDBaseModel

/** er*/
@property(nonatomic,copy)NSString *word_er;

/** est*/
@property(nonatomic,copy)NSString *word_est;

/** pl*/
@property(nonatomic,strong)NSArray *word_pl;

/** third*/
@property(nonatomic,strong)NSArray *word_third;

/** past*/
@property(nonatomic,strong)NSArray *word_past;

/** done*/
@property(nonatomic,strong)NSArray *word_done;

/** ing*/
@property(nonatomic,strong)NSArray *word_ing;

@end

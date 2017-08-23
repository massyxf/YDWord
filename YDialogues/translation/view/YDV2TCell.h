//
//  YDV2TCell.h
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YDV2TCellId @"YDV2TCellId"

@class YDV2TModel;

typedef void(^YDTapVoiceBlock)(YDV2TModel *v2tModel);

@interface YDV2TCell : UITableViewCell

/** 回调*/
@property(nonatomic,copy)YDTapVoiceBlock v2tBlock;

/** model*/
@property(nonatomic,strong)YDV2TModel *model;

-(CGFloat)heightWithModel:(YDV2TModel *)model;

@end

//
//  YDWordCell.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YDWordCellId @"YDWordCellId"

@class YDNoteWordModel;

@interface YDWordCell : UITableViewCell

/** word model*/
@property(nonatomic,strong)YDNoteWordModel *wordModel;

-(CGFloat)heightWithModel:(YDNoteWordModel *)model;

@end

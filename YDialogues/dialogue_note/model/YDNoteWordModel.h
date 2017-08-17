//
//  YDNoteWordModel.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDCommonModel.h"

@interface YDNoteWordModel : YDCommonModel

/** 标题*/
@property(nonatomic,copy)NSString *title;

/** 翻译*/
@property(nonatomic,copy)NSString *trans;

/** height*/
@property(nonatomic,assign)CGFloat height;

@end

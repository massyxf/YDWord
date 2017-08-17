//
//  YDDBTool+wordCache.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool.h"

@interface YDDBTool (wordCache)

+(BOOL)initialWordTable;

//增
-(BOOL)saveWords:(NSArray<YDNoteWordModel *> *)words inNote:(YDNoteModel *)note;

//查
-(NSArray<YDNoteWordModel *> *)selectWordsWithNote:(YDNoteModel *)note;

//删
-(BOOL)deleteWordModel:(YDNoteWordModel *)model;

//改
-(BOOL)alterWordModel:(YDNoteWordModel *)model;

@end


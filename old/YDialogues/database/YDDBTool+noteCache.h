//
//  YDDBTool+noteCache.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool.h"

@interface YDDBTool (noteCache)

+(BOOL)initialNoteTable;

+(BOOL)everSavedNote;

//增
-(BOOL)saveNote:(YDNoteModel *)note;

//查
-(NSArray<YDNoteModel *> *)selectNotes;

//改
-(BOOL)alterNote:(YDNoteModel *)model;

//删
-(BOOL)deleteNote:(YDNoteModel *)model;

@end

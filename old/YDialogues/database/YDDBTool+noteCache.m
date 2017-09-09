//
//  YDDBTool+noteCache.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool+noteCache.h"
#import <FMDB/FMDB.h>
#import "YDNoteModel.h"

@implementation YDDBTool (noteCache)

-(NSString *)noteTableName
{
    return @"note_table";
}

+(BOOL)everSavedNote{
    YDDBTool *tool = [YDDBTool shareInstance];
    return [tool tableExitDatas:tool.noteTableName];
}

+(BOOL)initialNoteTable{
    YDDBTool *tool = [YDDBTool shareInstance];
    NSString *sql = [NSString stringWithFormat:@"%@(title char(100), date char(20),dateId integer,uniqId integer primary key);",tool.noteTableName];
    return [tool createTable:sql];
}

-(BOOL)saveNote:(YDNoteModel *)note{
    FMDatabase *db = self.fmdb;
    BOOL success = [db executeUpdate:@"INSERT INTO note_table(title,date,dateId,uniqId) values (?,?,?,?);" values:@[note.title,note.date,@(note.dateId),@(note.uniqId)] error:nil];
    if (!success) {
        NSLog(@"save note error:%@",note);
    }
    return success;
}

-(NSArray<YDNoteModel *> *)selectNotes{
    NSMutableArray *notesArray = [NSMutableArray array];
    if ([self.fmdb open]) {
        FMResultSet *set = [self.fmdb executeQuery:@"select * from note_table;"];
        while ([set next]) {
            YDNoteModel *model = [[YDNoteModel alloc] init];
            model.title = [set stringForColumn:@"title"];
            model.date = [set stringForColumn:@"date"];
            model.dateId = [set intForColumn:@"dateId"];
            model.uniqId = [set intForColumn:@"uniqId"];
            [notesArray addObject:model];
        }
        [self.fmdb close];
    }
    
    return notesArray;
}

//改
-(BOOL)alterNote:(YDNoteModel *)model{
    if ([self.fmdb open]) {
        BOOL success = [self.fmdb executeUpdate:@"update note_table set title = ?,date = ?, dateId = ? where uniqId = ?;",model.title,model.date,model.dateId,model.uniqId];
        [self.fmdb close];
        return success;
    }
    return NO;
}

//删
-(BOOL)deleteNote:(YDNoteModel *)model{
    
    if ([self.fmdb open]) {
        BOOL success = [self.fmdb executeUpdate:@"delete * from note_table where uniqId = ?;",model.uniqId];
        [self.fmdb close];
        return success;
    }
    
    return NO;
}

@end

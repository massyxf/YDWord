//
//  YDDBTool+wordCache.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool+wordCache.h"
#import <FMDB/FMDB.h>
#import "YDNoteModel.h"
#import "YDNoteWordModel.h"

@implementation YDDBTool (wordCache)

-(NSString *)wordTableName
{
    return @"word_table";
}

+(BOOL)initialWordTable{
    YDDBTool *tool = [YDDBTool shareInstance];
    NSString *wordTable = [NSString stringWithFormat:@"%@(title char(100), trans char(100),height double,dateId integer,uniqId integer primary key,noteId integer);",tool.wordTableName];
    return [tool createTable:wordTable];
}

-(void)saveWords:(NSArray<YDNoteWordModel *> *)words inNote:(YDNoteModel *)note{
    FMDatabase *db = self.fmdb;
    if ([db open]) {
        for (YDNoteWordModel *model in words) {
            BOOL success = [db executeUpdate:@"INSERT INTO word_table(title,trans,height,dateId,uniqId,noteId) values (?,?,?,?,?,?);",model.title,model.trans,model.height,model.dateId,model.uniqId,note.uniqId];
            if (!success) {
                NSLog(@"save word error:%@",model);
                break;
            }
        }
        [db close];
    }
}

-(NSArray<YDNoteWordModel *> *)selectWordsWithNote:(YDNoteModel *)note{
    NSMutableArray *wordsArray = [NSMutableArray array];
    FMDatabase *db = self.fmdb;
    if ([db open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ where noteId = ?;",self.wordTableName];
        FMResultSet *set = [db executeQuery:sqlStr,note.uniqId];
        while ([set next]) {
            YDNoteWordModel *model = [[YDNoteWordModel alloc] init];
            model.title = [set stringForColumn:@"title"];
            model.trans = [set stringForColumn:@"trans"];
            model.height = [set doubleForColumn:@"height"];
            model.uniqId = [set intForColumn:@"uniqId"];
            model.dateId = [set intForColumn:@"dateId"];
            [wordsArray addObject:model];
        }
        [db close];
    }
    return wordsArray;
}

-(BOOL)deleteWordModel:(YDNoteWordModel *)model{
    if ([self.fmdb open]) {
        BOOL success = [self.fmdb executeUpdate:@"delete * from word_table where uniqId = ?;",model.uniqId];
        [self.fmdb close];
        return success;
    }
    return NO;
}

//改
-(BOOL)alterWordModel:(YDNoteWordModel *)model{
    if ([self.fmdb open]) {
//        title,trans,height,dateId,uniqId,noteId
        BOOL success = [self.fmdb executeUpdate:@"update word_table set title = ?,trans = ?,height = ?, dateId = ? where uniqId = ?;",model.title,model.trans,model.height,model.dateId,model.uniqId];
        [self.fmdb close];
        return success;
    }
    return NO;
}

@end

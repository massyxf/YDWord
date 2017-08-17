//
//  YDDBTool.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool.h"
#import <FMDB/FMDB.h>
#import "NSString+FilePath.h"
#import "NSString+YDHandle.h"
#import "YDDBTool+noteCache.h"
#import "YDDBTool+wordCache.h"
#import "YDDBTool+transCache.h"

#import "YDNoteWordModel.h"
#import "YDNoteModel.h"

#define DialogueDB @"DialogueDB"

@interface YDDBTool ()

/** db*/
@property(nonatomic,strong)FMDatabase *fmdb;

/** word count*/
@property(nonatomic,assign)NSInteger count;

/** lock*/
@property(nonatomic,strong)NSLock *lock;

@end

@implementation YDDBTool

+(instancetype)shareInstance
{
    static YDDBTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YDDBTool alloc] init];
    });
    return tool;
}

+(void)dbInitial{
    YDDBTool *tool = [self shareInstance];
    
    //单词本
    BOOL createNoteTable = [YDDBTool initialNoteTable];
    
    //单词
    BOOL createWordTable = [YDDBTool initialWordTable];
    
    BOOL createSuccess = !createNoteTable || !createWordTable;
    if (createSuccess && [tool.delegate respondsToSelector:@selector(dbInitialFailed)]) {
        [tool.delegate dbInitialFailed];
    }
}

#pragma mark - public func
-(BOOL)tableExitDatas:(NSString *)tableName{
    FMDatabase *db = self.fmdb;
    BOOL noteSaved = NO;
    if ([db open]) {
        NSString *selectFromNote = [NSString stringWithFormat:@"select * from %@;",tableName];
        FMResultSet *set = [db executeQuery:selectFromNote];
        noteSaved = [set next];
        [db close];
    }
    return noteSaved;
}

-(BOOL)createTable:(NSString *)tabeleDes{
    if ([self.fmdb open]) {
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists %@;",tabeleDes];
        BOOL success = [self.fmdb executeStatements:createTable];
        [self.fmdb close];
        return success;
    }
    return NO;
}


#pragma mark - getter
-(FMDatabase *)fmdb{
    if (!_fmdb) {
        NSString *docPath = [NSString docDirectory];
        NSString *dbPath = [docPath stringByAppendingPathComponent:DialogueDB];
        _fmdb = [FMDatabase databaseWithPath:dbPath];
    }
    return _fmdb;
}

-(NSLock *)lock{
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

@end

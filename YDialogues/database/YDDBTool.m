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
#import "YDJSCBWordModel.h"

#define DialogueDB @"DialogueDB"
#define YCnWordTable @"YCnWordTable"

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

//保存中文单词
+(void)saveCnWord:(YDCnWordModel *)word
{
    YDDBTool *tool = [YDDBTool shareInstance];
    FMDatabase *db = tool.fmdb;
    if ([db open])
    {
        NSString *create_word_count = @"create table if not exist word_count(word_id integer);";
        //创建记录单词数量的表
        if ([db executeStatements:create_word_count]) {
            NSLog(@"create_word_count");
            FMResultSet *set = [db executeQuery:@"select * from word_count"];
            while ([set next]) {
                tool.count = [set intForColumnIndex:0];
                break;
            }
        }
        
        //创建单词表
        NSString *create_table_word = [NSString stringWithFormat:@"create table if not exist %@(word_name char(50) not null primary key,word_id integer);",YCnWordTable];
        if ([db executeStatements:create_table_word]) {
            NSLog(@"create_table_word");
            
            //插入单词
            if ([db executeUpdate:@"INSERT INTO %@ (word_name,word_id) values (?,?)",YCnWordTable,word.word_name,@(tool.count + 1)]) {
                NSLog(@"INSERT INTO table_word");
                [tool.lock lock];
                tool.count ++;
                [tool.lock unlock];
            }
        }
    }
}

//保存英文单词
+(void)saveEnWord:(YDEnWordModel *)word{

}

@end

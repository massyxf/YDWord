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
#import "YDSymbolModel.h"
#import "YDPartModel.h"

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

#pragma mark - custom func
//创建记录单词数量的表
+(BOOL)createWordCountTableWithDB:(YDDBTool *)tool
{
    FMDatabase *db = tool.fmdb;
    if ([db open])
    {
        NSString *create_word_count = @"create table if not exists word_count(word_id integer);";
        BOOL success = [db executeStatements:create_word_count];
        if (success)
        {
            NSLog(@"create_word_count");
            FMResultSet *set = [db executeQuery:@"select * from word_count"];
            while ([set next]) {
                tool.count = [set intForColumnIndex:0];
                break;
            }
        }
        return success;
    }
    return NO;;
}

//创建单词表
+(BOOL)createWordTableWithDB:(YDDBTool *)tool
{
    FMDatabase *db = tool.fmdb;
    NSString *create_table_word = @"create table if not exists cn_word_table (word_name char(50) not null primary key,word_id integer);";
    BOOL success = [db executeStatements:create_table_word];
    if (success) {
        NSLog(@"create_table_word");
    }
    return success;
}

//保存单词
+(BOOL)saveWord:(YDJSCBWordModel *)word withTool:(YDDBTool *)tool
{
    FMDatabase *db = tool.fmdb;
    if ([db open])
    {
        if ([self createWordCountTableWithDB:tool])
        {
            if ([self createWordTableWithDB:tool])
            {
                if ([self hasSaveWord:word withTool:tool]) {
                    return YES;
                }
                //插入单词
                return [db executeUpdate:@"INSERT INTO cn_word_table(word_name,word_id) values (?,?);",word.word_name,@(tool.count + 1)];
            }
        }
    }
    return NO;
}

+(BOOL)hasSaveWord:(YDJSCBWordModel *)word withTool:(YDDBTool *)tool{
    FMResultSet *set = [tool.fmdb executeQuery:@"select * from cn_word_table where word_name = ?",word.word_name];
    return set.next;
}

#pragma mark - public func
//保存中文单词
+(void)saveCnWord:(YDCnWordModel *)word
{
    YDDBTool *tool = [YDDBTool shareInstance];
    BOOL success = [self saveWord:word withTool:tool];
    
    //创建中文单词symbol表
    NSString *create_table_cnSymbol = @"create table if not exists cnSymbol_table (word_id integer,word_index integer,word_symbol char(50),symbol_mp3 char(50),ph_other char(50),ph_en_mp3 char(50),ph_am_mp3 char(50),ph_tts_mp3 char(50),primary key(word_id,word_index));";
    BOOL cnSymbolSuccess = [tool.fmdb executeStatements:create_table_cnSymbol];
    
    NSInteger index = tool.count + 1;
    if (success && cnSymbolSuccess) {
        
        for (int i=0; i<word.symbols.count; i++) {
            YDCnSymbolModel *model = word.symbols[i];
            
            //存symbols
            //查看有没有存过
            FMResultSet *set = [tool.fmdb executeQuery:@"select * from cnSymbol_table where word_id = ? and word_index = ?",@(index),@(i)];
            if (set.next) continue;
            
            //存symbols
            BOOL alterSuccess = [tool.fmdb executeUpdate:@"INSERT INTO cnSymbol_table(word_id,word_index,word_symbol,symbol_mp3,ph_other,ph_en_mp3,ph_am_mp3,ph_tts_mp3) values (?,?,?,?,?,?,?,?);",@(index),@(i),model.word_symbol,model.symbol_mp3,model.ph_other,model.ph_en_mp3,model.ph_am_mp3,model.ph_tts_mp3];
            if (!alterSuccess) break;
            
            //存symbol的parts
            BOOL partsExist = [tool.fmdb executeStatements:@"create table if not exists cn_part_table(word_index integer,symbol_index integer,part_index integer,part_name char(50),primary key(word_index,symbol_index,part_index));"];
            if (partsExist) {
                for (int partIndex = 0; partIndex < model.parts.count; partIndex++) {
                    FMResultSet *partSet = [tool.fmdb executeQuery:@"select * from cn_part_table where word_index = ? and symbol_index = ? and part_index = ?",@(index),@(i),@(partIndex)];
                    if (partSet.next) continue;
                    
                    YDCnPartModel *partModel = model.parts[partIndex];
                    //存 parts
                    BOOL partSuccess = [tool.fmdb executeUpdate:@"INSERT INTO cn_part_table(word_index ,symbol_index ,part_index ,part_name) values (?,?,?,?);",@(index),@(i),@(partIndex),partModel.part_name];
                    if (!partSuccess) break;
                }
                
            }
            
        }
    }
    
}

//保存英文单词
+(void)saveEnWord:(YDEnWordModel *)word{
    YDDBTool *tool = [YDDBTool shareInstance];
    BOOL success = [self saveWord:word withTool:tool];
    if (success) {
        
    }
}

@end

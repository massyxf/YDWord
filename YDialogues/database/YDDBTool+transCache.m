//
//  YDDBTool+transCache.m
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDDBTool+transCache.h"
#import "YDYoudaoModel.h"
#import <FMDB/FMDB.h>

#define YDDisTag @"yßX†f"

@implementation YDDBTool (transCache)

//query;
//
///** 翻译结果*/
//@property(nonatomic,strong)NSArray *translation;
//
////basic
///** 音标*/
//@property(nonatomic,copy)NSString *phonetic;
//
////美式发音
//@property(nonatomic,copy)NSString *usPhonetic;
//
////英式发音
//@property(nonatomic,copy)NSString *ukPhonetic;
//
///** 解释*/
//@property(nonatomic,strong)NSArray *explains;
//
///** 网络释义*/
//@property(nonatomic,strong)NSArray<YDYoudaoWebModel> *web;

+(BOOL)initialTransTable{
    YDDBTool *tool = [YDDBTool shareInstance];
    NSString *youdaoTable = [NSString stringWithFormat:@"%@(query char(128),translation char(512),phonetic char(128),usPhonetic char(128),ukPhonetic char(128),explains char(512),uniqId integer primary key)",tool.youdaoTable];
    BOOL createYoudaoTable = [tool createTable:youdaoTable];
    
    NSString *youdaoWebTable = [NSString stringWithFormat:@"youdao_web_table(key char(128),value char(512),uniqId integer primary key);"];
    BOOL createYoudaoWebTable = [tool createTable:youdaoWebTable];
    
    return createYoudaoTable && createYoudaoWebTable;
}

+(BOOL)saveYoudaoModel:(YDYoudaoModel *)model{
    YDDBTool *tool = [YDDBTool shareInstance];
    if ([tool.fmdb open]) {
//        FMResultSet *result = [tool.fmdb executeQuery:@"select * from youdao_table;"];
//        if ([result next]) {//已存
//            
//        }
        [tool.fmdb beginTransaction];
        NSString *transition = [tool appendStringWithArray:model.translation];
        
        NSString *explains = [tool appendStringWithArray:model.explains];
        BOOL writeBasic = [tool.fmdb executeUpdate:@"insert into youdao_table(query,translation,phonetic,usPhonetic ,ukPhonetic,explains,uniqId) values (?,?,?,?,?,?);",model.query,transition,model.phonetic,model.usPhonetic,model.ukPhonetic,explains,@(model.uniqId)];
        if (!writeBasic) {
            [tool.fmdb rollback];
            return NO;
        }
        
        __block BOOL success = YES;
        [model.web enumerateObjectsUsingBlock:^(YDYoudaoWebModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *values = [tool appendStringWithArray:obj.value];
            
            BOOL writeBasic = [tool.fmdb executeUpdate:@"insert into youdao_web_table(key,value,uniqId) values (?,?,?);",obj.key,values,@(obj.uniqId)];
            if (!writeBasic) {
                success = NO;
                *stop = YES;
            }
        }];
        
        if (!success) {
            [tool.fmdb rollback];
            [tool.fmdb close];
            return NO;
        }
        
        BOOL resultSuccess = [tool.fmdb commit];
        [tool.fmdb close];
        return resultSuccess;
    }
    return NO;
}

#pragma mark - custom func

-(NSString *)youdaoTable{
    return @"youdao_table";
}

-(NSString *)youdaoWebTable{
    return @"youdao_web_table";
}

-(NSString *)appendStringWithArray:(NSArray<NSString *> *)strings{
    NSMutableString *explains = [NSMutableString string];
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [explains appendString:obj];
        if (idx < strings.count - 1) {
            [explains appendString:YDDisTag];
        }
    }];
    return explains;
}

@end

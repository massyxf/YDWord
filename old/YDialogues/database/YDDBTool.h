//
//  YDDBTool.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class YDNoteWordModel;
@class YDNoteModel;

@protocol YDDBToolDelegate <NSObject>

-(void)dbInitialFailed;

@end

@interface YDDBTool : NSObject

/** db*/
@property(nonatomic,strong,readonly)FMDatabase *fmdb;

/** delegate*/
@property(nonatomic,weak)id<YDDBToolDelegate> delegate;

+(instancetype)shareInstance;

+(void)dbInitial;

-(BOOL)tableExitDatas:(NSString *)tableName;

-(BOOL)createTable:(NSString *)tabeleDes;

@end

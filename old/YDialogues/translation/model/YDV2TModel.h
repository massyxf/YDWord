//
//  YDV2TModel.h
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDV2TModel : NSObject

/** height*/
@property(nonatomic,assign)CGFloat height;

/** text*/
@property(nonatomic,copy)NSString *text;

/** trans text*/
@property(nonatomic,copy)NSString *transText;

/** origin voice url*/
@property(nonatomic,copy)NSString *originVoicePath;

@end

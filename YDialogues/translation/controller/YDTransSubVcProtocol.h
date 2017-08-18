//
//  YDTransSubVcProtocol.h
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YDTransSubVcProtocol <NSObject>

-(NSString *)bindBtnTitle;

-(NSInteger)bindBtnTag;

-(void)transText:(NSString *)text;

@end

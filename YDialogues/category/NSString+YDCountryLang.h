//
//  NSString+YDCountryLang.h
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YDCountryLang)

+(NSString *)languageWithId:(NSInteger)langId;

+(NSString *)countryWithId:(NSInteger)countryId;

+(NSString *)countryImgWithId:(NSInteger)countryId;

@end

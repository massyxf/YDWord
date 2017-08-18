//
//  YDYoudaoModel.m
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDYoudaoModel.h"

@implementation YDYoudaoModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"usPhonetic":@"basic.us-phonetic",
                                                                  @"ukPhonetic":@"basic.uk-phonetic",
                                                                  @"explains":@"basic.explains"
                                                                  }];
}

@end

@implementation YDYoudaoWebModel



@end

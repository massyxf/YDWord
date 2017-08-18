//
//  YDYinghanViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDYinghanViewController.h"
#import "YDYoudaoTransTool.h"

@interface YDYinghanViewController ()

@end

@implementation YDYinghanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YDTransSubVcProtocol
-(NSString *)bindBtnTitle{
    return @"英汉词典";
}

-(NSInteger)bindBtnTag{
    return YDTransTag;
}

-(void)transText:(NSString *)text{
    [YDYoudaoTransTool transText:text
                            from:YDYoudaoTransLangTypeZh
                              to:YDYoudaoTransLangTypeEn
                        complete:^(id result, NSError *error) {
                            
                        }];
}

@end

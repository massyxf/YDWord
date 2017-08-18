//
//  YDChengyuViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDChengyuViewController.h"

@interface YDChengyuViewController ()

@end

@implementation YDChengyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YDTransSubVcProtocol
-(NSString *)bindBtnTitle{
    return @"成语词典";
}

-(NSInteger)bindBtnTag{
    return YDTransTag + 2;
}

-(void)transText:(NSString *)text{
    
}

@end

//
//  YDXinhuaViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDXinhuaViewController.h"

@interface YDXinhuaViewController ()

@end

@implementation YDXinhuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YDTransSubVcProtocol
-(NSString *)bindBtnTitle{
    return @"新华字典";
}

-(NSInteger)bindBtnTag{
    return YDTransTag + 1;
}

-(void)transText:(NSString *)text{
    
}

@end

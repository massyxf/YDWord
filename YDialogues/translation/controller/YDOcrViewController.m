//
//  YDOcrViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/21.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDOcrViewController.h"
#import "YDOcrTool.h"

@interface YDOcrViewController ()

@end

@implementation YDOcrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *transBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:transBtn];
    transBtn.frame = CGRectMake(50, 50, 50, 50);
    [transBtn setTitle:@"trans pic" forState:UIControlStateNormal];
    [transBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [transBtn addTarget:self action:@selector(transImg:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(IBAction)transImg:(id)sender{
    UIImage *img = [UIImage imageNamed:@"1"];
    [YDOcrTool transPic:img completion:^(id result, NSError *error) {
        
    }];
}


@end

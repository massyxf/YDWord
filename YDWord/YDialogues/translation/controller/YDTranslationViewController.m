//
//  YDTranslationViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTranslationViewController.h"
#import "YDNetServerManager.h"

@interface YDTranslationViewController ()

@end

@implementation YDTranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YDNetServerManager getWords:@"他们"
                         success:^(id obj) {
                             
                         } fail:^(NSError *error) {
                             
                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

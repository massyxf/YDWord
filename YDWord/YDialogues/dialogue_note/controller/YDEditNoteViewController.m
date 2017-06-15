//
//  YDEditNoteViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDEditNoteViewController.h"
#import "YDAddDialogueViewController.h"

@interface YDEditNoteViewController ()

@end

@implementation YDEditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"edit";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addWord:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
-(IBAction)addWord:(id)sender
{
    YDAddDialogueViewController *addVc = [[YDAddDialogueViewController alloc] init];
    UINavigationController *naviVc = [[UINavigationController alloc] initWithRootViewController:addVc];
    [self.navigationController presentViewController:naviVc animated:YES completion:nil];
}

@end

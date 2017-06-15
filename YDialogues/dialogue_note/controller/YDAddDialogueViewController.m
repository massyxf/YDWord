//
//  YDAddDialogueViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDAddDialogueViewController.h"


@interface YDAddDialogueViewController ()<UITextViewDelegate,UITextFieldDelegate>

/** 英文单词*/
@property(nonatomic,weak)UITextField *wordTextField;

/** 单词翻译*/
@property(nonatomic,weak)UITextField *transTextField;

/** 例句*/
@property(nonatomic,weak)UITextView *examSentenceView;

@end

@implementation YDAddDialogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"edit";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(closeVc:)];
    
    CGFloat naviheight = 64;
    CGRect wordFrame = CGRectMake(5, 10 + naviheight, SCREENWIDTH - 10, 30);
    UITextField *wordField = [[UITextField alloc] initWithFrame:wordFrame];
    wordField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wordField];
    
    CGRect transFrame = CGRectMake(5, 60 + naviheight, SCREENWIDTH - 10, 30);
    UITextField *transField = [[UITextField alloc] initWithFrame:transFrame];
    transField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:transField];
    
    CGRect textFrame = CGRectMake(5, 100 + naviheight, SCREENWIDTH - 10, SCREENHEIGHT - 120 - naviheight);
    UITextView *textView = [[UITextView alloc] initWithFrame:textFrame];
    [self.view addSubview:textView];
}

-(IBAction)closeVc:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end

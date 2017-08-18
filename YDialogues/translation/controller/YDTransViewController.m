//
//  YDTransViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTransViewController.h"
#import <Masonry/Masonry.h>
#import "YDNetServerManager.h"

@interface YDTransViewController ()<UITextFieldDelegate>

/*word*/
@property (nonatomic,weak)UITextField *wordTextField;

/** 翻译*/
@property(nonatomic,weak)UILabel *transLabel;

/** 翻译的滚动视图*/
@property(nonatomic,weak)UIScrollView *transScrollView;

@end

@implementation YDTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:searchBtn];
    [searchBtn addTarget:self
                  action:@selector(search:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.returnKeyType = UIReturnKeyGo;
    textField.delegate = self;
    textField.backgroundColor = [UIColor orangeColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.placeholder = @"请输入要查找的单词或成语";
    self.wordTextField = textField;
    
    UIScrollView *transScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:transScrollView];
    _transScrollView = transScrollView;
    transScrollView.backgroundColor = [UIColor greenColor];
    
    UILabel *transLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor] numberOfLines:0];
    [transScrollView addSubview:transLabel];
    _transLabel = transLabel;
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.trailing.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(10);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchBtn);
        make.leading.mas_equalTo(self.view).offset(10);
        make.trailing.equalTo(searchBtn.mas_leading).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    [transScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.mas_bottom).offset(10);
        make.leading.mas_equalTo(textField);
        make.trailing.mas_equalTo(searchBtn);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(transScrollView);
    }];
    
}

#pragma mark - action

-(IBAction)search:(id)sender{
    [self transText:self.wordTextField.text];
}

#pragma mark - custom func

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self transText:self.wordTextField.text];
    return YES;
}

#pragma mark - YDTransSubVcProtocol
-(NSString *)bindBtnTitle{
    return nil;
}

-(NSInteger)bindBtnTag{
    return 0;
}

-(void)transText:(NSString *)text{}

@end

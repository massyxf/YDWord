//
//  YDTranslationViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTranslationViewController.h"
#import <Masonry/Masonry.h>
#import "YDNetServerManager.h"

@interface YDTranslationViewController ()<UITextFieldDelegate>

/*word*/
@property (nonatomic,weak)UITextField *wordTextField;

@end

@implementation YDTranslationViewController

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
    self.wordTextField = textField;
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.trailing.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(10 + YDNaviHeight);
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchBtn);
        make.leading.mas_equalTo(self.view).offset(10);
        make.trailing.equalTo(searchBtn.mas_leading).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    
}

-(IBAction)search:(id)sender{
    [self translation];
}

#pragma mark - custom func
-(void)translation
{
    [YDNetServerManager getWords:self.wordTextField.text
                         success:^(id obj) {
                             NSLog(@"%@",obj);
                         } fail:^(NSError *error) {
                             NSLog(@"%@",error);
                         }];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self translation];
    return YES;
}


@end

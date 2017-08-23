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
#import "YDYoudaoTransTool.h"
#import "YDYoudaoModel.h"

@interface YDTransViewController ()<UITextViewDelegate>

/*word*/
@property (nonatomic,weak)UITextView *wordTextView;

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
    
    UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
    textView.returnKeyType = UIReturnKeyGo;
    textView.delegate = self;
    textView.backgroundColor = [UIColor orangeColor];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    textView.placeholder = @"请输入要查找的单词或成语";
    self.wordTextView = textView;
    
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
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchBtn);
        make.leading.mas_equalTo(self.view).offset(10);
        make.trailing.equalTo(searchBtn.mas_leading).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    [transScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.mas_bottom).offset(10);
        make.leading.mas_equalTo(textView);
        make.width.mas_equalTo(SCREENWIDTH - 20);
        make.bottom.mas_equalTo(self.view).offset(-10);
    }];
    
    [transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.width.mas_equalTo(transScrollView);
    }];
    
}

#pragma mark - action

-(IBAction)search:(id)sender{
    [self.wordTextView resignFirstResponder];
    [self transText:self.wordTextView.text];
}

#pragma mark - custom func

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text containsString:@"\n"]) {
       [self transText:textView.text];
    }
}

#pragma mark - custom func
-(void)phonetics:(NSMutableString *)phonetics appendStr:(NSString *)subStr{
    if (subStr.length > 0) {
        [phonetics appendString:subStr];
        [phonetics appendString:@"  "];
    }
}
-(void)transText:(NSString *)text{
    __weak typeof(self) weakSelf = self;
    [YDYoudaoTransTool transText:text
                            from:YDYoudaoTransLangTypeZh
                              to:YDYoudaoTransLangTypeEn
                        complete:^(YDYoudaoModel *result, NSError *error) {
                            if (result) {
                                NSMutableAttributedString *trans = [[NSMutableAttributedString alloc] init];
                                
                                NSMutableString *transitons = [NSMutableString string];
                                [result.translation enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    [transitons appendString:obj];
                                    if (idx < result.translation.count - 1) {
                                        [transitons appendString:@","];
                                    }else{
                                        [transitons appendString:@"\n"];
                                    }
                                }];
                                NSAttributedString *transResult = [[NSAttributedString alloc] initWithString:transitons];
                                [trans appendAttributedString:transResult];
                                
                                NSMutableAttributedString *basicTrans = [[NSMutableAttributedString alloc] init];
                                NSMutableString *phoneStr = [NSMutableString string];
                                [self phonetics:phoneStr appendStr:result.phonetic];
                                
                                [self phonetics:phoneStr appendStr:result.usPhonetic];
                                
                                [self phonetics:phoneStr appendStr:result.ukPhonetic];
                                
                                if (phoneStr.length > 0) {
                                    [phoneStr appendString:@"\n"];
                                }
                                
                                NSAttributedString *phonetics = [[NSAttributedString alloc] initWithString:phoneStr attributes:nil];
                                [basicTrans appendAttributedString:phonetics];
                                
                                [trans appendAttributedString:basicTrans];
                                
                                NSMutableString *webStr = [NSMutableString string];
                                [result.web enumerateObjectsUsingBlock:^(YDYoudaoWebModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    [webStr appendFormat:@"%@:",obj.key];
                                    [obj.value enumerateObjectsUsingBlock:^(NSString * _Nonnull value, NSUInteger subidx, BOOL * _Nonnull stop) {
                                        [webStr appendString:value];
                                        if (subidx < obj.value.count - 1) {
                                            [webStr appendString:@","];
                                        }
                                    }];
                                    [webStr appendString:@"\n"];
                                }];
                                NSAttributedString *webAtt = [[NSAttributedString alloc] initWithString:webStr];
                                [trans appendAttributedString:webAtt];
                                
                                weakSelf.transLabel.attributedText = trans;
                                [weakSelf.transLabel sizeToFit];
                                
                                weakSelf.transScrollView.contentSize = CGSizeMake(0, CGRectGetHeight(weakSelf.transLabel.frame));
                            }
                        }];
}

#pragma mark - YDTransSubVcProtocol

-(NSString *)bindBtnTitle{return @"翻译";}

-(NSInteger)bindBtnTag{return YDTransTag + 0;}

@end

//
//  YDGameViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDGameViewController.h"
#import <Masonry/Masonry.h>

@interface YDGameViewController ()

/** 游戏背景图片*/
@property(nonatomic,weak)UIImageView *bgImageView;

/** 分数*/
@property(nonatomic,weak)UILabel *scoreLabel;

/** 暂停按钮*/
@property(nonatomic,weak)UIButton *pauseBtn;

/** 汉字*/
@property(nonatomic,weak)UILabel *transLabel;


@end

@implementation YDGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [self.view addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    UILabel *scoreLabel = [[UILabel alloc] init];
    [self.view addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    scoreLabel.text = @"score";
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pauseButton];
    self.pauseBtn = pauseButton;
    [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
    [pauseButton addTarget:self
                    action:@selector(pauseBtnClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *transLabel = [[UILabel alloc] init];
    [self.view addSubview:transLabel];
    self.transLabel = transLabel;
    transLabel.text = @"translate";
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startBtn];
    [startBtn addTarget:self
                 action:@selector(startGame:)
       forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(YDNaviHeight);
        make.bottom.mas_equalTo(self.view).offset(-YDTabbarHeight);
    }];
    
    CGFloat scoreWidth = 100;
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(5);
        make.width.mas_equalTo(scoreWidth);
        make.top.mas_equalTo(self.view).offset(5 + YDNaviHeight);
        make.height.mas_equalTo(20);
    }];
    
    [pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10 + YDNaviHeight);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.trailing.mas_equalTo(self.view).offset(-10);
    }];
    
    [transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(scoreLabel.mas_trailing).offset(5);
        make.trailing.equalTo(pauseButton.mas_leading).offset(-5);
        make.top.mas_equalTo(scoreLabel);
        make.height.mas_equalTo(25);
    }];
    
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.center.mas_equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - action
-(IBAction)pauseBtnClicked:(id)sender{

}

-(IBAction)startGame:(UIButton *)sender{
    sender.hidden = YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

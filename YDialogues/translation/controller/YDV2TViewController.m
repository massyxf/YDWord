//
//  YDV2TViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDV2TViewController.h"
#import "YDV2TCell.h"
#import "YDV2TModel.h"
#import "YDV2TTool.h"
#import "YDTransBottomView.h"
#import "YDLangView.h"
#import "YDLanguagesViewController.h"
#import "YDHud.h"

#define YDBottomViewHeight 120

@interface YDV2TViewController ()<UITableViewDelegate,UITableViewDataSource,YDLangViewDelegate>

/** table */
@property(nonatomic,weak)UITableView *transTableView;

/** data*/
@property(nonatomic,strong)NSMutableArray<YDV2TModel *> *datas;

@end

@implementation YDV2TViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    YDTransBottomView *bottomView = [[YDTransBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - YDBottomViewHeight, SCREENWIDTH, YDBottomViewHeight)];
    [self.view addSubview:bottomView];
    bottomView.leftView.delegate = self;
    bottomView.rightView.delegate = self;
    
    UITableView *transView = [[UITableView alloc] initWithFrame:CGRectMake(0, YDNaviHeight, SCREENWIDTH, CGRectGetMinY(bottomView.frame) - YDNaviHeight) style:UITableViewStylePlain];
    [self.view addSubview:transView];
    transView.delegate = self;
    transView.dataSource = self;
    [transView registerClass:[YDV2TCell class] forCellReuseIdentifier:YDV2TCellId];
    [transView setTableFooterView:[[UIView alloc] init]];
    _transTableView = transView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(selectLanguages:)];
}

#pragma mark - getter
-(NSMutableArray<YDV2TModel *> *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
#pragma mark - delegate
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDV2TCell *cell = [tableView dequeueReusableCellWithIdentifier:YDV2TCellId forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _datas[indexPath.row].height;
    if (height <= 0) {
        YDV2TCell *cell = [[YDV2TCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDV2TCellId];
        height = [cell heightWithModel:_datas[indexPath.row]];
    }
    return height;
}

#pragma mark - YDLangViewDelegate
-(void)langViewChangeCountry:(YDLangView *)langView{
    YDLogFunc;
}

-(void)langViewSendMsg:(YDLangView *)langView{
    YDLogFunc;
}

#pragma mark - action
-(IBAction)selectLanguages:(id)sender{
//    YDLanguagesViewController *langVc = [[YDLanguagesViewController alloc] init];
//    UINavigationController *naviVc = [[UINavigationController alloc] initWithRootViewController:langVc];
//    [self presentViewController:naviVc animated:YES completion:nil];
    [YDHubWindow hudwindowShow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YDHubWindow hudwindowHide];
    });
}

@end

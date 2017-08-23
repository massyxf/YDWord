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

@interface YDV2TViewController ()<UITableViewDelegate,UITableViewDataSource>

/** table */
@property(nonatomic,weak)UITableView *transTableView;

/** data*/
@property(nonatomic,strong)NSMutableArray<YDV2TModel *> *datas;

@end

@implementation YDV2TViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *transView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:transView];
    transView.delegate = self;
    transView.dataSource = self;
    [transView registerClass:[YDV2TCell class] forCellReuseIdentifier:YDV2TCellId];
    _transTableView = transView;
}

#pragma mark - getter
-(NSMutableArray<YDV2TModel *> *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

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

#pragma mark - YDTransSubVcProtocol
-(NSString *)bindBtnTitle{
    return @"对话面对面";
}

-(NSInteger)bindBtnTag{
    return YDTransTag + 1;
}

@end

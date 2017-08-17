//
//  YDEditNoteViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDEditNoteViewController.h"
#import "YDAddDialogueViewController.h"
#import "YDEditNoteFootView.h"
#import "YDEditNoteHeadView.h"
#import "YDWordCell.h"
#import "YDNoteWordModel.h"

@interface YDEditNoteViewController ()<UITableViewDelegate,UITableViewDataSource,YDEditNoteFootViewDelegate>

/** table*/
@property(nonatomic,weak)UITableView *wordTableView;

/** data*/
@property(nonatomic,strong)NSMutableArray *wordsArray;

@end

@implementation YDEditNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"edit";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(addWord:)];
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    _wordTableView = tableview;
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerClass:[YDWordCell class] forCellReuseIdentifier:YDWordCellId];
    
    YDEditNoteFootView *footview = [[YDEditNoteFootView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    footview.delegate = self;
    [tableview setTableFooterView:footview];
    
    YDEditNoteHeadView *headView = [[YDEditNoteHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    [tableview setTableHeaderView:headView];
}

#pragma mark - getter
-(NSMutableArray *)wordsArray{
    if (!_wordsArray) {
        _wordsArray = [NSMutableArray array];
    }
    return _wordsArray;
}

#pragma mark - action
-(IBAction)addWord:(id)sender
{
    YDAddDialogueViewController *addVc = [[YDAddDialogueViewController alloc] init];
    UINavigationController *naviVc = [[UINavigationController alloc] initWithRootViewController:addVc];
    [self.navigationController presentViewController:naviVc animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDNoteWordModel *wordModel = self.wordsArray[indexPath.row];
    if (wordModel.height > 0) {
        return wordModel.height;
    }
    YDWordCell *cell = [self.wordTableView dequeueReusableCellWithIdentifier:YDWordCellId];
    if (!cell) {
        cell = [[YDWordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDWordCellId];
    }
    return [cell heightWithModel:wordModel];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDWordCell *cell = [tableView dequeueReusableCellWithIdentifier:YDWordCellId forIndexPath:indexPath];
    cell.wordModel = self.wordsArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wordsArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - YDEditNoteFootViewDelegate
-(void)editnoteFootview:(YDEditNoteFootView *)footview addWordModel:(YDNoteWordModel *)wordModel{
    [self.wordsArray insertObject:wordModel atIndex:0];
    [self.wordTableView beginUpdates];
    
    [self.wordTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.wordTableView endUpdates];
}

@end

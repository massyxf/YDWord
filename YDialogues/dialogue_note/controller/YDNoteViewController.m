//
//  YDDialogueNoteViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDNoteViewController.h"
#import "YDNoteCell.h"
#import "YDEditNoteViewController.h"
#import "YDDBTool+noteCache.h"
#import "YDWindowView.h"

@interface YDNoteViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

/** 单词记录*/
@property(nonatomic,weak)UITableView *diaTableView;

/*models*/
@property (nonatomic,strong)NSMutableArray *noteArray;

@end

@implementation YDNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[YDNoteCell class] forCellReuseIdentifier:YDNoteCellIdentifier];
    [tableView setTableFooterView:[[UIView alloc] init]];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _diaTableView = tableView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"note"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = item;
    [self loadData];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:[YDWindowView windowView]];
}

#pragma mark - data
-(void)loadData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *notes = [[YDDBTool shareInstance] selectNotes];
        [self.noteArray addObjectsFromArray:notes];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.diaTableView reloadData];
        });
    });
}

#pragma mark - getter
-(NSMutableArray *)noteArray{
    if (!_noteArray) {
        _noteArray = [NSMutableArray array];
    }
    return _noteArray;
}

#pragma mark - action
-(IBAction)addNote:(id)sender
{
    YDEditNoteViewController *editVc = [[YDEditNoteViewController alloc] init];
    editVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVc animated:YES];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.noteArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:YDNoteCellIdentifier forIndexPath:indexPath];
    cell.noteModel = self.noteArray[indexPath.item];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"select title"
                                                       delegate:self
                                              cancelButtonTitle:@"cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"bianji",@"moxie", nil];
    [sheet showInView:self.view];
}


//cell scroll action

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"action";
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action_1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                        title:@"action_1" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                            NSLog(@"action_1");
                                                                        }];
    UITableViewRowAction *action_2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                        title:@"action_2" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"action_2"); 
                                                                        }];
    return @[action_1,action_2];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index:%zd",buttonIndex);
}


@end

//
//  ViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "ViewController.h"
#import "YDNoteViewController.h"
#import "YDEditNoteViewController.h"
#import "YDGameViewController.h"
#import "YDDBTool+noteCache.h"
#import "YDTranslationViewController.h"
#import "YDWindowView.h"

@interface ViewController ()<YDWindowViewDelegate>

/** note*/
@property(nonatomic,weak)UINavigationController *noteNavi;

/** trans*/
@property(nonatomic,weak)UINavigationController *transNavi;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL noteSaved = [YDDBTool everSavedNote];
    NSMutableArray *subVcs = [NSMutableArray array];
    UINavigationController *noteVc = [self naviWithRootVcClass:[YDNoteViewController class] title:@"单词本" img:@""];
    [subVcs addObject:noteVc];
    if (!noteSaved) {
        YDEditNoteViewController *editVc = [[YDEditNoteViewController alloc] init];
        editVc.navigationItem.hidesBackButton = YES;
        [noteVc pushViewController:editVc animated:NO];
    }
    _noteNavi = noteVc;
    
//    UINavigationController *gameVc = [self naviWithRootVcClass:[YDGameViewController class] title:@"游戏" img:@""];
//    [subVcs addObject:gameVc];
    
    UINavigationController *transVc = [self naviWithRootVcClass:[YDTranslationViewController class] title:@"翻译" img:@""];
    [subVcs addObject:transVc];
    _transNavi = transVc;
    
    self.viewControllers = subVcs;
    self.tabBar.hidden = YES;
    [YDWindowView windowView].delegate = self;
}

-(UINavigationController *)naviWithRootVcClass:(Class)class title:(NSString *)title img:(NSString *)img{
    if ([class isSubclassOfClass:[UIViewController class]]) {
        UIViewController *vc = [[class alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.navigationItem.title = title;
        navi.tabBarItem.title = title;
        return navi;
    }
    return nil;
}

#pragma mark - YDWindowViewDelegate
-(void)windowView:(YDWindowView *)windowView selectIndex:(YDTabClass)index{
    NSInteger selectedIndex = self.selectedIndex;
    if (index != selectedIndex) {
        if (index == 0) {
            self.selectedViewController = _noteNavi;
        }else{
            self.selectedViewController = _transNavi;
        }
    }
}

@end

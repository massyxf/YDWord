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
#import "YDTranslationViewController.h"

#import "YDDBTool+cacheCheck.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL noteSaved = [YDDBTool everSavedNote];
    NSMutableArray *subVcs = [NSMutableArray array];
    if (noteSaved) {
        UINavigationController *noteVc = [self naviWithRootVcClass:[YDNoteViewController class] title:@"单词本" img:@""];
        [subVcs addObject:noteVc];
    }else{
        UINavigationController *editVc = [self naviWithRootVcClass:[YDEditNoteViewController class] title:@"单词本" img:@""];
        [subVcs addObject:editVc];
    }
    
    UINavigationController *gameVc = [self naviWithRootVcClass:[YDGameViewController class] title:@"游戏" img:@""];
    [subVcs addObject:gameVc];
    
    UINavigationController *transVc = [self naviWithRootVcClass:[YDTranslationViewController class] title:@"翻译" img:@""];
    [subVcs addObject:transVc];
    
    self.viewControllers = subVcs;
}

-(UINavigationController *)naviWithRootVcClass:(Class)class title:(NSString *)title img:(NSString *)img{
    if ([class isSubclassOfClass:[UIViewController class]]) {
        UIViewController *vc = [[class alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        navi.tabBarItem.title = title;
        return navi;
    }
    return nil;
}

@end

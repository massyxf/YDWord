//
//  YDTranslationViewController.m
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDTranslationViewController.h"
#import "YDTransViewController.h"
#import "YDV2TViewController.h"
#import "YDOcrViewController.h"
#import "YDV2TTool.h"

@interface YDTranslationViewController ()<UIScrollViewDelegate>

/** scroll*/
@property(nonatomic,weak)UIScrollView *scrollView;

@end

@implementation YDTranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = SCREENWIDTH / self.subVcs.count;
    [self.subVcs enumerateObjectsUsingBlock:^(UIViewController<YDTransSubVcProtocol> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
        UIButton *button = [self buttonWithTag:obj.bindBtnTag title:obj.bindBtnTitle frame:CGRectMake(btnWidth * idx, YDNaviHeight, btnWidth, 40) action:@selector(topBtnClicked:)];
        [self.view addSubview:button];
    }];
    
    CGFloat scroolY = YDNaviHeight + 40;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scroolY, SCREENWIDTH, SCREENHEIGHT - scroolY - 49)];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    scrollView.delegate = self;
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    scrollView.contentSize = CGSizeMake(width * self.subVcs.count, 0);
    [self scrollViewDidEndDecelerating:scrollView];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(startV2T:)];
}

#pragma mark - getter
-(NSArray<UIViewController *> *)subVcs{
    if (!_subVcs) {
        YDTransViewController *transVc = [[YDTransViewController alloc] init];
        YDV2TViewController *v2tVc = [[YDV2TViewController alloc] init];
//        YDOcrViewController *ocrVc = [[YDOcrViewController alloc] init];
        _subVcs = @[transVc,v2tVc];
    }
    return _subVcs;
}

#pragma mark - custom func
-(UIButton *)buttonWithTag:(NSInteger)tag
                     title:(NSString *)title
                     frame:(CGRect)frame
                    action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.frame = frame;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    return button;
}

-(void)resetBtnState{
    [self.subVcs enumerateObjectsUsingBlock:^(UIViewController<YDTransSubVcProtocol> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *subBtn = [self.view viewWithTag:obj.bindBtnTag];
        subBtn.selected = NO;
    }];
}

#pragma mark - action
-(IBAction)topBtnClicked:(UIButton *)sender{
    if (sender.isSelected) {
        return;
    }
    
    [self resetBtnState];
    
    sender.selected = YES;
    NSInteger index = sender.tag - YDTransTag;
    CGPoint offset = CGPointMake(index * SCREENWIDTH, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}


-(IBAction)startV2T:(id)sender{
    [[YDV2TTool shareInstance] start];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = (scrollView.contentOffset.x + 10 ) / SCREENWIDTH;
    UIViewController *currentVc = self.childViewControllers[index];
    if (!currentVc.viewLoaded) {
        UIView *view = currentVc.view;
        view.frame = CGRectMake(SCREENWIDTH * index, 0, SCREENWIDTH, CGRectGetHeight(scrollView.frame));
        [scrollView addSubview:view];
    }
    [self resetBtnState];
    UIButton *selectBtn = [self.view viewWithTag:YDTransTag + index];
    selectBtn.selected = YES;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

@end

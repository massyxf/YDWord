//
//  YDLanguagesViewController.m
//  YDialogues
//
//  Created by yxf on 2017/8/25.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDLanguagesViewController.h"

@interface YDLanguagesViewController ()

/** languages*/
@property(nonatomic,strong)NSArray *languages;

@end

@implementation YDLanguagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
-(NSArray *)languages{
    if (!_languages) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"country.json" ofType:nil];
        _languages = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _languages;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"text";
    cell.detailTextLabel.text = @"detail";
    cell.imageView.image = [UIImage imageNamed:@"flag_1"];
    return cell;
}

@end

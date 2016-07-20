//
//  QCMineViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCMineViewController.h"
#import "NSObject+DetailOptimize.h"
#import "QCMineHeaderView.h"
#import "QCUtilsMacro.h"

@interface QCMineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) QCMineHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation QCMineViewController

#pragma mark - lazy loading...

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [QCMineHeaderView headerViewWithFrame:CGRectMake(0, 0, ScreenWidth, 210)];
    }
    return _headerView;
}

- (NSArray *)dataList{
    if (!_dataList) {
        NSMutableDictionary *miaoBi = [NSMutableDictionary dictionary];
        miaoBi[@"title"] = @"我的喵币";
        miaoBi[@"icon"] = @"my_coin_20x20_";
        
        NSMutableDictionary *zhiBoJian = [NSMutableDictionary dictionary];
        zhiBoJian[@"title"] = @"直播间管理";
        zhiBoJian[@"icon"] = @"live_manager_20x20_";
        
        NSMutableDictionary *shouYi = [NSMutableDictionary dictionary];
        shouYi[@"title"] = @"我的收益";
        shouYi[@"icon"] = @"income_20x20_";
        
        NSMutableDictionary *liCai = [NSMutableDictionary dictionary];
        liCai[@"title"] = @"微钱进理财";
        liCai[@"icon"] = @"sinashow_20x20_";
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"title"] = @"设置";
        setting[@"icon"] = @"setting_20x20_";
        
        NSArray *section1 = @[miaoBi, zhiBoJian];
        NSArray *section2 = @[shouYi, liCai];
        NSArray *section3 = @[setting];
        
        _dataList = [NSArray arrayWithObjects:section1, section2, section3, nil];
    }
    return _dataList;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
        _tableView.y = -20;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self SeparatorMakeAequilateWithViewDidLoadForTableView:_tableView];
         [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - life cycle...

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];

    self.tableView.tableHeaderView = self.headerView;
}


#pragma mark - custom action


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
    if (!indexPath.section && !indexPath.row) {
        cell.detailTextLabel.text = @"200枚";
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.935 green:0.756 blue:0.000 alpha:1.000];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 20 : CGFLOAT_MIN;
}

@end

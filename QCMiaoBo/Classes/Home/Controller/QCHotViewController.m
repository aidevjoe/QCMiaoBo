//
//  QCHotViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCHotViewController.h"
#import "MHNetworkManager.h"
#import "YYModel.h"
#import "QCAnchor.h"
#import "QCHomeAnchorCell.h"
#import "QCWatchLiveViewController.h"

@interface QCHotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *anchorData;

@end

@implementation QCHotViewController

#pragma mark lazy loading...

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 400;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)anchorData{
    if (!_anchorData) {
        _anchorData = [NSArray array];
    }
    return _anchorData;
}


#pragma mark life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self tableView];
    
    [MHNetworkManager getRequstWithURL:@"http://live.9158.com/Fans/GetHotLive?page=1" params:nil successBlock:^(id returnData, int code, NSString *msg) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"][@"list"]) {
            [dataArr addObject:[QCAnchor yy_modelWithJSON:dict]];
        }
        self.anchorData = dataArr;
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
        
    } showHUD:YES];
    
}


#pragma mark TableViewDelegate && TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QCHomeAnchorCell *cell = [QCHomeAnchorCell cellWithTableView:tableView];
    if (self.anchorData.count) {
        cell.anchor = self.anchorData[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCWatchLiveViewController *wlVC = [[QCWatchLiveViewController alloc] init];
    wlVC.anchor = self.anchorData[indexPath.row];
    [self.navigationController pushViewController:wlVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end

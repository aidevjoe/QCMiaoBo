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
#import "QCAd.h"
#import "XRCarouselView.h"
#import "QCUtilsMacro.h"
#import "QCWebViewController.h"


@interface QCHotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *anchorData; /**< 直播数组 */

@property (nonatomic, strong) NSArray *adData; /**< 广告数组 */

@property (nonatomic, strong) XRCarouselView *adView; /**< 广告视图 */

@end

@implementation QCHotViewController

#pragma mark lazy loading...

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= 104;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 410;
        _tableView.tableHeaderView = self.adView;
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

- (NSArray *)adData{
    if (!_adData) {
        _adData = [NSArray array];
    }
    return _adData;
}

- (XRCarouselView *)adView{
    if (!_adView) {
        _adView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        _adView.time = 2;
    }
    return _adView;
}


#pragma mark life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self sendRequest];
    
    WeakSelf;
    self.adView.imageClickBlock = ^(NSInteger index){
        QCAd *ad = weakSelf.adData[index];
        [weakSelf.navigationController pushViewController:[QCWebViewController webViewWithUrl:ad.link title:ad.title] animated:YES];
    };
}

- (void)sendRequest{
    [MHNetworkManager getRequstWithURL:@"http://live.9158.com/Living/GetAD" params:nil successBlock:^(id returnData, int code, NSString *msg) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"]) {
            [dataArr addObject:[QCAd yy_modelWithJSON:dict]];
        }
        self.adData = dataArr;
        
        NSMutableArray *adImageUrlArr = [NSMutableArray array];
        for (QCAd *ad in self.adData) {
            [adImageUrlArr addObject:ad.imageUrl];
        }
        self.adView.imageArray = adImageUrlArr;
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
        
    } showHUD:YES];
    
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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 0) {
//        if (offsetY >= 44) {
//            [self setNavigationBarTransformProgress:1];
//            [self.tabBarController setHidden:YES];
//        } else {
//            [self setNavigationBarTransformProgress:(offsetY / 44)];
//            [self.tabBarController setHidden:NO];
//        }
//    } else {
//        [self setNavigationBarTransformProgress:0];
//        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
//    }
//}
//
//- (void)setNavigationBarTransformProgress:(CGFloat)progress{
//    [self.navigationController.navigationBar lt_setTranslationY:(-64 * progress)];
//    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
//}

@end



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
#import "MJRefresh.h"
#import "QCRefreshGifHeader.h"

@interface QCHotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *anchorData; /**< 直播数组 */

@property (nonatomic, strong) NSArray *adData; /**< 广告数组 */

@property (nonatomic, strong) XRCarouselView *adView; /**< 广告视图 */

@property (nonatomic, assign) NSUInteger page;

@end

@implementation QCHotViewController

#pragma mark lazy loading...

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= 104;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 430;
        _tableView.tableHeaderView = self.adView;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)setAnchorData:(NSMutableArray *)anchorData{
    if (!_anchorData) {
        _anchorData = [NSMutableArray array];
    }
    if (self.page == 1){
        [_anchorData setArray:anchorData];
    }else{
        [_anchorData addObjectsFromArray:anchorData];
    }
    [self.tableView reloadData];
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
    
    //初始化上拉、下拉刷新
    [self initHeaderAndFooterView];

    //获取数据
    [self getAdData];
    [self getLiveData];

    //监听广告图的图片点击
    WeakSelf;
    self.adView.imageClickBlock = ^(NSInteger index){
        QCAd *ad = weakSelf.adData[index];
        [weakSelf.navigationController pushViewController:[QCWebViewController webViewWithUrl:ad.link title:ad.title] animated:YES];
    };
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    [DefaultNotificationCenter addObserverForName:kStatusBarTappedNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    [DefaultNotificationCenter removeObserver:self];
//}

- (void)statusBarTappedAction{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)initHeaderAndFooterView{
    //默认为第一页
    self.page = 1;
    
    self.tableView.mj_header = [QCRefreshGifHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getAdData];
        [self getLiveData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self getLiveData];
    }];
}

- (void)getAdData{
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
    } showHUD:NO];
}

- (void)getLiveData{
    [MHNetworkManager getRequstWithURL:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%li", self.page] params:nil successBlock:^(id returnData, int code, NSString *msg) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"][@"list"]) {
            [arrayM addObject:[QCAnchor yy_modelWithJSON:dict]];
        }
        self.anchorData = arrayM;
        
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        self.page --;
        
        NSLog(@"%@", error);
    } showHUD:NO];
}

#pragma mark TableViewDelegate && TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.anchorData.count;
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
    [self presentViewController:wlVC animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.anchorData.count - 1) {
        [self getLiveData];
    }
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



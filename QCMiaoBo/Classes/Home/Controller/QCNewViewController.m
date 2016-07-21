//
//  QCNewViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCNewViewController.h"
#import "MHNetworkManager.h"
#import <YYModel.h>
#import "QCAd.h"
#import "QCNewAnchorCell.h"
#import "QCUtilsMacro.h"
#import "QCWatchLiveViewController.h"
#import "QCAnchor.h"
#import "MJRefresh.h"
#import "QCRefreshGifHeader.h"

@interface QCNewViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *anchorList;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSUInteger page;

@end

@implementation QCNewViewController

#pragma mark - lazy loading...

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat wh = ScreenWidth / 3 - 2;
        layout.itemSize = CGSizeMake(wh, wh);
        layout.minimumLineSpacing = 2.5;
        layout.minimumInteritemSpacing = 2.5;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 115, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_collectionView];
        [self.collectionView registerClass:[QCNewAnchorCell class] forCellWithReuseIdentifier:[QCNewAnchorCell description]];
    }
    return _collectionView;
}

- (void)setAnchorList:(NSMutableArray *)anchorList{
    if (!_anchorList) {
        _anchorList = [NSMutableArray array];
    }
    if (self.page == 1) {
        [_anchorList setArray:anchorList];
    }else{
        [_anchorList addObjectsFromArray:anchorList];
    }
    [self.collectionView reloadData];
}

#pragma mark - life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化上拉、下拉刷新
    [self initHeaderAndFooterView];

    //获取数据
    [self getNewAnchor];
}

- (void)initHeaderAndFooterView{
    //默认为第一页
    self.page = 1;

    self.collectionView.mj_header = [QCRefreshGifHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getNewAnchor];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page += 1;
        [self getNewAnchor];
    }];
}

- (void)statusBarTappedAction{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (void)getNewAnchor{
    
    [MHNetworkManager getRequstWithURL:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%li", self.page] params:nil successBlock:^(id returnData, int code, NSString *msg) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"][@"list"]) {
            [dataArr addObject:[QCAnchor yy_modelWithJSON:dict]];
        }
        self.anchorList = dataArr;
        
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.page --;
        
        NSLog(@"%@", error);
    } showHUD:NO];
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.anchorList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCNewAnchorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[QCNewAnchorCell description] forIndexPath:indexPath];
    cell.anchor = self.anchorList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QCWatchLiveViewController *wlVC = [[QCWatchLiveViewController alloc] init];
    wlVC.anchor = self.anchorList[indexPath.row];
    [self presentViewController:wlVC animated:YES completion:nil];
}

@end

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
#import "QCNewAnchor.h"

@interface QCNewViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *anchorList;

@property (nonatomic, strong) UICollectionView *collectionView;

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

#pragma mark - life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self getNewAnchor];
    
    [self collectionView];
}

- (void)getNewAnchor{
    
    [MHNetworkManager getRequstWithURL:@"http://live.9158.com/Room/GetNewRoomOnline?page=1" params:nil successBlock:^(id returnData, int code, NSString *msg) {
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (NSDictionary *dict in returnData[@"data"][@"list"]) {
            [dataArr addObject:[QCNewAnchor yy_modelWithJSON:dict]];
        }
        self.anchorList = dataArr;
        
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
        
    } showHUD:YES];
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

@end

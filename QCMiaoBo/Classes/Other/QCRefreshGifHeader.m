//
//  QCRefreshGifHeader.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/20.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCRefreshGifHeader.h"

@implementation QCRefreshGifHeader


#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"reflesh%zd_60x55", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55"]] forState:MJRefreshStateIdle];
    [self setImages:@[[UIImage imageNamed:@"reflesh1_60x55"]]  forState:MJRefreshStatePulling];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}


@end

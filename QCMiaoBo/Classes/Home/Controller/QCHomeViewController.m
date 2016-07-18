//
//  QCHomeViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCHomeViewController.h"
#import "QCHotViewController.h"
#import "QCSliderView.h"
#import "QCNewViewController.h"
#import "QCFollowViewController.h"
#import "QCUtilsMacro.h"


@interface QCHomeViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) QCSliderView *sliderView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *childVc;

@end

@implementation QCHomeViewController


#pragma mark - lazy loading...

- (NSArray *)childVc{
    if (!_childVc) {
        _childVc = @[@"QCHotViewController", @"QCNewViewController", @"QCFollowViewController"];
    }
    return _childVc;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(ScreenWidth * self.childVc.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (QCSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [QCSliderView sliderViewWithTitles:@[@"最热", @"最新", @"关注"]];
    }
    return _sliderView;
}

#pragma mark - life cycle...

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationItem setTitleView:self.sliderView];
    
    //添加子视图
    [self initChildController];
}


#pragma mark - custom action

- (void)initChildController{
    for (int i = 0; i < self.childVc.count; i ++) {
        UIViewController *vc = [[NSClassFromString(self.childVc[i]) alloc] init];
        vc.view.frame = CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight);
        [self.scrollView addSubview:vc.view];
        [self addChildViewController:vc];
    }
}


@end

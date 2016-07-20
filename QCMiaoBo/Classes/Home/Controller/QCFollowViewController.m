//
//  QCFollowViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCFollowViewController.h"
#import "QCUtilsMacro.h"
#import <PureLayout.h>

@interface QCFollowViewController ()

@property (nonatomic, strong) UIImageView *noFollowImg;
@property (nonatomic, strong) UILabel *noFollowLabel;
@property (nonatomic, strong) UIButton *goToHotLiveBtn;

@end

@implementation QCFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化UI
    [self setupUI];
}

- (void)setupUI{
    self.noFollowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_follow_250x247"]];
    [self.view addSubview:self.noFollowImg];
    
    self.noFollowLabel = [UILabel new];
    self.noFollowLabel.text = @"您关注的主播还没有开播";
    self.noFollowLabel.textColor = HexColor(@"AAAAAA");
    self.noFollowLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.noFollowLabel];
    
    self.goToHotLiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goToHotLiveBtn setTitle:@"去看看当前热门主播" forState:UIControlStateNormal];
    [self.goToHotLiveBtn setTitleColor:KeyColor forState:UIControlStateNormal];
    self.goToHotLiveBtn.layer.masksToBounds = YES;
    self.goToHotLiveBtn.layer.cornerRadius = 20;
    self.goToHotLiveBtn.layer.borderColor = KeyColor.CGColor;
    self.goToHotLiveBtn.layer.borderWidth = 1.f;
    [self.goToHotLiveBtn addTarget:self action:@selector(goToHotLiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.goToHotLiveBtn];
    
    [self.noFollowImg autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.noFollowImg autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset: - 100];
    
    [self.noFollowLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.noFollowImg];
    [self.noFollowLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.noFollowImg withOffset:8];
    
    [self.goToHotLiveBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:self.noFollowImg];
    [self.goToHotLiveBtn autoSetDimensionsToSize:CGSizeMake(250, 40)];
    [self.goToHotLiveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.noFollowLabel withOffset:30];
}

- (void)goToHotLiveBtnClick{
    [DefaultNotificationCenter postNotificationName:kGoToHotLiveNotice object:nil];
}

@end

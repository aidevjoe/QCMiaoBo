//
//  QCMineHeaderView.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/20.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCMineHeaderView.h"
#import <PureLayout.h>
#import "UIImageView+WebCache.h"

@interface QCMineHeaderView ()

@property (nonatomic, strong) UIView *topCoverView;
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *sexImgV;
@property (nonatomic, strong) UIImageView *levelImg;
@property (nonatomic, strong) UILabel *IDXLabel;
@property (nonatomic, strong) UILabel *introductionLabel;
@property (nonatomic, strong) UIImageView *arrowImgV;


@property (nonatomic, strong) UIView *bottomCoverView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *followLabel;
@property (nonatomic, strong) UILabel *followNumLabel;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *fansNumLabel;
@property (nonatomic, strong) UILabel *liveDurationLabel;
@property (nonatomic, strong) UILabel *liveDurationNumLabel;
@property (nonatomic, strong) UIView *divLineLeft;
@property (nonatomic, strong) UIView *divLineRight;
@end


@implementation QCMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0.588 green:0.596 blue:0.584 alpha:.600];
        
//        ----------------------  topCoverView  ------------------------
        self.topCoverView = [UIView new];
        [self addSubview:self.topCoverView];
        
        self.iconImgV = [UIImageView new];
        self.iconImgV.layer.masksToBounds = YES;
        self.iconImgV.layer.cornerRadius = 42.5;
        self.iconImgV.layer.borderColor = [UIColor whiteColor].CGColor;
        self.iconImgV.layer.borderWidth = 2.f;
        [self.topCoverView addSubview:self.iconImgV];
        
        self.nicknameLabel = [UILabel new];
        self.nicknameLabel.text = @"Joe";
        self.nicknameLabel.textColor = [UIColor whiteColor];
        [self.topCoverView addSubview:self.nicknameLabel];
        
        self.sexImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_boy_20x20_"]];
        [self.topCoverView addSubview:self.sexImgV];
        
        self.levelImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"level15_22x22_"]];
        [self.topCoverView addSubview:self.levelImg];
        
        self.IDXLabel = [UILabel new];
        self.IDXLabel.text = @"IDX: 88888";
        self.IDXLabel.textColor = [UIColor whiteColor];
        self.IDXLabel.font = [UIFont systemFontOfSize:14];
        [self.topCoverView addSubview:self.IDXLabel];
        
        self.introductionLabel = [UILabel new];
        self.introductionLabel.text = @"Coding...";
        self.introductionLabel.textColor = [UIColor whiteColor];
        self.introductionLabel.font = [UIFont systemFontOfSize:14];
        [self.topCoverView addSubview:self.introductionLabel];
        
        self.arrowImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_9x14_"]];
        [self.topCoverView addSubview:self.arrowImgV];
        
        
        [self.topCoverView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.topCoverView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.topCoverView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.topCoverView autoSetDimension:ALDimensionHeight toSize:150];
        
        [self.iconImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.iconImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.iconImgV autoSetDimensionsToSize:CGSizeMake(85, 85)];
        
        [self.nicknameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImgV withOffset:15];
        [self.nicknameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.iconImgV withOffset:5];
        
        [self.sexImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nicknameLabel];
        [self.sexImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nicknameLabel withOffset:5];
        [self.sexImgV autoSetDimensionsToSize:CGSizeMake(15, 15)];
        
        [self.levelImg autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.sexImgV withOffset:3];
        [self.levelImg autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nicknameLabel];
        [self.levelImg autoSetDimensionsToSize:CGSizeMake(20, 20)];
        
        [self.introductionLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.iconImgV withOffset:-5];
        [self.introductionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nicknameLabel];
        
        [self.IDXLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.introductionLabel];
        [self.IDXLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.introductionLabel withOffset:-3];
        
        [self.arrowImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.iconImgV];
        [self.arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [self.arrowImgV autoSetDimensionsToSize:CGSizeMake(9, 14)];
        
        
        //        ----------------------  topCoverView  ------------------------
        
//        @property (nonatomic, strong) UIView *lineView;
//        @property (nonatomic, strong) UILabel *followLabel;
//        @property (nonatomic, strong) UILabel *followNumLabel;
//        @property (nonatomic, strong) UILabel *fansLabel;
//        @property (nonatomic, strong) UILabel *fansNumLabel;
//        @property (nonatomic, strong) UILabel *liveDurationLabel;
//        @property (nonatomic, strong) UILabel *liveDurationNumLabel;
//        @property (nonatomic, strong) UIView *divLineLeft;
//        @property (nonatomic, strong) UIView *divLineRight;
        
        self.bottomCoverView = [UIView new];
        [self addSubview:self.bottomCoverView];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = [UIColor colorWithRed:0.682 green:0.686 blue:0.675 alpha:1.000];
        [self.bottomCoverView addSubview:self.lineView];
        
        [self.bottomCoverView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.bottomCoverView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.bottomCoverView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.bottomCoverView autoSetDimension:ALDimensionHeight toSize:60];
        
        [self.lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.lineView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.lineView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.lineView autoSetDimension:ALDimensionHeight toSize:1];
        
        NSString *imgUrl = @"http://wx.qlogo.cn/mmopen/xxLzNxqMsxnUQpnnrJp5G2gFudjN2w2hdxDMd16OJcqSF3buXV1pIibBJZwZLpuunyvYTDM4ia8pOtdvt76hluLCZunIDMn0R4/132";
        [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"private_icon_70x70"]];
        
        

    }
    
    return self;
}

+ (instancetype)headerViewWithFrame:(CGRect)frame{
    return [[QCMineHeaderView alloc] initWithFrame:frame];
}

@end

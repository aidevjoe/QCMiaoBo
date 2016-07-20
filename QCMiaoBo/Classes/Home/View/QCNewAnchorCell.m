//
//  QCNewAnchorCell.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/19.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCNewAnchorCell.h"
#import <PureLayout.h>
#import <UIImageView+WebCache.h>
#import "QCAnchor.h"
#import "QCUtilsMacro.h"

@interface QCNewAnchorCell ()

@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIButton *addressBtn;
@property (nonatomic, strong) UIImageView *xinTag;
@property (nonatomic, strong) UIImageView *starImage;
@property (nonatomic, strong) UILabel *nicknameLabel;

@end

@implementation QCNewAnchorCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.bgImage = [UIImageView new];
        [self.contentView addSubview:self.bgImage];
        
        self.addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addressBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.addressBtn setImage:[UIImage imageNamed:@"location_white_8x9_"] forState:UIControlStateNormal];
        [self.addressBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.contentView addSubview:self.addressBtn];
        
        self.xinTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag_new_33x17_"]];
        [self.contentView addSubview:self.xinTag];
        
        self.starImage = [UIImageView new];
        [self.contentView addSubview:self.starImage];
        
        self.nicknameLabel = [UILabel new];
        self.nicknameLabel.font = [UIFont systemFontOfSize:12];
        self.nicknameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nicknameLabel];
        
        [self.bgImage autoPinEdgesToSuperviewEdges];
        
        [self.addressBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:2];
        [self.addressBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3];
        [self.addressBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.xinTag];
        [self.addressBtn autoSetDimension:ALDimensionHeight toSize:15];
        
        [self.xinTag autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:2];
        [self.xinTag autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.addressBtn];
        [self.xinTag autoSetDimensionsToSize:CGSizeMake(33, 17)];
        
        [self.nicknameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:2];
        [self.nicknameLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:3];
        [self.nicknameLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.starImage withOffset:2];
        
        [self.starImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nicknameLabel];
        [self.starImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:2];
        [self.starImage autoSetDimensionsToSize:CGSizeMake(28, 14)];

    }
    return self;
}


- (void)setAnchor:(QCAnchor *)anchor{
    _anchor = anchor;
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:anchor.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    [self.addressBtn setTitle:anchor.position.length ? anchor.position : @"来自喵星" forState:UIControlStateNormal];
    self.xinTag.hidden = !anchor.isXinUser;
    self.nicknameLabel.text = anchor.nickname;
    self.starImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%li_40x19", anchor.starlevel]];
}

@end

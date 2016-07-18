//
//  QCHomeAnchorCell.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCHomeAnchorCell.h"
#import <PureLayout.h>
#import <UIImageView+WebCache.h>
#import "QCAnchor.h"
#import "QCUtilsMacro.h"

@interface QCHomeAnchorCell ()


@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIImageView *starImageV;
@property (nonatomic, strong) UIButton *addressBtn;
@property (nonatomic, strong) UILabel *viewerNumLabel;
@property (nonatomic, strong) UIImageView *bigpicImage;
@property (nonatomic, strong) UIImageView *liveTagView;
@end

@implementation QCHomeAnchorCell

+ (QCHomeAnchorCell *)cellWithTableView:(UITableView *)tableView{
    QCHomeAnchorCell *cell = [tableView dequeueReusableCellWithIdentifier:[self description]];
    if (!cell) {
        cell = [[QCHomeAnchorCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self description]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.iconImageV = [[UIImageView alloc] init];
    self.iconImageV.layer.masksToBounds = YES;
    self.iconImageV.layer.cornerRadius = 20;
    self.iconImageV.layer.borderColor = KeyColor.CGColor;
    self.iconImageV.layer.borderWidth = 1;
    [self.contentView addSubview:self.iconImageV];
    
    self.nicknameLabel = [UILabel new];
    self.nicknameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.nicknameLabel];
    
    self.starImageV = [UIImageView new];
    [self.starImageV sizeToFit];
    [self.contentView addSubview:self.starImageV];
    
    self.addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addressBtn setTitleColor:[UIColor colorWithRed:0.435 green:0.443 blue:0.471 alpha:1.000] forState:UIControlStateNormal];
    [self.addressBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.addressBtn setImage:[UIImage imageNamed:@"home_location_8x8"] forState:UIControlStateNormal];
    self.addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.addressBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.contentView addSubview:self.addressBtn];
    
    self.viewerNumLabel = [UILabel new];
    [self.contentView addSubview:self.viewerNumLabel];
    
    self.bigpicImage = [UIImageView new];
    [self.contentView addSubview:self.bigpicImage];
    
    self.liveTagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_live_43x22"]];
    [self.liveTagView sizeToFit];
    [self.contentView addSubview:self.liveTagView];
    
    UIView *intervalView = [UIView new];
    intervalView.backgroundColor = gbColor;
    [self.contentView addSubview:intervalView];
    
    [self.iconImageV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [self.iconImageV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.iconImageV autoSetDimensionsToSize:CGSizeMake(40, 40)];
    
    [self.nicknameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.iconImageV withOffset:2];
    [self.nicknameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageV withOffset:5];
    
    [self.addressBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.iconImageV withOffset:-2];
    [self.addressBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nicknameLabel];
    [self.addressBtn autoSetDimensionsToSize:CGSizeMake(100, 12)];
    
    [self.starImageV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nicknameLabel withOffset:3];
    [self.starImageV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nicknameLabel];
//    [self.starImageV autoSetDimensionsToSize:CGSizeMake(30, 15)];
    
    [self.viewerNumLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [self.viewerNumLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.iconImageV];
    
    [self.bigpicImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.iconImageV withOffset:6];
    [self.bigpicImage autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.bigpicImage autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.bigpicImage autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:intervalView];
    
    [self.liveTagView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.bigpicImage withOffset:8];
    [self.liveTagView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.bigpicImage withOffset:-5];
    
    [intervalView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [intervalView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [intervalView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [intervalView autoSetDimension:ALDimensionHeight toSize:10];
}

- (void)setAnchor:(QCAnchor *)anchor{
    _anchor = anchor;
    
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:anchor.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"] options:SDWebImageRefreshCached];
    
    self.nicknameLabel.text = anchor.myname;
    
    [self.addressBtn setTitle:anchor.gps.length ? anchor.gps : @"喵星" forState:UIControlStateNormal];
    
    self.starImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19", anchor.starlevel]];
    
    self.viewerNumLabel.text = [NSString stringWithFormat:@"%li", anchor.allnum];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.viewerNumLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:KeyColor range:NSMakeRange(0, self.viewerNumLabel.text.length)];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:@"人在看" attributes:
                                 @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:13]
                                   }]];
    self.viewerNumLabel.attributedText = str;
    
    [self.bigpicImage sd_setImageWithURL:[NSURL URLWithString:anchor.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
}
@end

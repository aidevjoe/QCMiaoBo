//
//  QCWatchLiveViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/14.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCWatchLiveViewController.h"
#import <IJKMediaFramework/IJKFFMoviePlayerController.h>
#import "QCAnchor.h"
#import "UIImageView+WebCache.h"

@interface QCWatchLiveViewController ()

@property(nonatomic,strong)IJKFFMoviePlayerController * player;

@property (nonatomic, strong) UIImageView *placeholderImage;


@end
@implementation QCWatchLiveViewController

#pragma mark - lazy loading...

- (UIImageView *)placeholderImage{
    if (!_placeholderImage) {
        _placeholderImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _placeholderImage.contentMode = UIViewContentModeScaleAspectFill;
        _placeholderImage.layer.masksToBounds = YES;
        [self.view addSubview:self.placeholderImage];
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = _placeholderImage.bounds;
        [_placeholderImage addSubview:visualEffectView];
        [self.view addSubview:_placeholderImage];
    }
    return _placeholderImage;
}


#pragma mark life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载背景图
    [self.placeholderImage sd_setImageWithURL:[NSURL URLWithString:self.anchor.bigpic]];

    // 开始播放
    [self playing];
    
    // 返回按钮
    [self backBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.player prepareToPlay];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
}

#pragma mark - custom action

- (void)playing{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault]; //使用默认配置
    NSURL * url = [NSURL URLWithString:self.anchor.flv];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options]; //初始化播放器，播放在线视频或直播(RTMP)
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.view.frame = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit; //缩放模式
    self.player.shouldAutoplay = YES; //开启自动播放
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
}

- (void)backBtn{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 64 / 2 - 8, 33, 33);
    [backBtn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    backBtn.layer.shadowOffset = CGSizeMake(0, 0);
    backBtn.layer.shadowOpacity = 0.5;
    backBtn.layer.shadowRadius = 1;
    [self.view addSubview:backBtn];
}

- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

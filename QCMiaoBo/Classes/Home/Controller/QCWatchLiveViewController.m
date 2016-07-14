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

@interface QCWatchLiveViewController ()

@property(nonatomic,strong)IJKFFMoviePlayerController * player;

@end
@implementation QCWatchLiveViewController


#pragma mark life cycle...
- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.player prepareToPlay];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
}



@end

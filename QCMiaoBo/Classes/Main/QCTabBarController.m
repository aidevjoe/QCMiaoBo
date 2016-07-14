//
//  QCTabBarController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCTabBarController.h"
#import "QCNavigationController.h"
#import "QCHomeViewController.h"
#import "QCMineViewController.h"
#import "QCLiveVIewController.h"

@implementation QCTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
 
    [self addChildViewController:[QCHomeViewController new] imageName:@"toolbar_home"];
    [self addChildViewController:[QCLiveVIewController new] imageName:@"toolbar_live"];
    [self addChildViewController:[QCMineViewController new] imageName:@"toolbar_me"];
}


- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)imageName {
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    QCNavigationController *nav = [[QCNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}

@end

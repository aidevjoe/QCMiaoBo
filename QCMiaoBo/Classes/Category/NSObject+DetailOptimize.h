//
//  NSObject+DetailOptimize.h
//  NalanEMall
//
//  Created by liukejie on 15/6/12.
//  Copyright (c) 2015年 sitilon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (DetailOptimize)
//  设定cell分割线等宽
- (void)SeparatorMakeAequilateWithViewDidLoadForTableView:(UITableView *)tableView;
- (void)SeparatorMakeAequilateWithTableViewForTableViewCell:(UITableViewCell *)tableViewCell;

@end

//
//  NSObject+DetailOptimize.m
//  NalanEMall
//
//  Created by liukejie on 15/6/12.
//  Copyright (c) 2015年 sitilon. All rights reserved.
//

#import "NSObject+DetailOptimize.h"


@implementation NSObject (DetailOptimize)

- (void)SeparatorMakeAequilateWithViewDidLoadForTableView:(UITableView *)tableView{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
- (void)SeparatorMakeAequilateWithTableViewForTableViewCell:(UITableViewCell *)tableViewCell{
    if ([tableViewCell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableViewCell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([tableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableViewCell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
@end

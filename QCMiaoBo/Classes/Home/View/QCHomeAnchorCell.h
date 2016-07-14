//
//  QCHomeAnchorCell.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCAnchor;

@interface QCHomeAnchorCell : UITableViewCell

+ (QCHomeAnchorCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) QCAnchor *anchor;

@end

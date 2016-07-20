//
//  QCAnchor.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAnchor.h"

@implementation QCAnchor


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"isXinUser" : @"new",
             };
}

- (NSString *)bigpic{
    return _bigpic ? _bigpic : _photo;
}


@end

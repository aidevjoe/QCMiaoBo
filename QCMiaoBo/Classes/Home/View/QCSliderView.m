//
//  QCSliderView.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCSliderView.h"
#import "QCUtilsMacro.h"

@interface QCSliderView ()

@property (nonatomic, strong) UIView *lineV;

@end

@implementation QCSliderView



+ (QCSliderView *)sliderViewWithTitles:(NSArray *)titles{
    
    QCSliderView *sliderView = [[QCSliderView alloc] init];
    sliderView.frame = CGRectMake(0, 0, 200, 40);

    CGFloat btnW = sliderView.width * 0.33;
    CGFloat btnH = sliderView.height;
    CGFloat btnX = 0;
    for (int i = 0; i < titles.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        btnX = i * btnW;
        titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [sliderView addSubview:titleBtn];
        
        if (i == 0) {
            UIView *lineV = [UIView new];
            lineV.frame = CGRectMake(0, btnH, 30, 2);
            lineV.backgroundColor = [UIColor whiteColor];
            [sliderView addSubview:lineV];
            sliderView.lineV = lineV;
        }
    }
    
    return sliderView;
}


@end

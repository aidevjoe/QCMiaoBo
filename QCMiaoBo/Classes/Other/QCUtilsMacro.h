//
//  UtilsMacro.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/14.
//  Copyright © 2016年 Joe. All rights reserved.
//

#ifndef QCUtilsMacro_h
#define QCUtilsMacro_h

#ifdef DEBUG
#define NLLog(format,...)    NSLog(format,##__VA_ARGS__)
#else
#define NLLog(format,...)    (void)0
#endif

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n方法:%s 行:%d 内容:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define NLLocalizedString(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define PI 3.141592654

#define PathForKey(pathKey) [NLUtility addressInfoForKey:pathKey]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// 随机颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

// 颜色(RGB)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//颜色(Hex)
#define HexColor(color) [NLUtility colorWithHexString:(color)]
#define HexColorAndAlpha(color, alp) [NLUtility colorWithHexString:(color) alpha:(alp)]

//宏定义检测block是否可用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

// 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

//颜色
//全局颜色
#define KeyColor RGBACOLOR(216, 41, 116, 1.0)

#endif /* QCUtilsMacro_h */

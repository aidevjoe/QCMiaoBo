//
//  QCAnchor.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QCAnchor : NSObject

/** 直播图 */
@property (nonatomic, copy  ) NSString   *bigpic;
/** 主播头像 */
@property (nonatomic, copy  ) NSString   *smallpic;
/** 直播流地址 */
@property (nonatomic, copy  ) NSString   *flv;
/** 所在城市 */
@property (nonatomic, copy  ) NSString   *gps;
/** 主播名 */
@property (nonatomic, copy  ) NSString   *myname;
/** 个性签名 */
@property (nonatomic, copy  ) NSString   *signatures;
/** 用户ID */
@property (nonatomic, copy  ) NSString   *userId;
/** 星级 */
@property (nonatomic, assign) NSUInteger starlevel;
/** 朝阳群众数目 */
@property (nonatomic, assign) NSUInteger allnum;
/** 这玩意未知 */
@property (nonatomic, assign) NSUInteger lrCurrent;
/** 直播房间号码 */
@property (nonatomic, assign) NSUInteger roomid;
/** 所处服务器 */
@property (nonatomic, assign) NSUInteger serverid;
/** 用户ID */
@property (nonatomic, assign) NSString   *useridx;
/** 排名 */
@property (nonatomic, assign) NSUInteger pos;
/** starImage */
@property (nonatomic, strong) UIImage *starImage;
/** 主播名 */
@property (nonatomic, copy) NSString *nickname;
/** 所在城市 */
@property (nonatomic, copy) NSString *position;
/** 主播头像 */
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger isXinUser;

@end

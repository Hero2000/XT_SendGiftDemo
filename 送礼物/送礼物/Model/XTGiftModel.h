//
//  XTGiftModel.h
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XTGiftModel : NSObject
/** 礼物名称 */
@property (nonatomic, copy) NSString *giftName;
/** 礼物唯一的id */
@property (nonatomic, copy) NSString *giftKeyID;
/** 送礼物人的名字 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *headImage;
/** 礼物图片 */
@property (nonatomic, copy) NSString *giftImage;

@end

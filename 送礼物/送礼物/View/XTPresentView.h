//
//  XTPresentView.h
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTGiftModel;
@interface XTPresentView : UIView
/** 保存每个礼物key对应的执行动画的数组 */
@property (nonatomic, strong) NSMutableDictionary *giftAnimationCache;
/** 保存每个礼物的key缓存池 */
@property (nonatomic, strong) NSMutableArray *giftKeycCache;
/** 当前要执行的model */
@property (nonatomic, strong) XTGiftModel *model;
/** 是否处于动画中 */
@property (nonatomic, assign) BOOL isAnimation;

- (void)startAnimation;

@end

//
//  XTManagerAnimation.h
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/26.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTGiftModel;
@interface XTManagerAnimation : NSObject
/** 要添加到的父类视图 */
@property (nonatomic, strong) UIView *contentView;

//添加模型,执行动画
- (void)managerAddModel:(XTGiftModel *)model;

@end

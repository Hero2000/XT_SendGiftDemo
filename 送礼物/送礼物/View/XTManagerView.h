//
//  XTManagerView.h
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/26.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTGiftModel;
@interface XTManagerView : UIView

//添加模型,执行动画
- (void)managerAddModel:(XTGiftModel *)model;

@end

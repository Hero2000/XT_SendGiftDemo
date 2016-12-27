//
//  XTLabel.h
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTLabel : UILabel
/** 描边颜色 */
@property (nonatomic, strong) UIColor *strokeColor;

//动画
- (void)startAnimationDuration:(CGFloat)duration completion:(void (^ __nullable)(BOOL finished))completion;

@end

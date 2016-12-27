//
//  XTLabel.m
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import "XTLabel.h"

@implementation XTLabel

//动画
- (void)startAnimationDuration:(CGFloat)duration completion:(void (^ __nullable)(BOOL finished))completion{

    
    [UIView animateKeyframesWithDuration:duration delay:0.0f options:0 animations:^{
    
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
           
            self.transform = CGAffineTransformMakeScale(3, 3);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:10.0 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:completion];
        
    }];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    CGSize shadowoffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    //设置线的宽度
    CGContextSetLineWidth(c, 1.0f);
    //设置线连接样式
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    //选择描边模式绘制文字
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    
    self.textColor = [UIColor redColor];
    [super drawRect:rect];
    
    //选择填充模式绘制文字
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    //阴影偏移量
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawRect:rect];
    self.shadowOffset = shadowoffset;
    
}


@end

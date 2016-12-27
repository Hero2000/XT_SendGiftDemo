//
//  XTCarView.m
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/27.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import "XTCarView.h"

@interface XTCarView ()

@property (nonatomic, strong) UIImageView *bgCarImage;

@end

@implementation XTCarView

-(void)dealloc {
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - UI
- (void)prepareUI {

    _bgCarImage = [[UIImageView alloc]init];
    _bgCarImage.image = [UIImage imageNamed:@"car"];
    _bgCarImage.frame = self.frame;
    [self addSubview:_bgCarImage];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _bgCarImage.frame = self.frame;
}

+ (instancetype)loadCarViewWithPoint:(CGPoint)point view:(UIView *)view {
    
    XTCarView *carView = [[XTCarView alloc]init];
    carView.frame = CGRectMake(0, 0, 100, 100);
    [view addSubview:carView];
    [carView layoutIfNeeded];
    
    return carView;
}

#pragma mark - animation
- (void)animation {

    [UIView animateKeyframesWithDuration:4.0f delay:0.2 options:0 animations:^{
        
        __block CGPoint center = self.center;
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1.0/4 animations:^{
            self.transform = CGAffineTransformMakeScale(2, 2);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1.5/4 animations:^{
            self.center = (CGPoint){center.x + [UIScreen mainScreen].bounds.size.width / 2 - 50, center.y + 200};
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1.5/4 relativeDuration:2.5/4 animations:^{
            self.center = (CGPoint){center.x + center.x + [UIScreen mainScreen].bounds.size.width / 2 - 40, center.y + 210};
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2.5/4 relativeDuration:3.5/4 animations:^{
            self.center = (CGPoint){center.x + [UIScreen mainScreen].bounds.size.width -50, center.y + 260};
        }];
        
        [UIView addKeyframeWithRelativeStartTime:3.5/4 relativeDuration:4.0/4 animations:^{
            self.center = (CGPoint){center.x + [UIScreen mainScreen].bounds.size.width + 50, center.y + 270};
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"删除动画");
        [self removeFromSuperview];
    }];
}



@end

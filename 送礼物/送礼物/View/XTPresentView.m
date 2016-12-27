//
//  XTPresentView.m
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import "XTPresentView.h"
#import "XTLabel.h"
#import "XTGiftModel.h"

#define XTKscreen_width [UIScreen mainScreen].bounds.size.width
#define XTKscreen_height [UIScreen mainScreen].bounds.size.height

#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]



@interface XTPresentView ()
#pragma mark - flag ui
/** 背景 */
@property (nonatomic, strong) UIView *bgView;
/** 头像 */
@property (nonatomic, strong) UIImageView *headView;
/** 礼物图 */
@property (nonatomic, strong) UIImageView *giftView;
/** 送礼物人的名字 */
@property (nonatomic, strong) UILabel *nameL;
/** 送的礼物 */
@property (nonatomic, strong) UILabel *giftNameL;
/** 跳动的label */
@property (nonatomic, strong) XTLabel *shakeLabel;

#pragma mark - flag 记录
/** 当前执行到的缓存池里面的下标 */
@property (nonatomic, assign) NSInteger cureentIndex;

@end

@implementation XTPresentView

#pragma mark - getter
-(NSMutableDictionary *)giftAnimationCache {
    if (_giftAnimationCache == nil) {
        _giftAnimationCache = [[NSMutableDictionary alloc] init];
    }
    return _giftAnimationCache;
}

-(NSMutableArray *)giftKeycCache {
    if (_giftKeycCache == nil) {
        _giftKeycCache = [[NSMutableArray alloc] init];
    }
    return _giftKeycCache;
}

#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.cureentIndex = 0;
        self.isAnimation  = NO;
        [self prepareUI];
    }
    return self;
}

#pragma mark - UI
- (void)prepareUI {
    
    _bgView                 = [[UIView alloc]init];
    _bgView.backgroundColor = rgb(0, 0, 0, 0.6);
    _bgView.frame           = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height - 10);
    [self addSubview:_bgView];
    
    _headView               = [[UIImageView alloc]init];
    _headView.image         = [UIImage imageNamed:@"luffy"];
    _headView.frame         = CGRectMake(0, 10, 50, 50);
    [self addSubview:_headView];
    
    _nameL                  = [[UILabel alloc]init];
    _nameL.text             = @"路飞";
    _nameL.textColor        = [UIColor cyanColor];
    _nameL.font             = [UIFont systemFontOfSize:14];
    _nameL.frame            = CGRectMake(60, 10, 50, 20);
    [self addSubview:_nameL];
    
    _giftNameL              = [[UILabel alloc]init];
    _giftNameL.text         = @"送了一束鲜花";
    _giftNameL.textColor    = [UIColor cyanColor];
    _giftNameL.font         = [UIFont systemFontOfSize:14];
    _giftNameL.frame        = CGRectMake(60, _nameL.frame.size.height + 12, 50, 20);
    [self addSubview:_giftNameL];
    
    _giftView               = [[UIImageView alloc]init];
    _giftView.image         = [UIImage imageNamed:@"flower"];
    _giftView.frame         = CGRectMake(self.bounds.size.width - 80, 0, 80, 80);
    [self addSubview:_giftView];
    
    _shakeLabel             = [[XTLabel alloc]init];
    _shakeLabel.text        = @"x1";
    [self addSubview:_shakeLabel];
    
    
    _headView.layer.cornerRadius  = 25;
    _headView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius    = 25;
    _bgView.layer.masksToBounds   = YES;
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _bgView.frame           = CGRectMake(0, 10, self.bounds.size.width - 30, self.bounds.size.height - 10);
    _headView.frame         = CGRectMake(0, 10, 40, 40);
    _nameL.frame            = CGRectMake(42, 10, 50, 20);
    _giftNameL.frame        = CGRectMake(42, _nameL.frame.size.height + 12, 50, 20);
    _giftView.frame         = CGRectMake(self.bounds.size.width - 50 - 30, 0, 55, 55);
    _shakeLabel.frame       = CGRectMake(self.bounds.size.width - 20, 5, 20, 20);
    
    [_nameL sizeToFit];
    [_giftNameL sizeToFit];
    [_shakeLabel sizeToFit];
}

- (void)startAnimation {
    
    if (self.isAnimation) {
        return;
    }
    //先判断礼物key缓存池里面是否有礼物key
    if (self.giftKeycCache.count == 0) {
        return;
    }
    
    //取礼物key 去第一个
    NSString *giftkey = self.giftKeycCache.firstObject;
    
    //通过礼物key获取缓存池里面执行动画的数组
    NSMutableArray *giftArr = self.giftAnimationCache[giftkey];
    //判断是否为空
    if (giftArr.count == 0) {
        return;
    }
    
    //判断数组越界
    if (giftArr.count > self.cureentIndex) {
        
        //获取当前要执行的model
        XTGiftModel *model   = giftArr[self.cureentIndex];
        self.model           = model;
        self.shakeLabel.text = [NSString stringWithFormat:@"x%zd",++self.cureentIndex];
        
        //执行动画
        self.isAnimation = YES;
        if (self.x != 0) {//还没有弹出,执行弹出动画
            [UIView animateWithDuration:0.3 animations:^{
                self.x = 0;
            } completion:^(BOOL finished) {
                [_shakeLabel startAnimationDuration:0.25 completion:^(BOOL finished) {
                    self.isAnimation = NO;
                    //在这里判断时候在缓存池中是否还有没有执行完的动画
                    if (giftArr.count > self.cureentIndex) {
                        [self startAnimation];
                    }else {
                        //执行隐藏方法,当前id的动画执行完毕后,就移除掉执行下一个动画
                        [self animationFinished];
                    }
                }];
                
            }];
        }else {//弹出了,就只执行文字放大动画
            [_shakeLabel startAnimationDuration:0.25 completion:^(BOOL finished) {
                self.isAnimation = NO;
                //在这里判断时候在缓存池中是否还有没有执行完的动画
                if (giftArr.count > self.cureentIndex) {
                    [self startAnimation];
                }else {
                    //执行隐藏方法,当前id的动画执行完毕后,就移除掉执行下一个动画
                    [self animationFinished];
                }
            }];
            
        }
    }
}

///动画执行完成
- (void)animationFinished {
    
    //延迟2秒消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.x = -240;
        } completion:^(BOOL finished) {
            
            //先删除当前礼物key下的动画数组,然后判断缓存池里面时候还有别的动画没有执行完
            [self.giftAnimationCache removeObjectForKey:self.model.giftKeyID];
            [self.giftKeycCache removeObjectAtIndex:0];
            
            self.cureentIndex = 0;
            self.isAnimation  = NO;
            self.model        = nil;
            //判断时候还有key在没执行完
            if (self.giftKeycCache.count != 0) {
                [self startAnimation];
            }
        }];
    });
}

#pragma mark - setter
-(void)setModel:(XTGiftModel *)model {
    _model = model;
    self.headView.image = [UIImage imageNamed:model.headImage];
    self.giftView.image = [UIImage imageNamed:model.giftImage];
    self.nameL.text     = model.name;
    self.giftNameL.text = [NSString stringWithFormat:@"%@送了%@",model.name,model.giftName];
}

@end

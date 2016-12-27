//
//  XTManagerView.m
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/26.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import "XTManagerView.h"
#import "XTPresentView.h"
#import "XTGiftModel.h"

@interface XTManagerView ()

/** 送礼物视图1 */
@property (nonatomic, strong) XTPresentView *presentView1;
/** 送礼物视图2 */
@property (nonatomic, strong) XTPresentView *presentView2;
/** 保存礼物唯一key的数组 */
@property (nonatomic, strong) NSMutableArray *giftKeyCache;

@end

@implementation XTManagerView

#pragma mark - getter
-(XTPresentView *)presentView1 {
    if (_presentView1 == nil) {
        _presentView1 = [[XTPresentView alloc] init];
    }
    return _presentView1;
}

- (XTPresentView *)presentView2 {
    if (_presentView2 == nil) {
        _presentView2 = [[XTPresentView alloc] init];
    }
    return _presentView2;
}

- (NSMutableArray *)giftKeyCache {
    if (_giftKeyCache == nil) {
        _giftKeyCache = [[NSMutableArray alloc] init];
    }
    return _giftKeyCache;
}

#pragma mark - --------- public --------------
//添加模型
- (void)managerAddModel:(XTGiftModel *)model {

    //判断礼物key在缓存池中是否存在
    BOOL iscontentKey = [self.giftKeyCache containsObject:model.giftKeyID];
    //如果没有就把key添加到缓存池中
    if (iscontentKey == NO) {
        [self.giftKeyCache addObject:model.giftKeyID];
    }
    
    //根据id的就判断位置
    if (model.giftKeyID.integerValue % 2) {
        NSLog(@"keyid11 : %@",model.giftKeyID);
        [self startAnimation:self.presentView1 model:model];
    }else {
        NSLog(@"keyid22 : %@",model.giftKeyID);
        [self startAnimation:self.presentView2 model:model];
    }
}

- (void)startAnimation:(XTPresentView *)presentView model:(XTGiftModel *)model {

    //礼物key缓存池
    //判断是否有礼物key,有就不添加 没有就添加 可能前后一个人又送了礼物
    if ([presentView.giftKeycCache containsObject:model.giftKeyID]) {
        
    }else {
        [presentView.giftKeycCache addObject:model.giftKeyID];
    }
    
    //获取礼物view里面执行动画的缓存池的数组
    NSMutableArray *animationArr = presentView.giftAnimationCache[model.giftKeyID];
    //判断数组是否为空,没有就创建数组
    if (!animationArr) {
        animationArr = [NSMutableArray array];
    }
    //将model存入数组中
    [animationArr addObject:model];
    //然后把这个数组重新放入礼物view里面
    [presentView.giftAnimationCache setValue:animationArr forKey:model.giftKeyID];
    //执行动画
    [presentView startAnimation];

}

#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - UI
- (void)prepareUI {

    [self addSubview:self.presentView1];
    [self addSubview:self.presentView2];
    
    self.presentView1.frame = CGRectMake(-220, self.height * 0.3, 220, 60);
    self.presentView2.frame = CGRectMake(-220, self.height * 0.3 + 100, 220, 60);
}

@end

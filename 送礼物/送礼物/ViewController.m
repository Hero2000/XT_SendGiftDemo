//
//  ViewController.m
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import "ViewController.h"
#import "XTLabel.h"
#import "XTPresentView.h"
#import "XTManagerView.h"
#import "XTGiftModel.h"
#import "XTManagerAnimation.h"
#import "XTCarView.h"

@interface ViewController ()

@property (nonatomic, strong) XTManagerAnimation *animationManager;

@property (nonatomic, strong) XTCarView *carView;
/** 粒子动画 */
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationManager = [[XTManagerAnimation alloc]init];
    self.animationManager.contentView = self.view;
}

- (IBAction)lufeiBtnAction:(UIButton *)sender {
    
    for (int i = 0; i < 5; ++i) {
        XTGiftModel *model = [[XTGiftModel alloc]init];
        model.giftName  = @"鲜花";
        model.giftImage = @"flower";
        model.name      = @"路飞";
        model.headImage = @"luffy";
        model.giftKeyID = @"1";
        [self.animationManager managerAddModel:model];
    }
}

- (IBAction)henryBtnAction:(UIButton *)sender {
    
    for (int i = 0; i < 5; ++i) {
        XTGiftModel *model = [[XTGiftModel alloc]init];
        model.giftName  = @"蘑菇";
        model.giftImage = @"mogu";
        model.name      = @"henry";
        model.headImage = @"code";
        model.giftKeyID = @"2";
        [self.animationManager managerAddModel:model];
    }
}

- (IBAction)carBtnAction:(UIButton *)sender {
    
    XTCarView *carView = [XTCarView loadCarViewWithPoint:CGPointZero view:self.view];
    [carView animation];
}

- (IBAction)zanBtnAction:(UIButton *)sender {
 
    self.emitterLayer.hidden = NO;
}

-(CAEmitterLayer *)emitterLayer {
    if (_emitterLayer == nil) {
        _emitterLayer = [CAEmitterLayer layer];
        //发射器在xy轴上的位置
        _emitterLayer.emitterPosition = CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50);
        //发射器的尺寸大小
        _emitterLayer.emitterSize = CGSizeMake(20, 20);
        //渲染模式
        _emitterLayer.renderMode = kCAEmitterLayerUnordered;
        _emitterLayer.emitterShape = kCAEmitterLayerPoint;
        
        //创建保存粒子的数组
        NSMutableArray *array = [NSMutableArray array];
        //创建粒子
        for (int i = 0; i < 10; ++i) {
            //发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            //粒子创建速率 默认1/s
            stepCell.birthRate = 1;
            //粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            //粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            //粒子的内容
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30",i]];
            stepCell.contents = (id)image.CGImage;
            //粒子的名字
            stepCell.name = [NSString stringWithFormat:@"%d",i];
            //粒子的运动速率
            stepCell.velocity = arc4random_uniform(100) + 100;
            //粒子速度的容差
            stepCell.velocityRange = 80;
            //粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI + M_PI_2;
            //粒子发射角度容差
            stepCell.emissionRange = M_PI_2/6;
            //缩放比例
            stepCell.scale = 0.3;
            //添加到数组中
            [array addObject:stepCell];
        }
        //将粒子数组放入发射器中
        _emitterLayer.emitterCells = array;
        //将发射器添加到父类视图
        [self.view.layer addSublayer:_emitterLayer];
    }
    return _emitterLayer;
}

@end

//
//  AppDelegate.h
//  送礼物
//
//  Created by 汉子MacBook－Pro on 2016/12/23.
//  Copyright © 2016年 henry_xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


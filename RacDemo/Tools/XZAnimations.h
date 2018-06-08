//
//  XZAnimations.h
//  RacDemo
//
//  Created by Xu on 2018/6/7.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZAnimations : NSObject


/* 为控件添加闪烁动画 Add a flicker animation to the control */
+(CABasicAnimation *)opacityForever_Animation:(float)time;

/**
 * 震动效果
 * @param control 控件
 * @param direction 方向 position.x || position.y
 * @param time = duration
 */
+ (CAAnimationGroup *)vibration_AnimationAndControl:(id)control Direction:(NSString *)direction time:(float)time ;

/**
 * 位移效果
 * @param direction 方向 position.x || position.y
 * @param time = duration
 * @param fromValue 初始值
 * @param toValue  目标值
 */
+ (CABasicAnimation *)transform_AnimationWithDirection:(NSString *)direction time:(float)time fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue repeatCount:(float)repeatCount;

@end

//
//  XZAnimations.m
//  RacDemo
//
//  Created by Xu on 2018/6/7.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZAnimations.h"

@implementation XZAnimations

+ (CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

// 震动
// x 第一次
// y 第二次
+ (CAAnimationGroup *)vibration_AnimationAndControl:(id)control Direction:(NSString *)direction time:(float)time {
    
    CGPoint position = CGPointMake(0, 0);
    
    if ([control isKindOfClass:[UIView class]]) {
        position = [[control valueForKeyPath:@"center"] CGPointValue];
    }
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:direction];//
    animation.fromValue = @(position);
    animation.toValue = @(position.x - 6);
    animation.autoreverses = YES;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];///没有的话是均匀的动画。
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:direction];//
    animation2.fromValue = @(position.x - 6);
    animation2.toValue = @(position.x + 6);
    animation2.autoreverses = YES;
    
    animation2.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];///没有的话是均匀的动画。
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = time;
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = YES;
    animaGroup.animations = @[animation,animation2];
    animaGroup.repeatCount = 4;
    
    return animaGroup;
}

+ (CABasicAnimation *)transform_AnimationWithDirection:(NSString *)direction time:(float)time fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue repeatCount:(float)repeatCount{
    
    NSString *keyPath = direction;
    
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:keyPath];
    positionAnima.duration = time;
    positionAnima.fromValue = fromValue;
    positionAnima.toValue = toValue;
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    positionAnima.repeatCount = repeatCount;
    positionAnima.removedOnCompletion = YES;
    positionAnima.fillMode = kCAFillModeForwards;
    
    return positionAnima;
}

@end

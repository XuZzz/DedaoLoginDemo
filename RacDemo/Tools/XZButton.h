//
//  XZButton.h
//  UIButtonDemo
//
//  Created by Xu on 2018/6/1.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XZButtonType){
    XZButtonTypeNormal, // 图左文右
    XZButtonTypePicRight,// 图右文左
    XZButtonTypePicTop,// 图上文下
    XZButtonTypePicBottom,// 图下文上
};

@interface XZButton : UIButton

@property (nonatomic, assign)XZButtonType type;
@property (nonatomic, assign)NSInteger textMargin;

/*
 * 初始化
 * frame : frame
 * type : button样式
 * margin : 文字距图片距离
 */
- (instancetype)initWithFrame:(CGRect)frame withType:(XZButtonType)type andMargin:(NSInteger)margin;

@end

//
//  XZTextField.h
//  RacDemo
//
//  Created by Xu on 2018/6/6.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , XZTextFieldMode){
    XZTextFieldModeNormal,
    XZTextFieldModePhone,// 3 4 4
    XZTextFieldModeBankCard
};

@interface XZTextField : UITextField

- (instancetype)initWithFrame:(CGRect)frame WithType:(XZTextFieldMode)type ;

- (instancetype)initWithType:(XZTextFieldMode)type ;

@property (nonatomic, assign) BOOL textfileEditing;

@property (nonatomic, strong, readonly)UILabel *titleLable;

@property (nonatomic, assign)XZTextFieldMode type;

@end

//
//  XZTextField.m
//  RacDemo
//
//  Created by Xu on 2018/6/6.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Masonry.h"
#import "XZAnimations.h"

@interface XZTextField()
{
    NSString    *previousTextFieldContent;
    UITextRange *previousSelection;
}

@property (nonatomic, strong, readwrite)UILabel *titleLable;

@property (nonatomic, strong) UIView *blankView;

//@property (nonatomic, assign) BOOL secureTextEntry;

@property (nonatomic, copy)   NSString * securetext;

@end

@implementation XZTextField


- (instancetype)initWithFrame:(CGRect)frame WithType:(XZTextFieldMode)type {
    
    if (self = [super initWithFrame:frame]) {
        
        self.type = type;
    }
    
    return self;
}

- (instancetype)initWithType:(XZTextFieldMode)type{
    
    if (self = [super init]) {
        
        self.type = type;
    }
    return self;
}

- (void)setType:(XZTextFieldMode)type{
    
    _type = type;
    
    self.textfileEditing = NO;
    
    [self bindSignal];
    [self bindTextfield];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (_type == XZTextFieldModeNormal) {
        self.textInputView.alpha = 1.0f;
    }
    else{
        self.textInputView.alpha = 0.0f;
    }
}

- (void)setTextfileEditing:(BOOL)textfileEditing{
    
    _textfileEditing = textfileEditing;
    
    if (_textfileEditing) {
        [self.blankView setHidden:NO];
        
        [self.blankView.layer addAnimation:[self opacityForever_Animation:0.5] forKey:@"blankViewAnimation"];
        
    }
    else{
        [self.blankView setHidden:YES];
        [self.blankView.layer removeAnimationForKey:@"blankViewAnimation"];
    }
}

-(CABasicAnimation *)opacityForever_Animation:(float)time
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

- (void)bindTextfield{
    
    [self addTarget:self action:@selector(textField1TextBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textField1TextEnd:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textField1TextBegin:(UITextField *)textfield{
    
    self.textfileEditing = YES;
}

- (void)textField1TextEnd:(UITextField *)textfield{
    self.textfileEditing = NO;
}

- (void)bindSignal{
    
    RAC(self.titleLable, textAlignment) = RACObserve(self, textAlignment);
    RAC(self.titleLable, font) = RACObserve(self, font);
    RAC(self.titleLable, textColor) = RACObserve(self, textColor);
    
    RAC(self.titleLable, text) = [RACSignal combineLatest:@[self.rac_textSignal] reduce:^NSString *(NSString *value){
        switch (self->_type) {
            case XZTextFieldModeNormal:
                return @"";
                break;
            case XZTextFieldModePhone:
            {
                if (value.length <= 11) {
                    return [self phoneStyle:value];
                }
                else{
                    self.text = [value substringToIndex:11]; // 输入的手机号11位
                    return [self.titleLable.text substringToIndex:13]; // 显示的手机号13位（2个空格）
                }
            }
                break;
                
            case XZTextFieldModeBankCard:
                if (value.length <=24) {
                    return [self bankCardStyle:value];
                }
                else{
                    self.text = [value substringFromIndex:24];
                    return [self.titleLable.text substringFromIndex:28];
                }
                break;
                
            default:
                return value;
                break;
        }
    }];

    
    [self createUI];
}

- (void)createUI{
    
    if (self.type == XZTextFieldModePhone) {
        [self customUI];
    }
    else if (self.type == XZTextFieldModeBankCard){
        [self customUI];
    }
    
}

- (void)customUI{
    [self setTintColor:[UIColor clearColor]];
    
    [self addSubview:self.titleLable];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.bottom.equalTo(self);
    }];
    
    UIView *blankView = [[UIView alloc] init];
    
    [self.titleLable addSubview:blankView];
    
    blankView.backgroundColor = [UIColor blueColor];
    
    [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLable.mas_right).mas_offset(0);
        make.centerY.equalTo(self.titleLable);
        make.width.mas_equalTo(@(1.6f));
        make.height.mas_equalTo(@(self.frame.size.height));
    }];
    self.blankView = blankView;
    
    [self.blankView setHidden:YES];
}

- (NSString *)phoneStyle:(NSString *)value{
    
    if (value.length > 11) {
        value = [value substringToIndex:11];
    }
    
    NSString *currentStr = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *preStr = [self->previousTextFieldContent stringByReplacingOccurrencesOfString:@" " withString:@""];

    //正在执行删除操作时为0，否则为1
    char editFlag = 0;
    if (currentStr.length <= preStr.length) {
        editFlag = 0;
    }
    else {
        editFlag = 1;
    }

    NSMutableString *tempStr = [NSMutableString new];
    
    int spaceCount = 0;
    if (currentStr.length < 3 && currentStr.length > -1) {
        spaceCount = 0;
    }else if (currentStr.length < 7 && currentStr.length > 2) {
        spaceCount = 1;
    }else if (currentStr.length < 12 && currentStr.length > 6) {
        spaceCount = 2;
    }

    for (int i = 0; i < spaceCount; i++) {
        if (i == 0) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(0, 3)], @" "];

        }else if (i == 1) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(3, 4)], @" "];
        }else if (i == 2) {
            [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
        }
    }

    if (currentStr.length == 11) {
        [tempStr appendFormat:@"%@%@", [currentStr substringWithRange:NSMakeRange(7, 4)], @" "];
    }
    if (currentStr.length < 4) {
        [tempStr appendString:[currentStr substringWithRange:NSMakeRange(currentStr.length - currentStr.length % 3, currentStr.length % 3)]];
    }else if(currentStr.length > 3 && currentStr.length <12) {
        NSString *str = [currentStr substringFromIndex:3];
        [tempStr appendString:[str substringWithRange:NSMakeRange(str.length - str.length % 4, str.length % 4)]];
        if (currentStr.length == 11) {
            [tempStr deleteCharactersInRange:NSMakeRange(13, 1)];
        }
    }
    
    return tempStr;
}

- (NSString *)bankCardStyle:(NSString *)value{
    
    // 4 4 4
    
    if (value.length >= 24) {
        value = [value substringToIndex:24];
    }
    
    return value;
    
}

- (UILabel *)titleLable{
    
    if (!_titleLable) {
        
        _titleLable = [[UILabel alloc] init];
    }
    
    return _titleLable;
}
    

@end

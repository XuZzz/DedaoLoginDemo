//
//  XZButton.m
//  UIButtonDemo
//
//  Created by Xu on 2018/6/1.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZButton.h"
#import "Masonry.h"

@interface XZButton()

@property (nonatomic, strong)UILabel *textLabel;
@property (nonatomic, strong)UIImageView *buttonImageView;
@property (nonatomic, strong)UIView *basicView;
@end

@implementation XZButton

- (void)dealloc{
    
    [self.titleLabel removeObserver:self forKeyPath:@"text"];
    [self.titleLabel removeObserver:self forKeyPath:@"textColor"];
    [self.titleLabel removeObserver:self forKeyPath:@"font"];
    [self.imageView removeObserver:self forKeyPath:@"image"];
}

- (instancetype)initWithFrame:(CGRect)frame withType:(XZButtonType)type andMargin:(NSInteger)margin{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.type = type;
        self.textMargin = margin;
        [self buildUI];
        [self addObserverInButton];
    }
    
    return self;
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {

        [self addObserverInButton];
    }

    return self;
}

- (void)setType:(XZButtonType)type{
    
    _type = type;
    [self buildUI];
}

- (void)setTextMargin:(NSInteger)textMargin{
    
    _textMargin = textMargin;
    [self buildUI];
}

- (void)addObserverInButton{
    
    [self.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.titleLabel addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.titleLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)layoutSubviews{
    
    self.imageView.alpha = 0.0f;
    self.titleLabel.alpha = 0.0f;
}

- (void)buildUI{
    
    [self addSubview:self.basicView];
    
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self);
        
        make.size.equalTo(self);
    }];
    
    [self.basicView addSubview:self.textLabel];
    
    [self.basicView addSubview:self.buttonImageView];
    
    if (self.textMargin == 0) {
        
        self.textMargin = 8;
    }
    
    switch (self.type) {
        case XZButtonTypeNormal:
        {
            [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(self.basicView.mas_left).offset(5);
                
                make.centerY.equalTo(self.basicView);
            }];
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(self.buttonImageView.mas_right).offset(self.textMargin);
                
                make.centerY.equalTo(self.buttonImageView);
            }];
        }
            
            break;
            
        case XZButtonTypePicRight:
        {
            
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.basicView.mas_left).offset(5);
                
                make.centerY.equalTo(self.basicView);
            }];
            
            [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.textLabel.mas_right).offset(self.textMargin);
                
                make.centerY.equalTo(self.basicView);
            }];
        }
            break;
            
        case XZButtonTypePicTop:
        {
            [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(self.basicView.mas_top).offset(10);
                
                make.centerX.equalTo(self.basicView);
            }];
            
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.equalTo(self.buttonImageView.mas_bottom).offset(self.textMargin);
                
                make.centerX.equalTo(self.buttonImageView);
            }];
        }
            break;
        case XZButtonTypePicBottom:
        {
            [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-10);
                
                make.centerX.equalTo(self.basicView);
            }];
            
            [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.buttonImageView.mas_top).offset(-self.textMargin);
                
                make.centerX.equalTo(self.buttonImageView);
            }];
        }
            break;
            
        default:
            break;
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"text"]) {
        
        UILabel *label = (UILabel *)object;
     
        self.textLabel.text = label.text;
    }
    else if ([keyPath isEqualToString:@"textColor"]){
        UILabel *label = (UILabel *)object;
        
        self.textLabel.textColor = label.textColor;
    }
    else if ([keyPath isEqualToString:@"font"]){
        UILabel *label = (UILabel *)object;
        
        self.textLabel.font = label.font;
    }
    else if ([keyPath isEqualToString:@"image"]){
        
        UIImageView *imageView = (UIImageView *)object;
        self.buttonImageView.image = imageView.image;
    }
}

- (UILabel *)textLabel{
    
    if (!_textLabel) {
     
        _textLabel = [[UILabel alloc] init];
        
    }
    return _textLabel;
}

-(UIImageView *)buttonImageView{
    if (!_buttonImageView) {
        
        _buttonImageView = [[UIImageView alloc] init];
        
        _buttonImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _buttonImageView.clipsToBounds = YES;
        
    }
    return _buttonImageView;
}

- (UIView *)basicView{
    
    if (!_basicView) {
        
        _basicView = [[UIView alloc] init];
        
        _basicView.backgroundColor = [UIColor clearColor];
    }
    
    return _basicView;
}
@end

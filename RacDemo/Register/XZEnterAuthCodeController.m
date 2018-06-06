//
//  XZEnterAuthCodeController.m
//  RacDemo
//
//  Created by Xu on 2018/6/4.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZEnterAuthCodeController.h"

// iPhone X 宏定义
#define  iPhoneX ([UIScreen mainScreen].bounds.size.width == 375.f && [UIScreen mainScreen].bounds.size.height == 812.f ? YES : NO)

#define  MC_NavHeight  (iPhoneX ? 88.f : 64.f)

@interface XZEnterAuthCodeController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *reSendLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstCode;
@property (weak, nonatomic) IBOutlet UILabel *secondCode;
@property (weak, nonatomic) IBOutlet UILabel *thirdCode;
@property (weak, nonatomic) IBOutlet UILabel *FourthCode;

@property (strong, nonatomic) UITextField *code;
@property (weak, nonatomic) IBOutlet UIView *codeView;

@end

@implementation XZEnterAuthCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    self.firstCode.layer.cornerRadius = 3.0f;
    self.firstCode.layer.borderWidth  = 1.0f;
    self.firstCode.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    
    self.secondCode.layer.cornerRadius = 3.0f;
    self.secondCode.layer.borderWidth  = 1.0f;
    self.secondCode.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    
    self.thirdCode.layer.cornerRadius = 3.0f;
    self.thirdCode.layer.borderWidth  = 1.0f;
    self.thirdCode.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    
    self.FourthCode.layer.cornerRadius = 3.0f;
    self.FourthCode.layer.borderWidth  = 1.0f;
    self.FourthCode.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    
    [self creatTextFiled];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self.codeView addGestureRecognizer:tap];
    
    
    RAC(self.firstCode,text) = [RACSignal combineLatest:@[self.code.rac_textSignal] reduce:^(NSString *codeString){
        
        return [self getCurrentCodeString:codeString withRange:NSMakeRange(0, 1)];
    }];
    
    RAC(self.secondCode,text) = [RACSignal combineLatest:@[self.code.rac_textSignal] reduce:^(NSString *codeString){
        
        
        return [self getCurrentCodeString:codeString withRange:NSMakeRange(1, 1)];
    }];
    
    RAC(self.thirdCode,text) = [RACSignal combineLatest:@[self.code.rac_textSignal] reduce:^(NSString *codeString){
        
        return [self getCurrentCodeString:codeString withRange:NSMakeRange(2, 1)];
    }];
    
    RAC(self.FourthCode,text) = [RACSignal combineLatest:@[self.code.rac_textSignal] reduce:^(NSString *codeString){
        
       return [self getCurrentCodeString:codeString withRange:NSMakeRange(3, 1)];
    }];
    
    RAC(self.code, text) = [RACSignal combineLatest:@[self.code.rac_textSignal] reduce:^(NSString *codeString){
        
        if (codeString.length > 4) {
            codeString = [codeString substringWithRange:NSMakeRange(0, 4)];
        }
        return codeString;
    }];
}

- (NSString *)getCurrentCodeString:(NSString *)codeString withRange:(NSRange)range{
    
    NSString *newCode = @"";
    
    NSInteger length = range.location;
    
    if (codeString.length >= length+1) {
        
        newCode = [codeString substringWithRange:range];
    }
    
    return newCode;
    
}

- (void)setUpNav{
    
   
    
}

- (void)creatTextFiled{
    
    [self.code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(1,1));
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture{
    
    [self.code becomeFirstResponder];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)VoiceAction:(UIButton *)sender {
}

- (UITextField *)code{
    
    if (!_code) {
        _code = [[UITextField alloc] init];
        
        _code.textColor = [UIColor clearColor];
        
        _code.borderStyle = UITextBorderStyleNone;
        
        _code.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.view addSubview:_code];
    }
    
    return _code;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.code resignFirstResponder];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.code becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}


@end

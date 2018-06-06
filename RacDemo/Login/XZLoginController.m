//
//  XZLoginController.m
//  RacDemo
//
//  Created by Xu on 2018/6/4.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZLoginController.h"

@interface XZLoginController ()
@property (weak, nonatomic) IBOutlet UIImageView *passwordHidden;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *phoneHeaderButton;

@property (assign, nonatomic) BOOL isSee;

@end

@implementation XZLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isSee = NO;
    
    [self.phoneHeaderButton setHidden:YES];
    
    self.passwordTextField.secureTextEntry = YES;
    
    self.passwordHidden.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seePassword:)];
    
    [self.passwordHidden addGestureRecognizer:tap];
    
    XZButton *button = [[XZButton alloc] init];
    
    button.type = XZButtonTypePicRight;
    
    button.textMargin = 15;
    
    [button setTitle:@"+86" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    button.imageView.image = [UIImage imageNamed:@"downImage"];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.phoneTextField);
        
        make.left.equalTo(self.view.mas_left).offset(25);
        
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.phoneTextField.rac_textSignal, self.passwordTextField.rac_textSignal] reduce:^(NSString *phoneString, NSString *passwordString){
        BOOL enable = NO;
        self.loginButton.backgroundColor = [UIColor grayColor];
        if (phoneString.length == 11 && passwordString.length == 6) {
            enable = YES;
            self.loginButton.backgroundColor = [UIColor orangeColor];
        }
        
        return @(enable);
    }];
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgetPasswordAction:(UIButton *)sender {
    
}

- (void)seePassword:(UITapGestureRecognizer *)tap{
    
    self.isSee = !self.isSee;
    
    if (self.isSee) {
        self.passwordTextField.secureTextEntry = NO;
    }
    else{
        self.passwordTextField.secureTextEntry = YES;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.phoneTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}


@end

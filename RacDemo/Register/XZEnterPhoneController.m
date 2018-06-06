//
//  XZEnterPhoneController.m
//  RacDemo
//
//  Created by Xu on 2018/6/4.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZEnterPhoneController.h"

@interface XZEnterPhoneController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *changePhoneHeaderBtn;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@end

@implementation XZEnterPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.changePhoneHeaderBtn setHidden:YES];
    
    XZButton *button = [[XZButton alloc] init];
    
    button.type = XZButtonTypePicRight;
    
    button.textMargin = 15;
    
    [button setTitle:@"+86" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    button.imageView.image = [UIImage imageNamed:@"downImage"];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.phoneTextFiled);
        
        make.left.equalTo(self.view.mas_left).offset(25);
        
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    RAC(self.sendCodeButton, enabled) = [RACSignal combineLatest:@[self.phoneTextFiled.rac_textSignal] reduce:^(NSString *phoneString){
        BOOL enable = NO;
        self.sendCodeButton.backgroundColor = [UIColor grayColor];
        if (phoneString.length == 11) {
            enable = YES;
            self.sendCodeButton.backgroundColor = [UIColor orangeColor];
        }
        
        return @(enable);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phoneTextFiled resignFirstResponder];
    
}
- (IBAction)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.phoneTextFiled becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
}

@end

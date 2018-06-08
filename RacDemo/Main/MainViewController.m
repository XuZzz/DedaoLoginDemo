
//
//  MainViewController.m
//  RacDemo
//
//  Created by Xu on 2018/6/6.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "MainViewController.h"
#import "XZAnimations.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registeButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    [backItem setTintColor:[UIColor blackColor]];
    
    self.navigationItem.backBarButtonItem = backItem;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self.registeButton.layer addAnimation:[XZAnimations transform_AnimationWithDirection:@"position.x" time:0.8 fromValue:@(-self.registeButton.frame.size.width) toValue:@(self.view.center.x) repeatCount:1.0f] forKey:@"registeButton"];
    [self.loginButton.layer addAnimation:[XZAnimations transform_AnimationWithDirection:@"position.x" time:0.8  fromValue:@([UIScreen mainScreen].bounds.size.width + self.loginButton.frame.size.width) toValue:@(self.view.center.x) repeatCount:1.0f] forKey:@"loginButton"];
}

//状态栏字体白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

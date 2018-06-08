//
//  XZSearchController.m
//  RacDemo
//
//  Created by Xu on 2018/6/6.
//  Copyright © 2018年 com.delinshe. All rights reserved.
//

#import "XZSearchController.h"
#import "XZTextField.h"

@interface XZSearchController ()

@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic)  XZTextField *showTextField;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation XZSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBar];
    
    [[[self.searchText.rac_textSignal map:^NSDictionary *(NSString* text) {

        if (text.length > 2) {
            return [self beginSearch:text];
        }
        else{
            return nil;
        }

    }]
     filter:^BOOL(NSDictionary *dic) {
         // 只打印 真好的数据。 出现不好的过滤掉
         return [[dic objectForKey:@"title"] isEqualToString:@"不好"]? NO : YES;
     }]
     subscribeNext:^(NSDictionary * dic) {

         if (dic != nil) {
             NSLog(@"Title:%@,Prompt:%@",dic[@"title"],dic[@"prompt"]);
         }
     }];
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"先吃饭"];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
           
            NSLog(@"销毁A");
        }];
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"吃完饭 睡觉"];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            NSLog(@"销毁A");
        }];
    }];
    
    // 串联 先完成一个再完成下一个
    
    RACSignal *concatSignal = [signalA concat:signalB];
    
    [[concatSignal map:^NSString *(NSString *value) {
        
        if ([value isEqualToString:@"先吃饭"]) {
            return @"吃饭时不要说话";
        }
        else if ([value isEqualToString:@"吃完饭 睡觉"]){
            return @"睡觉时不要玩手机";
        }
        else{
            return value;
        }
    }]
     subscribeNext:^(NSString *value) {
         NSLog(@"%@",value);
         self.searchText.text = value;
     }];
    
    
    // 组合 多个信号同时有值后 才会触发;
    [[[RACSignal combineLatest:@[signalA, signalB] reduce:^(NSString *value1, NSString *value2){
        
        return [value1 stringByAppendingString:[NSString stringWithFormat:@" %@",value2]];
    }]
     map:^NSString *(NSString *value) {
         
         return [value stringByAppendingString:@" 许朕说的"];
     }]
     subscribeNext:^(NSString* value) {
         
         self.searchText.text = value;
     }];
    
    
    
    [[self loadData] subscribeNext:^(NSDictionary * dic) {
        
        NSLog(@"%@",dic[@"title"]);
        
        NSLog(@"%@",dic[@"prompt"]);
    }];
    
    [self.showTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.searchText);
        
        make.top.equalTo(self.searchText.mas_bottom).offset(30);
        
        make.height.mas_equalTo(self.searchText.mas_height);
    }];
}

- (void)setNavigationBar{
    
    self.title = @"搜索";
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;//这句话表示是否显示大标题
    
    self.navigationController.navigationItem.largeTitleDisplayMode =  UINavigationItemLargeTitleDisplayModeAutomatic;
    
    self.navigationItem.hidesBackButton = NO;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.searchText resignFirstResponder];
    [self.showTextField resignFirstResponder];
}

- (RACSignal *)loadData{
    
    NSDictionary *dict = @{@"title":@"王老吉",@"prompt":@"怕上火，和王老吉"} ;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:dict];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
           
            
        }];
    }];
}

- (NSDictionary *)beginSearch:(NSString *)text{
    
    if ([text isEqualToString:@"Hello"]) {
        return @{@"title":@"真好",@"prompt":@"今天天气真好"};
    }
    else{
        return @{@"title":@"不好",@"prompt":@"今天天气不好"};
    }
}


- (IBAction)backAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (XZTextField *)showTextField{
    
    if (!_showTextField) {
        
        _showTextField = [[XZTextField alloc] initWithType:XZTextFieldModePhone];
        
        _showTextField.textColor = [UIColor orangeColor];
        
        _showTextField.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightThin];
        
        _showTextField.textAlignment = NSTextAlignmentLeft;
        
        _showTextField.keyboardType = UIKeyboardTypePhonePad;
        
        [self.view addSubview:_showTextField];
    }
    
    return _showTextField;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end

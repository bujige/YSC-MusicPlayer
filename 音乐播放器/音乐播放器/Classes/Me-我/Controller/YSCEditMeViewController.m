//
//  YSCEditMeViewController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/27.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCEditMeViewController.h"
#import "YSCMeController.h"
#import "YSCTextField.h"
#import <BmobSDK/Bmob.h>

@interface YSCEditMeViewController ()

@property (weak, nonatomic) IBOutlet YSCTextField *name;

@property (weak, nonatomic) IBOutlet YSCTextField *phoneNumber;

@property (weak, nonatomic) IBOutlet YSCTextField *age;

@property (weak, nonatomic) IBOutlet YSCTextField *email;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

- (IBAction)finishEdit:(id)sender;

@end

@implementation YSCEditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    BmobUser *bUser = [BmobUser getCurrentUser];

    if (bUser) {
        self.name.placeholder = [bUser objectForKey:@"name"];
        self.phoneNumber.placeholder = [bUser objectForKey:@"phoneNumber"];
        self.email.placeholder = [bUser objectForKey:@"email"];
        self.usernameLabel.text = [bUser objectForKey:@"username"];
        
        NSNumberFormatter *ageFormatter = [[NSNumberFormatter alloc] init];
        self.age.placeholder = [ageFormatter stringFromNumber:[bUser objectForKey:@"age"]];
        
        self.name.text = self.name.placeholder;
        self.phoneNumber.text = self.phoneNumber.placeholder;
        self.email.text = self.email.placeholder;
        self.age.text = self.age.placeholder;
        
    } else {
        NSLog(@"请登录");
    }
}

- (void)setup
{
    // 设置导航栏标题
    self.navigationItem.title = @"修改信息";
    
    // 设置背景色
    self.view.backgroundColor = YSCGlobalBg;
}


- (IBAction)finishEdit:(id)sender {
    BmobUser *bUser = [BmobUser getCurrentUser];
    [bUser setObject:self.name.text forKey:@"name"];
    [bUser setObject:self.phoneNumber.text forKey:@"phoneNumber"];
    
    NSNumberFormatter *ageFormatter = [[NSNumberFormatter alloc] init];
    [bUser setObject:[ageFormatter numberFromString:self.age.text] forKey:@"age"];
    
    [bUser setObject:self.email.text forKey:@"email"];
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
    
//    YSCMeController *me= [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

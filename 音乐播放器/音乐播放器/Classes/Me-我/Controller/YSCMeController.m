//
//  YSCMeController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCMeController.h"
#import "YSCEditMeViewController.h"
#import "YSCLoginRegisterViewController.h"
#import <BmobSDK/Bmob.h>

@interface YSCMeController ()
- (IBAction)loginRegister;
- (IBAction)logoutBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterOutlet;
@property (weak, nonatomic) IBOutlet UIView *acountOutlet;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@end

@implementation YSCMeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self acountSetup];
    
    [self setup];
}

- (void)setup
{
    // 设置导航栏标题
    self.navigationItem.title = @"我";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    self.navigationItem.leftBarButtonItems = @[settingItem];
    
    // 设置背景色
    self.view.backgroundColor = YSCGlobalBg;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self acountSetup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self acountSetup];
}

- (void)settingClick
{
    YSCEditMeViewController *editMeVC = [[YSCEditMeViewController alloc] init];
    [self.navigationController pushViewController:editMeVC animated:YES];
}

- (void)acountSetup
{
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        //进行操作
        [self updateAcount:bUser];
        self.loginRegisterOutlet.hidden = YES;
        self.acountOutlet.hidden = NO;
    }else{
        //对象为空时，可打开用户注册界面
        self.acountOutlet.hidden = YES;
        self.loginRegisterOutlet.hidden = NO;
    }
}

- (void)updateAcount:(BmobUser *)bUser
{
    self.nameLabel.text = [bUser objectForKey:@"name"];
    self.userNameLabel.text = [bUser objectForKey:@"username"];
    NSLog(@"%@",[bUser objectForKey:@"name"]);
    self.phoneNumberLabel.text = [bUser objectForKey:@"phoneNumber"];
    
    NSNumberFormatter *ageFormatter = [[NSNumberFormatter alloc] init];
    
    self.ageLabel.text = [ageFormatter stringFromNumber:[bUser objectForKey:@"age"]];
    self.emailLabel.text = [bUser objectForKey:@"email"];
}
- (IBAction)loginRegister {
    YSCLoginRegisterViewController *login = [[YSCLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

- (IBAction)logoutBtn:(id)sender {
    [BmobUser logout];
    
    [self acountSetup];
}
@end

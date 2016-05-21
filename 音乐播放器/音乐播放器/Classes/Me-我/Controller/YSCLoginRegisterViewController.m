//
//  YSCLoginRegisterViewController.m
//  YSC-百思不得姐
//
//  Created by YangLunlong on 16/4/26.
//  Copyright © 2016年 杨世超. All rights reserved.
//

#import "YSCLoginRegisterViewController.h"
#import "YSCTextField.h"
#import <BmobSDK/Bmob.h>

@interface YSCLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UIButton *loginOrRegister;
@property (weak, nonatomic) IBOutlet YSCTextField *loginAcount;
@property (weak, nonatomic) IBOutlet YSCTextField *loginPwd;
@property (weak, nonatomic) IBOutlet YSCTextField *registerAcount;
@property (weak, nonatomic) IBOutlet YSCTextField *registerPwd;

- (IBAction)loginBtn:(id)sender;

- (IBAction)registerBtn:(id)sender;



@end

@implementation YSCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
        
    } else { // 显示登录界面
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)loginBtn:(id)sender {
    [BmobUser loginWithUsernameInBackground:self.loginAcount.text
                                   password:self.loginPwd.text];
    
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        //进行操作
        NSLog(@"Login up successfully");
        [self back];
    }else{
        //对象为空时，可打开用户注册界面
        NSLog(@"Login up error");
    }
}

- (IBAction)registerBtn:(id)sender {
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.registerAcount.text];
    [bUser setPassword:self.registerPwd.text];
    [bUser setObject:@18 forKey:@"age"];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
        } else {
            NSLog(@"%@",error);
        }
    }];
    [self showLoginOrRegister:self.loginOrRegister];
    
}


@end

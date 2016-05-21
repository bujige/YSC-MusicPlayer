//
//  main.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/14.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"b65db26607dfedf883038e3fc8bf0a96";
        [Bmob registerWithAppKey:appKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

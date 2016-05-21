//
//  UIBarButtonItem+YSCExtension.h
//  音乐播放器
//
//  Created by YangLunlong on 16/5/18.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YSCExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end

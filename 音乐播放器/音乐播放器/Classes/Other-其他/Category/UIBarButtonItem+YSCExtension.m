//
//  UIBarButtonItem+YSCExtension.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/18.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "UIBarButtonItem+YSCExtension.h"

@implementation UIBarButtonItem (YSCExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end

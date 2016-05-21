//
//  YSCTabBar.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCTabBar.h"

@implementation YSCTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
 
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 4;
    CGFloat buttonH = self.height;
    
    NSInteger index = 0;
    
    for (UIButton *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.backgroundColor = [UIColor clearColor];
        index++;
    }
    
}

@end

//
//  YSCLrcLabel.m
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/10.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLrcLabel.h"

@implementation YSCLrcLabel

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 1.获取需要画的区域
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    // 2.设置颜色
    [[UIColor redColor] set];
    
    // 3.添加区域
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end

//
//  NSString+YSCTimeExtension.m
//  QQMusic
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//


#import "NSString+YSCTimeExtension.h"
#import <AVFoundation/AVFoundation.h>

@implementation NSString (YSCTimeExtension)

+ (NSString *)stringWithTime:(NSTimeInterval)time
{
    NSInteger min = time / 60;
    NSInteger second = (NSInteger)time % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}

+ (NSString *)stringWithCMTime:(CMTime)time
{
    
    NSInteger min = (NSInteger)CMTimeGetSeconds(time) / 60;
    NSInteger second = (NSInteger)CMTimeGetSeconds(time) % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}

@end

//
//  NSString+YSCTimeExtension.m
//  QQMusic
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface NSString (YSCTimeExtension)

+ (NSString *)stringWithTime:(NSTimeInterval)time;
+ (NSString *)stringWithCMTime:(CMTime)time;

@end

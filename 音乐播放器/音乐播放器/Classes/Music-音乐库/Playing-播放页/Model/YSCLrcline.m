//
//  YSCLrcline.m
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/10.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLrcline.h"

@implementation YSCLrcline

- (instancetype)initWithLrclineString:(NSString *)lrclineString
{
    if (self = [super init]) {
        // [01:05.43]我想就这样牵着你的手不放开
        NSUInteger location = [lrclineString rangeOfString:@"]"].location ;
//        NSString *newStr = [str substringFromIndex:location];
//        NSArray *lrcArray = [lrclineString componentsSeparatedByString:@"]"];
//        while ([lrcArray[1] hasPrefix:@"["]) {
//            lrclineString = lrcArray[1];
//            lrcArray = [lrclineString componentsSeparatedByString:@"]"];
//        }
        self.text = [lrclineString substringFromIndex:(location+1)];
        NSString *timeString = [lrclineString substringToIndex:location];
        self.time = [self timeStringWithString:[timeString substringFromIndex:1]];
    }
    return self;
}
+ (instancetype)lrcLineWithLrclineString:(NSString *)lrclineString
{
    return [[self alloc] initWithLrclineString:lrclineString];
}

#pragma mark - 私有方法
- (NSTimeInterval)timeStringWithString:(NSString *)timeString
{
    // 01:05.43
    NSInteger min = [[timeString componentsSeparatedByString:@":"][0] integerValue];
    NSInteger second = [[timeString substringWithRange:NSMakeRange(3, 2)] integerValue];
    NSInteger haomiao = [[timeString componentsSeparatedByString:@"."][1] integerValue];
    
    return (min * 60 + second + haomiao * 0.01);
}

@end

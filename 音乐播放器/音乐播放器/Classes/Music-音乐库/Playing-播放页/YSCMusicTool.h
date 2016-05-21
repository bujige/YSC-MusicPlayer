//
//  YSCMusicTool.h
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/8.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSCMusic;
@class YSCTypeMusic;

@interface YSCMusicTool : NSObject

+ (NSMutableArray *)types;

+ (YSCTypeMusic *)playingMusic;

+ (void)setPlayingMusic:(YSCTypeMusic *)playingMusic;

+ (YSCTypeMusic *)nextMusic;

+ (YSCTypeMusic *)previousMusic;

@end

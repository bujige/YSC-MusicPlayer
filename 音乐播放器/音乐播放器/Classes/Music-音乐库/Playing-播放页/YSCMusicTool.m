//
//  YSCMusicTool.m
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/8.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCMusicTool.h"
#import "YSCMusic.h"
#import <MJExtension.h>

@implementation YSCMusicTool

static NSArray *_musics;
static YSCMusic *_playingMusic;

+ (void)initialize
{
    if (_musics == nil) {
        _musics = [YSCMusic mj_objectArrayWithFilename:@"Musics.plist"];
    }
    
    if (_playingMusic == nil) {
        _playingMusic = _musics[1];
    }
}

+ (NSArray *)musics
{
    return _musics;
}

+ (YSCMusic *)playingMusic
{
    return _playingMusic;
}

+ (void)setPlayingMusic:(YSCMusic *)playingMusic
{
    _playingMusic = playingMusic;
}

+ (YSCMusic *)nextMusic
{
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2.取出下一首
    NSInteger nextIndex = ++currentIndex;
    if (nextIndex >= _musics.count) {
        nextIndex = 0;
    }
    YSCMusic *nextMusic = _musics[nextIndex];
    
    return nextMusic;
}

+ (YSCMusic *)previousMusic
{
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2.取出下一首
    NSInteger previousIndex = --currentIndex;
    if (previousIndex < 0) {
        previousIndex = _musics.count - 1;
    }
    YSCMusic *previousMusic = _musics[previousIndex];
    
    return previousMusic;
}

@end

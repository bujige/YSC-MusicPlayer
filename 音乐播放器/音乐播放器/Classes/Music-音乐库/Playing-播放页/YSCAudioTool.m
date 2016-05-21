//
//  YSCAudioTool.m
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/8.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCAudioTool.h"

@implementation YSCAudioTool

static NSMutableDictionary *_soundIDs;
static NSMutableDictionary *_players;

+ (void)initialize
{
    _soundIDs = [NSMutableDictionary dictionary];
    _players = [NSMutableDictionary dictionary];
}

+ (AVAudioPlayer *)playMusicWithMusicName:(NSString *)musicName
{
    assert(musicName);
    
    // 1.定义播放器
    AVAudioPlayer *player = nil;
    
    // 2.从字典中取player,如果取出出来是空,则对应创建对应的播放器
    player = _players[musicName];
    if (player == nil) {
        // 2.1.获取对应音乐资源
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        
        if (fileUrl == nil) return nil;
        
        // 2.2.创建对应的播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        
        // 2.3.将player存入字典中
        [_players setObject:player forKey:musicName];
        
        // 2.4.准备播放
        [player prepareToPlay];
    }
    
    // 3.播放音乐
    [player play];
    
    return player;
}

+ (void)pauseMusicWithMusicName:(NSString *)musicName
{
    assert(musicName);
    
    // 1.取出对应的播放
    AVAudioPlayer *player = _players[musicName];
    
    // 2.判断player是否nil
    if (player) {
        [player pause];
    }
}

+ (void)stopMusicWithMusicName:(NSString *)musicName
{
    assert(musicName);
    
    // 1.取出对应的播放
    AVAudioPlayer *player = _players[musicName];
    
    // 2.判断player是否nil
    if (player) {
        [player stop];
        [_players removeObjectForKey:musicName];
        player = nil;
    }
}

+(AVPlayer *)playMusicWithSongId:(NSString *)songId songFile:(NSString *)songFile
{
    assert(songId);
    
    AVPlayer *player = nil;
    
    [player pause];
    player = _players[songId];
    
    if (player == nil) {
        player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:songFile]];
        
        [_players setObject:player forKey:songId];
        
    }
    
    [player play];
    return player;
}

+ (void)pauseMusicWithSongId:(NSString *)songId songFile:(NSString *)songFile
{
    assert(songId);
    
    AVPlayer *player = _players[songId];
    
    if (player) {
        [player pause];
    }
}

+ (void)stopMusicWithSongId:(NSString *)songId songFile:(NSString *)songFile
{
    assert(songId);
    
    AVPlayer *player = _players[songId];
    
    if (player) {
        [player pause];
        [_players removeObjectForKey:songId];
        player = nil;
    }
}

+ (void)stopAllMusic
{
    for (NSString *string in _players) {
        AVPlayer *player = _players[string];
        [player pause];
        [_players removeObjectForKey:string];
        player = nil;
    }
    
}
#pragma mark - 音效的播放
+ (void)playSoundWithSoundname:(NSString *)soundname
{
    // 1.定义SystemSoundID
    SystemSoundID soundID = 0;
    
    // 2.从字典中取出对应soundID,如果取出是nil,表示之前没有存放在字典
    soundID = [_soundIDs[soundname] unsignedIntValue];
    if (soundID == 0) {
        CFURLRef url = (__bridge CFURLRef)[[NSBundle mainBundle] URLForResource:soundname withExtension:nil];
        
        if (url == NULL) return;
        
        AudioServicesCreateSystemSoundID(url, &soundID);
        
        // 将soundID存入字典
        [_soundIDs setObject:@(soundID) forKey:soundname];
    }
    
    // 3.播放音效
    AudioServicesPlaySystemSound(soundID);
}

@end

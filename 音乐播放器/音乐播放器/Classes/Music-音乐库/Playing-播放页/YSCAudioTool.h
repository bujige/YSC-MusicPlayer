//
//  YSCAudioTool.h
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/8.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface YSCAudioTool : NSObject

#pragma mark - 播放音乐
// 播放音乐 musicName : 音乐的名称
+ (AVAudioPlayer *)playMusicWithMusicName:(NSString *)musicName;
// 暂停音乐 musicName : 音乐的名称
+ (void)pauseMusicWithMusicName:(NSString *)musicName;
// 停止音乐 musicName : 音乐的名称
+ (void)stopMusicWithMusicName:(NSString *)musicName;

// 停止所有音乐
+ (void)stopAllMusic;
// 播放音乐 SongId : 歌曲的id SongFile : 歌曲文件地址
+ (AVPlayer *)playMusicWithSongId:(NSString *)songId songFile:(NSString *)songFile;
// 暂停音乐 SongId : 歌曲的id SongFile : 歌曲文件地址
+ (void)pauseMusicWithSongId:(NSString *)songId songFile:(NSString *)songFile;
// 停止音乐 SongId : 歌曲的id SongFile : 歌曲文件地址
+ (void)stopMusicWithSongId:(NSString *)songId songFile:(NSString *)songFile;


#pragma mark - 音效播放
// 播放声音文件soundName : 音效文件的名称
+ (void)playSoundWithSoundname:(NSString *)soundname;
@end

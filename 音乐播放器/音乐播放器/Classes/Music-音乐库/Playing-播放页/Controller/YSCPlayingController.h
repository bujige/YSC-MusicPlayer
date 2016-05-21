//
//  YSCPlayingController.h
//  音乐播放器
//
//  Created by YangLunlong on 16/5/16.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSCTypeMusic;
@class YSCType;

@interface YSCPlayingController : UIViewController

/** 歌单列表*/
@property (nonatomic, strong) NSMutableArray *type;

/** 选中某一行的歌曲 */
@property (nonatomic, strong) YSCTypeMusic *typeMusic;

@end

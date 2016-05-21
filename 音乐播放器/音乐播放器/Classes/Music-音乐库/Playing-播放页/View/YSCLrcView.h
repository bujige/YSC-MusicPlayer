//
//  YSCLrcView.h
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/10.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSCLrcLabel;

@interface YSCLrcView : UIScrollView

@property (nonatomic, copy) NSString *lrcName;

/** 当前播放的时间 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/** 外面歌词的Label */
@property (nonatomic, weak) YSCLrcLabel *lrcLabel;

/** 当前歌曲的总时长 */
@property (nonatomic, assign) NSTimeInterval duration;

@end

//
//  YSCPlayingController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/16.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCPlayingController.h"
#import "YSCTypeMusic.h"
#import "YSCMusic.h"
#import "YSCMusicTool.h"
#import "YSCAudioTool.h"
#import "NSString+YSCTimeExtension.h"
#import "CALayer+PauseAimate.h"
#import "YSCLrcView.h"
#import "YSCLrcLabel.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface YSCPlayingController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

// 滑块
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
// 歌词的View
@property (weak, nonatomic) IBOutlet YSCLrcView *lrcView;

// 歌词的Label
@property (weak, nonatomic) IBOutlet YSCLrcLabel *lrcLabel;

/** 进度的Timer */
@property (nonatomic, strong) NSTimer *progressTimer;

/** 歌词更新的定时器 */
@property (nonatomic, strong) CADisplayLink *lrcTimer;

/** 当前的播放器 */
@property (nonatomic, strong) AVPlayer *currentPlayer;


#pragma mark - slider的事件处理
- (IBAction)startSlide;
- (IBAction)sliderValueChange;
- (IBAction)endSlide;
- (IBAction)sliderClick:(UITapGestureRecognizer *)sender;

#pragma mark - 歌曲控制的事件处理
- (IBAction)playOrPause;
- (IBAction)previous;
- (IBAction)next;

@end

@implementation YSCPlayingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加毛玻璃效果
    [self setupBlurView];
    
    // 2.设置滑块的图片
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
    // 3.展示界面的信息
    [self startPlayingMusic];
    
    // 4.设置lrcView的ContentSize
    self.lrcView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.lrcView.lrcLabel = self.lrcLabel;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

- (void)setupBlurView
{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleBlack];
    [self.albumView addSubview:toolBar];
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.albumView);
    }];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // 设置iconView圆角
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 8.0;
    self.iconView.layer.borderColor = YSCRGBColor(36, 36, 36).CGColor;
}

#pragma mark - 开始播放音乐
- (void)startPlayingMusic
{
    // 停止所有音乐
    [YSCAudioTool stopAllMusic];
    // 2.设置界面信息
    [self.albumView sd_setImageWithURL:[NSURL URLWithString:self.typeMusic.songPicFile]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.typeMusic.songPicFile]];
    self.songLabel.text = self.typeMusic.title;     //playingMusic.name;
    self.singerLabel.text = self.typeMusic.singer;  // playingMusic.singer;

//    停止分类音乐——已在[YSCAudioTool stopAllMusic]中实现
//    for (YSCTypeMusic *obj in self.type) {
//        if (obj) {
//            [YSCAudioTool stopMusicWithSongId:obj.songId songFile:obj.songFile];
//        }
//    }
   
    AVPlayer *currentPlayer = [YSCAudioTool playMusicWithSongId:self.typeMusic.songId songFile:self.typeMusic.songFile];
    self.totalTimeLabel.text = [NSString stringWithCMTime:currentPlayer.currentItem.asset.duration];
    self.currentTimeLabel.text = [NSString stringWithCMTime:currentPlayer.currentTime];
    self.currentPlayer = currentPlayer;
    self.playOrPauseBtn.selected = YES;
    
//    self.lrcView.lrcName = self.typeMusic.lyricFile;
//    // 3.开始播放歌曲
//    AVAudioPlayer *currentPlayer = [YSCAudioTool playMusicWithMusicName:playingMusic.filename];
//    currentPlayer.delegate = self;
//    self.totalTimeLabel.text = [NSString stringWithTime:currentPlayer.duration];
//    self.currentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
//    self.currentPlayer = currentPlayer;
//    self.playOrPauseBtn.selected = self.currentPlayer.isPlaying;
//    
    // 4.设置歌词
    self.lrcView.lrcName = self.typeMusic.lyricFile;

    //刚开始 外界歌词label清空
    self.lrcLabel.text = @"";

    self.lrcView.duration = CMTimeGetSeconds(currentPlayer.currentItem.asset.duration);
    
    // 5.开始播放动画
    [self startIconViewAnimate];

    // 6.添加定时器用户更新进度界面
    [self removeProgressTimer];
    [self addProgressTimer];
    [self removeLrcTimer];
    [self addLrcTimer];
    
}

- (void)startIconViewAnimate
{
    // 1.创建基本动画
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 2.设置基本动画属性
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI * 2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration = 40;
    
    // 3.添加动画到图层上
    [self.iconView.layer addAnimation:rotateAnim forKey:nil];
}
- (IBAction)playOrPause {
    self.playOrPauseBtn.selected = !self.playOrPauseBtn.selected;
    
    if (!self.playOrPauseBtn.selected) {
        [self.currentPlayer pause];
        
        [self removeProgressTimer];
//        [self removeLrcTimer];
        
        // 暂停iconView的动画
        [self.iconView.layer pauseAnimate];
    } else {
        [self.currentPlayer play];
        
        [self addProgressTimer];
//        [self addLrcTimer];
        
        // 恢复iconView的动画
        [self.iconView.layer resumeAnimate];
    }
}

- (IBAction)previous {
    // 1.取出上一首歌曲
    NSInteger currentIndex = [self.type indexOfObject:self.typeMusic];
    
    // 2.取出上一首
    NSInteger previousIndex = --currentIndex;
    if (previousIndex < 0) {
        previousIndex = self.type.count - 1;
    }
    YSCTypeMusic *previousMusic = self.type[previousIndex];
    
    // 3.停止当前音乐
    [self.currentPlayer pause];
    [YSCAudioTool stopMusicWithSongId:previousMusic.songId songFile:previousMusic.songFile];
    
    self.typeMusic = previousMusic;
    
    // 2.播放上一首歌曲
    [self startPlayingMusic];
    
}

- (IBAction)next {
    // 1.拿到当前播放歌词下标值
    NSInteger currentIndex = [self.type indexOfObject:self.typeMusic];
    
    // 2.取出下一首
    NSInteger nextIndex = ++currentIndex;
    if (nextIndex >= self.type.count) {
        nextIndex = 0;
    }
    YSCTypeMusic *nextMusic = self.type[nextIndex];
    
    // 3.停止当前音乐
    [self.currentPlayer pause];
    [YSCAudioTool stopMusicWithSongId:nextMusic.songId songFile:nextMusic.songFile];
    
    self.typeMusic = nextMusic;
    
    // 4.播放下一首歌曲
    [self startPlayingMusic];
    
}

#pragma mark - 对定时器的操作
- (void)addProgressTimer
{
    [self updateProgressInfo];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    
}

- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)addLrcTimer
{
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeLrcTimer
{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

#pragma mark - 更新歌词
- (void)updateLrc
{
    self.lrcView.currentTime = CMTimeGetSeconds(self.currentPlayer.currentTime);
}

#pragma mark - 更新进度的界面
- (void)updateProgressInfo
{
    // 1.设置当前的播放时间
    self.currentTimeLabel.text = [NSString stringWithCMTime:self.currentPlayer.currentTime];
    
    // 2.更新滑块的位置
    self.progressSlider.value = CMTimeGetSeconds(self.currentPlayer.currentTime) / CMTimeGetSeconds(self.currentPlayer.currentItem.asset.duration);
}

#pragma mark - 实现UIScrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.获取到滑动多少
    CGPoint point = scrollView.contentOffset;
    
    // 2.计算滑动的比例
    CGFloat ratio = 1 - point.x / scrollView.bounds.size.width;
    
    // 3.设置iconView和歌词的Label的透明度
    self.iconView.alpha = ratio;
    self.lrcLabel.alpha = ratio;
}

#pragma mark - Slider的事件处理
- (IBAction)startSlide {
    [self removeProgressTimer];
}

- (IBAction)sliderValueChange {
    // 设置当前播放的时间Label
    self.currentTimeLabel.text = [NSString stringWithTime:CMTimeGetSeconds(self.currentPlayer.currentItem.asset.duration) * self.progressSlider.value];
}

- (IBAction)endSlide {
    // 1.设置歌曲的播放时间
//    self.currentPlayer.currentTime = self.progressSlider.value * self.currentPlayer.duration;
    CMTime currentCMTime = CMTimeMake(CMTimeGetSeconds(self.currentPlayer.currentItem.asset.duration) * self.progressSlider.value, 1);
    [self.currentPlayer seekToTime:currentCMTime];
     // 2.添加定时器
    [self addProgressTimer];
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    // 1.获取点击的位置
    CGPoint point = [sender locationInView:sender.view];
    
    // 2.获取点击的在slider长度中占据的比例
    CGFloat ratio = point.x / self.progressSlider.bounds.size.width;
    
    // 3.改变歌曲播放的时间
    CMTime currentCMTime = CMTimeMake(ratio * CMTimeGetSeconds(self.currentPlayer.currentItem.asset.duration), 1);
    [self.currentPlayer seekToTime:currentCMTime];
    
    // 4.更新进度信息
    [self updateProgressInfo];
}


@end

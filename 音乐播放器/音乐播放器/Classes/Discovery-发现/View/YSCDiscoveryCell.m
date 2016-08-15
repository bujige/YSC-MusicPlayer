//
//  YSCDiscoveryCell.m
//  音乐播放器
//
//  Created by YangLunlong on 16/6/3.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCDiscoveryCell.h"
#import "YSCDiscovery.h"
#import <BmobSDK/Bmob.h>
#import <UIImageView+WebCache.h>

@interface YSCDiscoveryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *musicImage;

@property (weak, nonatomic) IBOutlet UILabel *musicSinger;

@property (weak, nonatomic) IBOutlet UILabel *musicTitle;

@end

@implementation YSCDiscoveryCell

- (void)setDiscoveryMusic:(YSCDiscovery *)discoveryMusic
{
    _discoveryMusic = discoveryMusic;
    [self.musicImage sd_setImageWithURL:[NSURL URLWithString:discoveryMusic.songPicFile]];
    
    self.musicSinger.text = discoveryMusic.singer;
    self.musicTitle.text = discoveryMusic.title;
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

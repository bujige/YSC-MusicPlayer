//
//  YSCLoveCell.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/18.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLoveCell.h"
#import "YSCLove.h"
#import <UIImageView+WebCache.h>

@interface YSCLoveCell()

@property (weak, nonatomic) IBOutlet UIImageView *musicImage;

@property (weak, nonatomic) IBOutlet UILabel *musicSinger;

@property (weak, nonatomic) IBOutlet UILabel *musicTitle;
- (IBAction)cancelFavorite:(id)sender;

@end

@implementation YSCLoveCell

- (void)setLoveMusic:(YSCLove *)loveMusic
{
    _loveMusic = loveMusic;
    [self.musicImage sd_setImageWithURL:[NSURL URLWithString:loveMusic.songPicFile]];
    
    self.musicSinger.text = loveMusic.singer;
    self.musicTitle.text = loveMusic.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelFavorite:(id)sender {
}
@end

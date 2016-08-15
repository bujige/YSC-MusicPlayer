//
//  YSCLoveCell.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/18.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLoveCell.h"
#import "YSCLove.h"
#import <BmobSDK/Bmob.h>
#import <UIImageView+WebCache.h>

@interface YSCLoveCell()

@property (weak, nonatomic) IBOutlet UIImageView *musicImage;

@property (weak, nonatomic) IBOutlet UILabel *musicSinger;

@property (weak, nonatomic) IBOutlet UILabel *musicTitle;

@property (weak, nonatomic) IBOutlet UIButton *cancelFavoriteBtn;

- (IBAction)cancelFavorite:(id)sender;

@end

@implementation YSCLoveCell

- (void)setLoveMusic:(YSCLove *)loveMusic
{
    _loveMusic = loveMusic;
    [self.musicImage sd_setImageWithURL:[NSURL URLWithString:loveMusic.songPicFile]];
    self.cancelFavoriteBtn.selected = YES;
    self.musicSinger.text = loveMusic.singer;
    self.musicTitle.text = loveMusic.title;
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

- (IBAction)cancelFavorite:(id)sender {
    
    BmobUser *bUser = [BmobUser getCurrentUser];
    
    BmobObject *music = [BmobObject objectWithoutDatatWithClassName:@"_User" objectId:bUser.objectId];
    
    BmobRelation *relation = [[BmobRelation alloc] init];
    [relation removeObject:[BmobObject objectWithoutDatatWithClassName:@"LikeMusic" objectId:self.loveMusic.objectId]];
    
    [music addRelation:relation forKey:@"likes"];
    
    [music updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"successful");
            self.cancelFavoriteBtn.selected = NO;
        }else{
            NSLog(@"error %@",[error description]);
        }
    }];
    
}
@end

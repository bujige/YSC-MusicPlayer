//
//  YSCTypeMusicCell.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/16.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCTypeMusicCell.h"
#import "YSCTypeMusic.h"
#import <BmobSDK/Bmob.h>
#import <UIImageView+WebCache.h>
#import "YSCLoginRegisterViewController.h"

@interface YSCTypeMusicCell()

@property (weak, nonatomic) IBOutlet UIImageView *musicImage;

@property (weak, nonatomic) IBOutlet UILabel *musicSinger;

@property (weak, nonatomic) IBOutlet UILabel *musicTitle;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

- (IBAction)favorite:(id)sender;

@end

@implementation YSCTypeMusicCell

- (void)awakeFromNib {
    
}

- (void)setTypeMusic:(YSCTypeMusic *)typeMusic
{
    _typeMusic = typeMusic;
    [self.musicImage sd_setImageWithURL:[NSURL URLWithString:typeMusic.songPicFile]];
    
    self.musicSinger.text = typeMusic.singer;
    self.musicTitle.text = typeMusic.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favorite:(id)sender {
    
    BmobUser *bUser = [BmobUser getCurrentUser];
    if (bUser) {
        NSString *bUserObjectId = [NSString stringWithFormat:@"%@",bUser.objectId];
        BmobObject *user = [BmobObject objectWithoutDatatWithClassName:@"_User" objectId:bUserObjectId];
        
        BmobQuery  *bquery = [BmobQuery queryWithClassName:@"Music"];
        
        [bquery whereKey:@"songId" equalTo:self.typeMusic.songId];
        BmobRelation *relation = [[BmobRelation alloc] init];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                // 得到 songId 对应的音乐行 obj   user对应行 bUser
                [relation addObject:obj];
                
                [user addRelation:relation forKey:@"likes"];
                //异步更新obj的数据
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        NSLog(@"successful");
                    }else{
                        NSLog(@"error %@",[error description]);
                    }
                }];
            }
        }];
        
        self.favoriteBtn.selected = YES;
        
    }else{
        YSCLog(@"请登录后再收藏");
    }
}

@end

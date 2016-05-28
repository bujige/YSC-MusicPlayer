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
//    BmobUser *bUser = [BmobUser getCurrentUser];
//    if (bUser) {
//        NSString *bUserObjectId = [NSString stringWithFormat:@"%@",bUser.objectId];
//        BmobObject *user = [BmobObject objectWithoutDatatWithClassName:@"_User" objectId:bUserObjectId];
//        
//        BmobQuery  *bquery = [BmobQuery queryWithClassName:@"Music"];
//        
//        [bquery whereKey:@"songId" equalTo:self.typeMusic.songId];
//        BmobRelation *relation = [[BmobRelation alloc] init];
//        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//            for (BmobObject *obj in array) {
//                // 得到 songId 对应的音乐行 obj   user对应行 bUser
//                [relation addObject:obj];
//                
//                [user addRelation:relation forKey:@"likes"];
//                //异步更新obj的数据
//                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                    if (isSuccessful) {
//                        NSLog(@"successful");
//                    }else{
//                        NSLog(@"error %@",[error description]);
//                    }
//                }];
//            }
//        }];
//        
//        self.favoriteBtn.selected = YES;
//    
//    }else{
//        YSCLog(@"请登录后再收藏");
//    }

    
}
@end

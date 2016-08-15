//
//  YSCLoveController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/18.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLoveController.h"
#import "YSCLoveCell.h"
#import "YSCLove.h"
#import "YSCPlayingController.h"
#import <BmobSDK/Bmob.h>

@interface YSCLoveController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 音乐列表数据 */
@property (nonatomic, strong) NSMutableArray *loveMusics;

@end

static NSString * const YSCLoveCellId = @"loveMusic";

@implementation YSCLoveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self setupTableView];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     [self loadNewLoveMusics];
}

- (void)setup
{
    // 设置导航栏标题
    self.navigationItem.title = @"喜  欢";
    
    // 设置背景色
    self.view.backgroundColor = YSCGlobalBg;
    
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YSCLoveCell class]) bundle:nil] forCellReuseIdentifier:YSCLoveCellId];
}

- (NSMutableArray *)loveMusics
{
    if (!_loveMusics) {
        _loveMusics = [NSMutableArray array];
    }
    return _loveMusics;
}


-(void)loadNewLoveMusics
{
    [self.loveMusics removeAllObjects];
    
    BmobUser *bUser = [BmobUser getCurrentUser];

    if (!bUser) {
         YSCLog(@"请登录后显示收藏");
        [self.tableView reloadData];
        return;
    }
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"LikeMusic"];
        
        [bquery whereObjectKey:@"likes" relatedTo:bUser];
        
        //按updatedAt进行降序排列
        [bquery orderByDescending:@"singer"];
        
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            } else {
                for (BmobObject *obj in array) {
                    YSCLove *loveMusic  = [[YSCLove alloc] init];
                    loveMusic.title = [obj objectForKey:@"title"];
                    loveMusic.singer  = [obj objectForKey:@"singer"];
                    loveMusic.songId = [obj objectForKey:@"songId"];
                    BmobFile *songPicFile = (BmobFile*)[obj objectForKey:@"songPicFile"];
                    loveMusic.songPicFile = songPicFile.url;
                    BmobFile *songFile = (BmobFile*)[obj objectForKey:@"songFile"];
                    loveMusic.songFile = songFile.url;
                    loveMusic.lyric = (BmobFile*)[obj objectForKey:@"lyricFile"];
                    loveMusic.lyricFile = loveMusic.lyric.url;
                    loveMusic.lyric.name = [[NSString alloc] initWithFormat:@"%@.lrc",loveMusic.songId];
                    loveMusic.objectId = obj.objectId;
                    [self.loveMusics addObject:loveMusic];
//                    NSLog(@"%@",loveMusic);
//                    NSLog(@"%@",self.loveMusics.count);
//                    NSLog(@"%@",obj);
                }
                [self.tableView reloadData];
            }
        }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loveMusics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:YSCLoveCellId];
    cell.loveMusic = self.loveMusics[indexPath.row];
    NSLog(@"%@",self.loveMusics[indexPath.row]);
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCPlayingController *playingVc = [[YSCPlayingController alloc] init];
    
    playingVc.type = self.loveMusics;
    playingVc.typeMusic = self.loveMusics[indexPath.row];
    [self.navigationController pushViewController:playingVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end

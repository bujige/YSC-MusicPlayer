//
//  YSCTypeMusicController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/16.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCMusicController.h"
#import "YSCTypeMusicController.h"
#import "YSCTypeMusicCell.h"
#import "YSCTypeMusic.h"
#import "YSCType.h"
#import "YSCPlayingController.h"
#import <BmobSDK/Bmob.h>

@interface YSCTypeMusicController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 音乐列表数据 */
@property (nonatomic, strong) NSMutableArray *typeMusics;


@end

static NSString * const YSCTypeMusicCellId = @"typeMusic";

@implementation YSCTypeMusicController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    
    [self loadNewTypes];
}

- (NSMutableArray *)typeMusics
{
    if (!_typeMusics) {
        _typeMusics = [NSMutableArray array];
    }
    return _typeMusics;
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YSCTypeMusicCell class]) bundle:nil] forCellReuseIdentifier:YSCTypeMusicCellId];

}

- (void)loadNewTypes
{
    [self.typeMusics removeAllObjects];
    
    NSString *className = @"Music";
    //创建BmobQuery实例，指定对应要操作的数据表名称
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    
    //添加 itemType是self.type.name的约束条件
    [query whereKey:@"itemType" equalTo:self.type.name];
    //按updatedAt进行降序排列
    [query orderByDescending:@"singer"];
    //返回最多20个结果
    query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //处理查询结果
        for (BmobObject *obj in array) {
            YSCTypeMusic *typeMusic  = [[YSCTypeMusic alloc] init];
            typeMusic.title = [obj objectForKey:@"title"];
            typeMusic.singer  = [obj objectForKey:@"singer"];
            typeMusic.songId = [obj objectForKey:@"songId"];
            BmobFile *songPicFile = (BmobFile*)[obj objectForKey:@"songPicFile"];
            typeMusic.songPicFile = songPicFile.url;
            BmobFile *songFile = (BmobFile*)[obj objectForKey:@"songFile"];
            typeMusic.songFile = songFile.url;
            typeMusic.lyric = (BmobFile*)[obj objectForKey:@"lyricFile"];
            typeMusic.lyricFile = typeMusic.lyric.url;
            typeMusic.lyric.name = [[NSString alloc] initWithFormat:@"%@.lrc",typeMusic.songId];

            [self.typeMusics addObject:typeMusic];
        }
        [self.tableView reloadData];
    }];

}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeMusics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCTypeMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:YSCTypeMusicCellId];
    cell.typeMusic = self.typeMusics[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCPlayingController *playingVc = [[YSCPlayingController alloc] init];
    
    playingVc.type = self.typeMusics;
    playingVc.typeMusic = self.typeMusics[indexPath.row];
    [self.navigationController pushViewController:playingVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end

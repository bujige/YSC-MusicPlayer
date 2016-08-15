//
//  YSCDiscoveryController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCDiscoveryController.h"
#import "YSCDiscoveryCell.h"
#import "YSCDiscovery.h"
#import "YSCPlayingController.h"
#import <BmobSDK/Bmob.h>

@interface YSCDiscoveryController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 音乐列表数据 */
@property (nonatomic, strong) NSMutableArray *discoveryMusics;

@property (nonatomic, strong) NSMutableArray *arr;

@end

static NSString * const YSCDiscoveryCellId = @"discoveryMusic";

@implementation YSCDiscoveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self setSongsList];
    
}

- (void)setup
{
    // 设置导航栏标题
    self.navigationItem.title = @"发  现";

    // 设置背景色
    self.view.backgroundColor = YSCGlobalBg;
    
}


- (NSMutableArray *)discoveryMusics
{
    if (!_discoveryMusics) {
        _discoveryMusics = [NSMutableArray array];
    }
    return _discoveryMusics;
}

- (NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YSCDiscoveryCell class]) bundle:nil] forCellReuseIdentifier:YSCDiscoveryCellId];
}

- (void)setSongsList
{
    if (self.arr.count != 0 ) {
        return;
    }
    
    for (int i = 0; i < 20; ) {
        int typeId = arc4random() % 3;
        int musicId = arc4random() % 20 + 1;
        NSString *songId = [NSString stringWithFormat:@"%02d%03d",typeId,musicId];
        
        if ([self.arr containsObject:songId] == NO) {
            [self.arr addObject:songId];
            i++;
        }
    }
    
    [self.discoveryMusics removeAllObjects];
    
    for (int i = 0; i < 20; i++) {
        NSString *songId = self.arr[i];
     
        NSString *className = @"Music";
        //创建BmobQuery实例，指定对应要操作的数据表名称
        BmobQuery *query = [BmobQuery queryWithClassName:className];
        
        //添加 itemType是self.type.name的约束条件
        [query whereKey:@"songId" equalTo:songId];
        //按updatedAt进行降序排列
        [query orderByDescending:@"singer"];
        //返回最多20个结果
        query.limit = 20;
        //执行查询
        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            //处理查询结果
            for (BmobObject *obj in array) {
                YSCDiscovery *discoveryMusic  = [[YSCDiscovery alloc] init];
                discoveryMusic.title = [obj objectForKey:@"title"];
                discoveryMusic.singer  = [obj objectForKey:@"singer"];
                discoveryMusic.songId = [obj objectForKey:@"songId"];
                BmobFile *songPicFile = (BmobFile*)[obj objectForKey:@"songPicFile"];
                discoveryMusic.songPicFile = songPicFile.url;
                BmobFile *songFile = (BmobFile*)[obj objectForKey:@"songFile"];
                discoveryMusic.songFile = songFile.url;
                discoveryMusic.lyric = (BmobFile*)[obj objectForKey:@"lyricFile"];
                discoveryMusic.lyricFile = discoveryMusic.lyric.url;
                discoveryMusic.lyric.name = [[NSString alloc] initWithFormat:@"%@.lrc",discoveryMusic.songId];
                
                [self.discoveryMusics addObject:discoveryMusic];
            }
            [self.tableView reloadData];
        }];
    }
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discoveryMusics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCDiscoveryCell *cell = [tableView dequeueReusableCellWithIdentifier:YSCDiscoveryCellId];
    cell.discoveryMusic = self.discoveryMusics[indexPath.row];
    NSLog(@"%@",self.discoveryMusics[indexPath.row]);
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCPlayingController *playingVc = [[YSCPlayingController alloc] init];
    
    playingVc.type = self.discoveryMusics;
    playingVc.typeMusic = self.discoveryMusics[indexPath.row];
    [self.navigationController pushViewController:playingVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end

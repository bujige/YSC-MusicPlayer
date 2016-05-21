//
//  YSCMusicController.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCMusicController.h"
#import "YSCTypeCell.h"
#import "YSCType.h"
#import "YSCTypeMusicController.h"
#import <BmobSDK/Bmob.h>

@interface YSCMusicController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 分类数据 */
@property (nonatomic, strong) NSMutableArray *types;

@end

static NSString * const YSCTypeCellId = @"type";

@implementation YSCMusicController

- (NSMutableArray *)types
{
    if (!_types) {
        _types = [NSMutableArray array];
    }
    return _types;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
 
    [self loadNewTypes];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YSCTypeCell class]) bundle:nil] forCellReuseIdentifier:YSCTypeCellId];
}

- (void)loadNewTypes
{
    [self.types removeAllObjects];
    
    NSString *className = @"Type";
    //创建BmobQuery实例，指定对应要操作的数据表名称
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    //按updatedAt进行降序排列
    [query orderByDescending:@"name"];
    //返回最多20个结果
    query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //处理查询结果
        for (BmobObject *obj in array) {
            YSCType *type  = [[YSCType alloc] init];
            type.name = [obj objectForKey:@"name"];
            type.text  = [obj objectForKey:@"text"];
            type.ding = [obj objectForKey:@"ding"];
            BmobFile *file = (BmobFile*)[obj objectForKey:@"image"];
            type.image = file.url;
            [self.types addObject:type];
        }
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.types.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:YSCTypeCellId];
    cell.type = self.types[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSCTypeMusicController *typeMusicVc = [[YSCTypeMusicController alloc] init];

    typeMusicVc.type = self.types[indexPath.row];
    [self.navigationController pushViewController:typeMusicVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end

//
//  YSCLrcCell.h
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/10.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSCLrcLabel;

@interface YSCLrcCell : UITableViewCell

@property (nonatomic, weak, readonly) YSCLrcLabel *lrcLabel;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;

@end

//
//  YSCLrcCell.m
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/10.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLrcCell.h"
#import "YSCLrcLabel.h"
#import <Masonry.h>

@implementation YSCLrcCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        YSCLrcLabel *lrcLabel = [[YSCLrcLabel alloc] init];
        lrcLabel.textColor = [UIColor whiteColor];
        lrcLabel.backgroundColor = [UIColor clearColor];
        lrcLabel.font = [UIFont systemFontOfSize:14.0];
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lrcLabel];
        _lrcLabel = lrcLabel;
        lrcLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LrcCell";
    YSCLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YSCLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}
@end

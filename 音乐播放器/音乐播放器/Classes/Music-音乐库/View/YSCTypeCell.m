//
//  YSCTypeCell.m
//  音乐播放器
//
//  Created by YangLunlong on 16/5/15.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCTypeCell.h"
#import "YSCType.h"
#import <BmobSDK/Bmob.h>
#import <UIImageView+WebCache.h>

@interface YSCTypeCell()

/** 分类图片 */
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;

/** 分类名称 */
@property (weak, nonatomic) IBOutlet UILabel *typeName;

/** 分类顶数 */
@property (weak, nonatomic) IBOutlet UILabel *typeDing;

/** 分类说明 */
@property (weak, nonatomic) IBOutlet UILabel *typeText;

@end

@implementation YSCTypeCell

- (void)awakeFromNib {
    
}

- (void)setType:(YSCType *)type
{
    _type = type;
    [self.typeImage sd_setImageWithURL:[NSURL URLWithString:type.image]];
    self.typeName.text = type.name;
    self.typeDing.text = type.ding;
    self.typeText.text = type.text;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

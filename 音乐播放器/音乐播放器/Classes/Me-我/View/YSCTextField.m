//
//  YSCTextField.m
//  YSC-百思不得姐
//
//  Created by YangLunlong on 16/4/27.
//  Copyright © 2016年 杨世超. All rights reserved.
//

#import "YSCTextField.h"

@implementation YSCTextField

- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

-(BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end

//
//  YSCLrcTool.m
//  YSC-音乐播放器
//
//  Created by YangLunlong on 16/5/10.
//  Copyright © 2016年 lianai911. All rights reserved.
//

#import "YSCLrcTool.h"
#import "YSCLrcline.h"
#import <BmobSDK/Bmob.h>

@implementation YSCLrcTool

+ (NSArray *)lrcToolWithLrcName:(NSString *)lrcName
{
    // 1.拿到歌词文件的路径
    NSURL *url = [NSURL URLWithString:lrcName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData   *data = [NSURLConnection sendSynchronousRequest:request
                                           returningResponse:nil
                                            error:&error];

    if (data != nil){
        
        NSLog(@"下载成功");
        
        if ([data writeToFile:@"DFADFADF" atomically:YES]) {
            NSLog(@"保存成功.");
        }
        else
        {
            NSLog(@"保存失败.");
        }
        
    } else {
        NSLog(@"%@", error);
    }
    
    NSLog(@"成功取到歌词文件");
//    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    
    // 2.读取歌词
    NSString *lrcString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // 3.拿到歌词的数组
    NSArray *lrcArray = [lrcString componentsSeparatedByString:@"\n"];
    
    // 4.遍历每一句歌词,转成模型
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *lrclineString in lrcArray) {
        // 拿到每一句歌词
        /*
         [ti:心碎了无痕]
         [ar:张学友]
         [al:]
         */
        
        NSLog(@"%@",lrclineString);
        // 过滤不需要的歌词的行
        if (![lrclineString hasPrefix:@"[0"] && ![lrclineString hasPrefix:@"[1"] && ![lrclineString hasPrefix:@"[2"] && ![lrclineString hasPrefix:@"[3"] && ![lrclineString hasPrefix:@"[4"] && ![lrclineString hasPrefix:@"[5"] && ![lrclineString hasPrefix:@"[6"] && ![lrclineString hasPrefix:@"[7"] && ![lrclineString hasPrefix:@"[9"]) {
//            [lrclineString hasPrefix:@"[ti:"] || [lrclineString hasPrefix:@"[ar:"] || [lrclineString hasPrefix:@"[al:"] ||
//            [lrclineString hasPrefix:@"[by:"] || ![lrclineString hasPrefix:@"["] || [lrclineString hasPrefix:@"[Intro/Chorus"] || [lrclineString hasPrefix:@"[offset:"])
            continue;
        }
        
        // 将歌词转成模型
        YSCLrcline *lrcLine = [YSCLrcline lrcLineWithLrclineString:lrclineString];
        [tempArray addObject:lrcLine];
    }
    
    return tempArray;
}

@end

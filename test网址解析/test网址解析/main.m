//
//  main.m
//  test网址解析
//
//  Created by qianfeng001 on 15/6/17.
//  Copyright (c) 2015年 qianfeng001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXParse.h"
#define PATH1 @"http://223.6.252.214/weibofun/weibo_list.php?apiver=10500&category=weibo_pics&page=0&page_size=30&max_timestamp=-1"
#define PATH2 @"http://mps.manzuo.com/mps/cate?sid=%28null%29&id=0&cc=beijing&pt=all&ffst=0&mnt=15&st=-1&hs=1"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //[WXParse testJson:PATH1];
        [WXParse testXml:PATH2];
    }
    return 0;
}

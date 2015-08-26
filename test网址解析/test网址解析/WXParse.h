//
//  WXParse.h
//  test网址解析
//
//  Created by qianfeng001 on 15/6/17.
//  Copyright (c) 2015年 qianfeng001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXParse : NSObject
@property NSString*name1;
@property NSString*name2;
@property NSString*name3;
@property NSString*name4;
@property NSString*name5;

+(void)testJson:(NSString*)file;
+(void)testXml:(NSString*)file;
@end

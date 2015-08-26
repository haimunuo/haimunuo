//
//  MyHttpDownload.h
//  yishu
//
//  Created by yishu on 15/5/23.
//  Copyright (c) 2015年 ZKK. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "Base64.h"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
@interface MyHttpDownload : NSObject

+(void) GetDownload:(NSString *)urlpath param:(NSDictionary *)dict finish:( void (^)(NSData *data,NSDictionary *obj, NSError *error))cb;

//+(void) POSTYiShuUrl:(NSString *)urlpath param:(NSDictionary *)dict isSynchronized:(BOOL)isSynchronized image:(UIImage *)image finish:(void(^)(NSData *data,NSDictionary *obj,NSError *error))cb;
+ (NSString *)GetIPAddress:(BOOL)preferIPv4;
+(NSDictionary *)GetIPAddresses;
@end

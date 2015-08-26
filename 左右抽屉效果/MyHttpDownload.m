
//
//  MyHttpDownload.m
//  yishu
//
//  Created by yishu on 15/5/23.
//  Copyright (c) 2015年 ZKK. All rights reserved.
//

#import "MyHttpDownload.h"
#import "AFNetworking.h"

static BOOL isFirst = NO;
static BOOL canCheckNetwork = NO;
@implementation MyHttpDownload
+(void) GetDownload:(NSString *)urlpath param:(NSDictionary *)dict finish:(void (^)(NSData *,NSDictionary *obj, NSError *))cb{
    
    //1..检查网络连接(苹果公司提供的检查网络的第三方库 Reachability)
    //AFN 在 Reachability基础上做了一个自己的网络检查的库, 基本上一样
    
    if (isFirst == NO) {
        //网络只有在startMonitoring完成后才可以使用检查网络状态
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            canCheckNetwork = YES;
        }];
        isFirst = YES;
    }
    
    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    //BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    //BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    //网络有问题
    if(isOK == NO && canCheckNetwork == YES){
        NSError *error = [NSError errorWithDomain:@"网络错位" code:100 userInfo:nil];
        cb(nil, nil,error);
        return;
    }
    
    //2..实现解析
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlpath parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        //成功 cb是对方传递过来的对象 这里是直接调用
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        cb(responseObject, obj ,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        cb(nil, nil ,error);
    }];
};
//asynchronous ; nonsynchronous ; synchronization（同步）
+ (void)POSTYiShuUrl:(NSString *)urlpath param:(NSDictionary *)dict isSynchronized:(BOOL)isSynchronized image:(UIImage *)image finish:(void (^)(NSData *, NSDictionary *, NSError *))cb{
    //1..检查网络连接(苹果公司提供的检查网络的第三方库 Reachability)
    //AFN 在 Reachability基础上做了一个自己的网络检查的库, 基本上一样
    
    if (isFirst == NO) {
        //网络只有在startMonitoring完成后才可以使用检查网络状态
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            canCheckNetwork = YES;
        }];
        isFirst = YES;
    }
    
    //只能在监听完善之后才可以调用
    BOOL isOK = [[AFNetworkReachabilityManager sharedManager] isReachable];
    //BOOL isWifiOK = [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
    //BOOL is3GOK = [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
    //网络有问题
    if(isOK == NO && canCheckNetwork == YES){
        NSError *error = [NSError errorWithDomain:@"网络错位" code:100 userInfo:nil];
        cb(nil, nil,error);
        return;
    }

    
    NSData *tempdata = UIImageJPEGRepresentation(image,0.1);
    
    if (tempdata.length*5<200000) {
        tempdata =UIImageJPEGRepresentation(image,0.5);
    }
    NSString *aString = [tempdata base64EncodedString];
    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)aString,
                                                                                         NULL,
                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                         kCFStringEncodingUTF8);
    NSMutableDictionary *mulDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [mulDict setObject:baseString forKey:@"image"];
    
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlpath] cachePolicy:0 timeoutInterval:2.0f];
    ;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mulDict options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonData1=[NSString stringWithFormat:@"data=%@",jsonString];
    NSData *data1 = [jsonData1 dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody=data1;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    // 3> 连接服务器发送请求
    //            nsdata
    
    if (isSynchronized) {
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        cb(data,obj,nil);
    }else{
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            cb(data,obj,nil);
        }];
    }
    
}


+ (NSString *)GetIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self GetIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+(NSDictionary *)GetIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
       // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
    return [addresses count] ? addresses : nil;
}
/*
 NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 NSDictionary *resultdict = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
 NSLog(@"received-----%@dict%@",resultdict[@"result"],resultdict);
 _headImageSuccess = resultdict[@"result"];
 */
@end

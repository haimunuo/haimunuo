//
//  main.m
//  点语法
//
//  Created by Jerry on 15-5-8.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYHuman.h"
#import "JYHuman+zkk.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        id laoWang = [[JYHuman alloc] init];
        
        //[laoWang setAge:50];
        ((JYHuman *)laoWang).age = 50;//等价于上式
        
        //int age = [laoWang age];
        int age = ((JYHuman *)laoWang).age;//等价于上式
        
        NSLog(@"age = %d", age);
        [laoWang printName];
        
        JYHuman *xiaoWang = [[JYHuman alloc] init];
        //xiaoWang.sex = 2;
        int sex = xiaoWang.sex;
    
        xiaoWang.height = 200;
        [xiaoWang addname];
        NSLog(@"%ld",xiaoWang.age);
    }
    return 0;
}

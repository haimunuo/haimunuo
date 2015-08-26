//
//  JYHuman.m
//  点语法
//
//  Created by Jerry on 15-5-8.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import "JYHuman.h"

@implementation JYHuman

@synthesize age;// = _name;
//这个式子相当实现了_age的setter和getter方法
//若不指定age，则默认为_age

- (void)setAge:(int)age
{
    _age = age;
    //self.age = age;
    NSLog(@"我是自己实现的");
}

//- (int)age
//{
//    return _age;
//}

- (void)printName
{
    NSLog(@"name = %d", _name);
}

- (void)setShengao:(int)shengao
{
    _height = shengao;
    NSLog(@"I am in setShengao:");
}

@end

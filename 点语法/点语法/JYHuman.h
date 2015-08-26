//
//  JYHuman.h
//  点语法
//
//  Created by Jerry on 15-5-8.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYHuman : NSObject
{
    int _name;
    int _age;
}
//- (void)setAge:(int)age;
//- (int)age;

@property int age;
//这个式子相当于声明了_age的setter和getter方法
//并且自动实现了这两个方法
- (void)printName;

//属性修饰符
@property (readonly) int sex;
//只有getter方法，没有setter方法

@property (readwrite, setter=setShengao:) int height;
//setHeight:  ===> setShengao:
//默认属性，getter和setter方法都有

@property (atomic) NSString *company;
//原子操作，不能被打断，默认属性

@property (nonatomic) NSString *degree;
//非原子操作，iOS开发中为了提高效率，经常使用

@property (assign, nonatomic) NSString *address;
//直接赋值，不需要内存管理


@end

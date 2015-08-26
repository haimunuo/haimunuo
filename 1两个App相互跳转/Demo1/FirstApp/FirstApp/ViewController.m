//
//  ViewController.m
//  FirstApp
//
//  Created by LZXuan on 15-8-4.
//  Copyright (c) 2015年 轩哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    //点击按钮 实现 app 间的跳转
    //app间的跳转 都用 openURL:函数
    //只需要 被跳转的app 需要制定协议 scheme
    //打电话应用 协议 @"tel://"
    //   短信应用    @"sms://"
    //自定义的app A 要被其他app B调用 那么A也需要制定协议，对方B只需要知道A制定协议就可以调用A
    //协议的功能:规范接口，实现通信
    
    //判断 是否 可以打开 url 对应的app
    //写上 协议 LZXSecondTest
    //把要传给另外一个app 的内容写入字符串
    //url-》格式  协议://主机?参数
    
    NSString *str = [NSString stringWithFormat:@"LZXSecondTest://myhost?a=123&text=%@",self.textField.text];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
        //调用另外app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    
}
@end









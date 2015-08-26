//
//  ViewController.m
//  SecondApp
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
    //返回 firstApp
    NSString *str = [NSString stringWithFormat:@"LZXFirstTest://%@",self.textField.text];
    //
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
        //调用 firstApp
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
@end












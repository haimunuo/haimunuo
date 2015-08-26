//
//  RootViewController.m
//  B_App
//
//  Created by LZXuan on 15-1-26.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"B_App";
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(60, 100, 200, 50);
    [button setTitle:@"跳转到A_App中第二个界面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}
- (void)btnClick:(UIButton *)btn {
    //
    NSString *url = @"ATest://com.second?a=1&b=2&c=中文";
    //通过OPen URL 调用A_App的 直接跳转到A_App中的第二个界面
    //如果url 有非法字符需要转换
    NSString *newUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:newUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newUrl]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

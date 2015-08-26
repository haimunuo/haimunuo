//
//  ViewController.m
//  ZbarDemo
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 ZKK. All rights reserved.
//

#import "ViewController.h"

#import "ZCZBarViewController.h"

#import "QRCodeGenerator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    btn.frame=CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *imagerView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    //生成二维码声明的文字，第二个是清晰度
    imagerView.image=[QRCodeGenerator qrImageForString:@"该吃饭了" imageSize:300];
    imagerView.userInteractionEnabled=YES;
    
    UIImageView *imagerViewConter=[[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 40, 40)];
    imagerViewConter.center=imagerView.center;
    imagerViewConter.backgroundColor=[UIColor blackColor];
    [self.view addSubview:imagerViewConter];

    [self.view addSubview:imagerView];
}
-(void)btnClick{
ZCZBarViewController *zbar=[[ZCZBarViewController alloc]initWithBlock:^(NSString *str, BOOL isSucceed) {
    if (isSucceed ) {
        NSLog(@"扫描成功");
    }else{
        NSLog(@"扫描失败");
    }
    
}];
    [self presentViewController:zbar animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

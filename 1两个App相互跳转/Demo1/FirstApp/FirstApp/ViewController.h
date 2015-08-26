//
//  ViewController.h
//  FirstApp
//
//  Created by LZXuan on 15-8-4.
//  Copyright (c) 2015年 轩哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)btnClick:(id)sender;


@end


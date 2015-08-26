//
//  ViewController.m
//  TCPDemo
//
//  Created by qianfeng on 15/8/13.
//  Copyright (c) 2015年 凯哥. All rights reserved.
//

#import "ViewController.h"
#import "AsyncSocket.h"
@interface ViewController ()<AsyncSocketDelegate,UITextFieldDelegate>
{

    UITextView *_textView;
    UITextField *_textField;
    
    //建立发送端
    AsyncSocket *sendSocket;
     //建立服务端
    AsyncSocket *severSocket;
    
}

@property(nonatomic,strong)NSMutableArray *socketArr;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     建立群聊，学生端向发送消息，教师端显示消息
     */
    
    self.socketArr=[[NSMutableArray alloc]init];
    
    [self createScoket];
    //创建界面
    [self createView];
    //定时器 ，每隔10清理一次
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(clearTexteView) userInfo:nil repeats:YES];
}
-(void)clearTexteView{
    _textView.text=@"";
}
-(void)createView{
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
    _textView.backgroundColor=[UIColor blackColor];
    _textView.textColor=[UIColor whiteColor];
    
    [self.view addSubview:_textView];
    
    
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, 44)];
    _textField.backgroundColor=[UIColor redColor];
    _textField.delegate=self;
    [self.view addSubview:_textField];

}
#pragma mark-核心部分
-(void)createScoket{
    sendSocket=[[AsyncSocket alloc]initWithDelegate:self];
    severSocket=[[AsyncSocket alloc]initWithDelegate:self];
    //服务端绑定端口，监听该接口数据
    /*
     端口最大为65535 ，其中建议设置5000以上，另外还有特殊的端口，例如8080为视频端口，建议不占用
     */
    [severSocket acceptOnPort:5678 error:nil];
    
}
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    
    //接受的一个新的连接，这个连接保存一下，然后持续保持连接；
    [self.socketArr addObject:newSocket];
    //-1表示持续观察，如果设置300，表示三百秒后不在观察
    [newSocket readDataWithTimeout:-1 tag:100];
    
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    //接受到的数据
    NSString *message=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (_textView) {
        //在原来的旧数据，追加新的数据
        
        _textView.text=[NSString stringWithFormat:@"%@\n%@",_textView.text,message];
    }
    
    [sock readDataWithTimeout:-1 tag:100];
    
    
    
}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    //接受成功
}
#pragma mark-textField协议
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //发送数据
    if (textField.text.length>0) {
        //确定是否连接
        if (![sendSocket isConnected]) {
            //
            [sendSocket connectToHost:@"10.8.155.190" onPort:5678 error:nil];
        }
        //当连接完成以后 发送数据，拼接数据是谁的，希望获得当前设备名称
//        [[UIDevice currentDevice]systemName];该方法在真机有效
        NSString *message=[NSString stringWithFormat:@"%@说:%@\n",@"凯哥",textField.text];
        [sendSocket writeData:[message dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:100];
        
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

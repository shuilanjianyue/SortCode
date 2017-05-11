//
//  ConnectionController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ConnectionController.h"

#define LIST_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"

#define LIST_URL_POST @"http://new.api.bandu.cn/book/listofgrade"

@interface ConnectionController ()
@property(nonatomic,strong)NSMutableData *datas;

@end

@implementation ConnectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"NSURLConnection";
    
    //[self sync];
   // [self asyncBlock];
    
   // [self asyncDelegate];
    
    [self post];
    
    // Do any additional setup after loading the view.
}

#pragma mark - post
- (void)post{
    //1.创建NSURL对象
    NSURL *url = [NSURL URLWithString:LIST_URL_POST];
    //2.创建NSURLRequest，默认请求方式是GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //修改请求方式
    request.HTTPMethod = @"POST";
    //在请求体中 添加请求数据
    request.HTTPBody = [@"grad_ide=2" dataUsingEncoding:NSUTF8StringEncoding];
    
    //3.使用NSURKConnection发送请求
    // [[NSOperationQueue alloc]init];非主队列
    // [NSOperationQueue mainQueue]  主队列
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError == nil) {
            
            NSLog(@"%@",response);
            
            
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",string);
        }else{
            NSLog(@"%@",connectionError);
        }
        //打印当前队列
        NSLog(@"currentThread= %@",[NSThread currentThread]);
        
    }];
    
    
}
#pragma mark - 异步请求
- (void)asyncBlock{
   //1 block回调  2 代理
    //1 block
    
    //1.创建NSURL对象
    NSURL *url = [NSURL URLWithString:LIST_URL];
    //2.创建NSURLRequest，默认请求方式是GET
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.使用NSURKConnection发送请求
    // [[NSOperationQueue alloc]init];非主队列
    // [NSOperationQueue mainQueue]  主队列
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError == nil) {
            
            NSLog(@"%@",response);
            
            
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",string);
        }else{
            NSLog(@"%@",connectionError);
        }
        //打印当前队列
        NSLog(@"currentThread= %@",[NSThread currentThread]);
        
    }];
    
   

}


#pragma mark - 代理请求
- (void)asyncDelegate{
    //1 block回调  2 代理
    //1 block
    
    //1.创建NSURL对象
    NSURL *url = [NSURL URLWithString:LIST_URL];
    //2.创建NSURLRequest，默认请求方式是GET
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.使用NSURKConnection发送请求
    // [[NSOperationQueue alloc]init];非主队列
    // [NSOperationQueue mainQueue]  主队列
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        
//        if (connectionError == nil) {
//            
//            NSLog(@"%@",response);
//            
//            
//            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            
//            NSLog(@"%@",string);
//        }else{
//            NSLog(@"%@",connectionError);
//        }
//        //打印当前队列
//        NSLog(@"currentThread= %@",[NSThread currentThread]);
//        
//    }];
    
    
    
}
//连接错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

//接收到相应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (self.datas) {
        self.datas.length = 0;
    }else{
        self.datas = [[NSMutableData alloc]init];
        
    }
}

//接受到数据 如果数据量较大的话分段接受
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.datas appendData:data];
    
    NSLog(@"%zd",data.length);
    
}

//请求完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");
    
     NSString *string = [[NSString alloc]initWithData:self.datas encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    
    
    
}
#pragma mark - 同步请求
- (void)sync{
    //1.创建NSURL对象
    NSURL *url = [NSURL URLWithString:LIST_URL];
    //2.创建NSURLRequest，默认请求方式是GET
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.使用NSURKConnection发送请求
    
    /*
     Response 响应头
     error 发送请求时出现的错误
     data 响应体
     
     */
    NSURLResponse *response=nil;
    
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error:&error];
    
    if (error == nil) {
        NSLog(@"%@",response);
        
        
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",string);
        
    }else{
        NSLog(@"%@",error);
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

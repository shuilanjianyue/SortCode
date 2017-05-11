//
//  SessionController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "SessionController.h"
#define LIST_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"

#define LIST_URL_POST @"http://new.api.bandu.cn/book/listofgrade"
@interface SessionController ()
@property(nonatomic,strong)NSMutableData *datas;

@end

@implementation SessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"NSURLSession";
    // Do any additional setup after loading the view.
}



#pragma mark - POST
- (void)post{
   
    //1.创建NSURL对象
    NSURL *url = [NSURL URLWithString:LIST_URL_POST];
    //2.创建NSURLRequest，默认请求方式是GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //修改请求方式
    request.HTTPMethod = @"POST";
    //在请求体中 添加请求数据
    request.HTTPBody = [@"grad_ide=2" dataUsingEncoding:NSUTF8StringEncoding];
    
    //1 创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    //2 根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",object);
            
        }
        
        //回归到主线程的方法
        /*
         1
         [session performSelectorOnMainThread:@selector(main) withObject:nil waitUntilDone:YES];
         
         2
         dispatch_async(dispatch_get_main_queue(), ^{
         });
         
         3
         [[NSOperationQueue mainQueue]addOperationWithBlock:^{
         
         }];
         */
        
        
        
    }];
    
    //启动任务
    [dataTask resume];

    
}

#pragma mark - GET
-(void)sessionData{
    //设置请求地址
    NSURL *url = [NSURL URLWithString:LIST_URL];
    //封装一个请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //1 创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    //2 根据会话创建任务
   NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",object);
            
        }
       
        //回归到主线程的方法
        /*
         1
        [session performSelectorOnMainThread:@selector(main) withObject:nil waitUntilDone:YES];
        
         2
        dispatch_async(dispatch_get_main_queue(), ^{
        });
        
         3
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
        }];
         */
        
        
        
    }];
    
    //启动任务
    [dataTask resume];
    
    
}
- (void)main{
    
}


-(void)sessionDelegate{
    //设置请求地址
    NSURL *url = [NSURL URLWithString:LIST_URL];
    //封装一个请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //1 创建Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    

    [dataTask resume];
    
    
}

//接受到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    if (self.datas) {
        self.datas.length = 0;
    }else{
        self.datas = [[NSMutableData alloc]init];
        
    }
    
    
    /*
     NSURLSessionResponseCancel  默认请求之后不接收服务器的数据
     NSURLSessionResponseAllow   允许接收服务器的数据
     NSURLSessionResponseBecomeDownload 转成下载任务
     NSURLSessionResponseBecomeStream 转成流
     */
    
    completionHandler(NSURLSessionResponseAllow);
    
}


//接受到数据
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    [self.datas appendData:data];
    
}

//数据请求完成或失败
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    
    if (error == nil) {
        NSString *string = [[NSString alloc]initWithData:self.datas encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
    }else{
        
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

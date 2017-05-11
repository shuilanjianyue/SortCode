//
//  WebJsController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/12/9.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "WebJsController.h"
#import "iOS.h"

@interface WebJsController ()<UIWebViewDelegate>
{
    UIWebView *myWebView;
}
@end

@implementation WebJsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text = @"JS交互";
    
    //初始化webview
    myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, NavHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-NavHeight)];
    myWebView.delegate=self;
    //添加webview到当前viewcontroller的view上
    [self.view addSubview:myWebView];
    
    
    //网址
    NSURL *htmlUrl = [NSURL URLWithString:@"http://192.168.1.98/school_erp_www/Wap/test"];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:htmlUrl];
    [myWebView loadRequest:httpRequest];
    
    
    
    // Do any additional setup after loading the view.
}



#pragma mark --webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //iOS调用js
    
     //iOS *ios = [[iOS alloc] init];
    
    
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
      
    NSString *gggg = @"rrrrr";
    
    //NSString *alertJS=@"ios_token_init(&gggg)"; //准备执行的js代码
      
    NSString *alertJS = [NSString stringWithFormat:@"ios_token_init('%@')",gggg];
    
    [jsContext evaluateScript:alertJS];//通过oc方法调用js的alert
    
    
    
    //jsContext[@"iOS"] = ios;
    
    
    //jsContext[@"OC"] = self; // 注入JS需要的“OC”对象

    
}



-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
}


//- (void)showMessage
//{
//    NSLog(@"current:%@",[NSThread currentThread]);// 子线程
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"JS 调用了 OC" message:@"dddddddd" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:cancel];
//        [self presentViewController:alert animated:YES completion:nil];
//    });
//}

//- (void)doSomethingThenCallBack:(NSString *)message
//{
//    NSString *result = [message stringByAppendingString:@"<br/>OC get message from JS then call back."];
//    JSValue *callback = self.context[@"callback"];
//    [callback callWithArguments:@[result]];
//}
//
//- (void)mixA:(NSString *)aString andB:(NSString *)bString
//{
//    NSLog(@"A:%@ and B:%@",aString,bString);
//    JSValue *alertCallback = self.context[@"alertCallback"];
//    [alertCallback callWithArguments:@[aString,bString]];
//}



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

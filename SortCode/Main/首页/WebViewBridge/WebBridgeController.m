//
//  WebBridgeController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/12/9.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "WebBridgeController.h"
#import "WebViewJavascriptBridge.h"

@interface WebBridgeController ()
@property WebViewJavascriptBridge* bridge;
@end    

@implementation WebBridgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"WebViewJavascriptBridge";
    
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight)];
    [self.view addSubview:webView];
    
    
    //网址
    NSURL *htmlUrl = [NSURL URLWithString:@"http://192.168.1.98/school_erp_www/Wap/test"];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:htmlUrl];
    [webView loadRequest:httpRequest];
    
    
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    [_bridge setWebViewDelegate:self];
    
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        responseCallback(@"testObjcCallback");
    }];
    
    
    //    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    //
    //    [self renderButtons:webView];
    
    
}





- (NSString *)testObjcCallback{
    
    return @"ffddd34353532ddfdf243242354325";
    
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

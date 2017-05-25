//
//  WebBridgeController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/12/9.
//  Copyright © 2016年 DZQC. All rights reserved.
//
/******自己填写所需要的url*********/
#import "WebBridgeController.h"
#import <WebKit/WebKit.h>
#import "WKDelegateController.h"
@interface WebBridgeController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKDelegate>

@property (nonatomic, strong) WKWebView *wkView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *closeButton;
@end    

@implementation WebBridgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"JS交互";
    
    
    [self initBaseWebView];
    
    
    // Do any additional setup after loading the view.
}




- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, 2)];
        _progressView.progressTintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(30, 20, 44, 44);
        _closeButton.hidden = YES;
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_closeButton addTarget:self action:@selector(closeWebViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


- (void)initBaseWebView
{
    self.navBar.titleLabel.frame = CGRectMake(70, 20, SCREEN_WIDTH - 140, 44);
    //配置环境
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    configuration.userContentController = userContentController;
    
    
    self.wkView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight) configuration:configuration];
    self.wkView.backgroundColor = UIColorFromRGB(0xffffff);
    self.wkView.UIDelegate = self;
    self.wkView.navigationDelegate = self;
    
    //注册方法
    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
    delegateController.delegate = self;
    
    // 新增js方法
    [userContentController addScriptMessageHandler:delegateController name:@"chat_to"];
    
    NSURL *url = [NSURL URLWithString:@""];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    [self.view addSubview:self.wkView];
    [self.wkView loadRequest:request];
    
    
    [self.navBar addSubview:self.closeButton];
    
    // 测试
    //    NSString *html = @"<html><title>Dialog</title><style type='text/css'>body{font-size:60px}</style><script type='text/javascript'>function myconfirm(){if(confirm('Star it?')){alert('Done')}}</script><body><a href=\"javascript:alert('Just Alert')\" >Alert</a><br /><a href=\"javascript:myconfirm()\">Logout</a></body></html>";
    //    [self.wkView loadHTMLString:html baseURL:nil];
    
    [self.view addSubview:self.progressView];
    // 观察者   观察estimatedProgress字段  用来显示进度
    [self.wkView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    
    //    前端需要用 window.webkit.messageHandlers.注册的方法名.postMessage({body:传输的数据} 来给native发送消息
    //    window.webkit.messageHandlers.sayhello.postMessage({body: 'hello world!'});
}


- (void)dealloc{
    // 这里需要注意，前面增加过的方法一定要remove掉。
    [[self.wkView configuration].userContentController removeScriptMessageHandlerForName:@"chat_to"];
    // 移除观察者
    [self.wkView removeObserver:self forKeyPath:@"estimatedProgress"];
}


#pragma mark - Action
- (void)backBtnAction
{
    if ([self.wkView canGoBack]) {
        self.closeButton.hidden = NO;
        [self.wkView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeWebViewController:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"name:%@\n body:%@\n frameInfo:%@\n",message.name,message.body,message.frameInfo);
    if ([message.name isEqualToString:@"chat_to"]) {
        
        //        [self getOtherUserAvatarAndNickName:message.body[@"body"]];
        //
        NSLog(@"%@",message.body[@"body"]);
        
        
        
        
        
        
    }
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    __weak typeof(self) weakSelf = self;;
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        weakSelf.navBar.titleLabel.text = result;
    }];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}


// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}


#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return [[WKWebView alloc]init];
}

// 输入框
// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}


// 确认框
// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}


// 警告框
// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
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

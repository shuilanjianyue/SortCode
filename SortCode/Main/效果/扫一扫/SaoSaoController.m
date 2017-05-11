//
//  SaoSaoController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/2/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "SaoSaoController.h"
#import <AVFoundation/AVFoundation.h>

//扫描线颜色
#define kLineColor ([UIColor orangeColor].CGColor)

//扫描线宽度
#define kLineBorad 2

//扫描范围边框颜色
#define kRangeColor ([UIColor orangeColor].CGColor)


@interface SaoSaoController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UIView *boxView;
@property (nonatomic, strong) CALayer *scanLayer;
@property (nonatomic, strong) UIView *viewPreview;
@property (nonatomic, strong) UIWebView *webView;


//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

/**
 *  开始扫描
 */
-(void)startReading;

/**
 *  停止扫描
 */
-(void)stopReading;



@end

@implementation SaoSaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
    [self startReading];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建界面
-(void)buildUI
{
    self.navBar.titleLabel.text = @"二维码扫描";
    
    
    //预览层
    UIView *viewPreview = [[UIView alloc] init];
    viewPreview.frame = CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight);
    viewPreview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:viewPreview];
    self.viewPreview = viewPreview;
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.hidden = YES;
    
    //初始化
    _captureSession = nil;
}



- (void)startReading
{
    NSError *error;
    
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        
         NSLog(@"%@", [error localizedDescription]);
        
        return;
        
       
    }
    
    
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myScanQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    /*****************************************************
     二维码和条形码要分开来写
     如果是二维码
     [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
     如果条形码
     [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, nil]];
     */
    
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    
    //9.将图层添加到预览view的图层上
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    
   /*
    *AVCaptureMetadataOutput 中的属性rectOfInterest 看起来是CGRect类型, 实际上是填写一个比例。加入屏幕的frame 为 x , y, w, h, 要设置的扫描区域的frame 为 x1, y1, w1, h1. 那么rectOfInterest 应该设置为 CGRectMake(y1/y, x1/x, h1/h, w1/w)。
    *
    */
    
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    
    
    
    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.1f, _viewPreview.bounds.size.height * 0.2f, _viewPreview.bounds.size.width * 0.8f, _viewPreview.bounds.size.width * 0.8f)];
    _boxView.layer.borderColor = kRangeColor;
    _boxView.layer.borderWidth = 1.0f;
    [_viewPreview addSubview:_boxView];
    
    
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, kLineBorad);
    _scanLayer.backgroundColor = kLineColor;
    [_boxView.layer addSublayer:_scanLayer];
    
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    
    [timer fire];
    
    
    //11.开始扫描
    [_captureSession startRunning];
}


-(void)stopReading
    {
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
}                   




#pragma mark   - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *urlStr;
    
        //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            urlStr = metadataObj.stringValue;
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
        }
    }
    
    _videoPreviewLayer.hidden = YES;
    _webView.hidden = NO;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
    
}


#pragma mark - 修改那条线的位置关系
- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height == _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        if (frame.origin.y > _boxView.frame.size.height) {
            frame.origin.y = _boxView.frame.size.height;
        }
        [UIView animateWithDuration:0.1 animations:^{
            
            _scanLayer.frame = frame;
        }];
    }
}



- (BOOL)shouldAutorotate
{
    return NO;
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

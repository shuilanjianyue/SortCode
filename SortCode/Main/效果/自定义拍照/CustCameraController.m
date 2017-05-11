//
//  CustCameraController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/22.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CustCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import "CustCameraView.h"


@interface CustCameraController ()
/**
 *  AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
 */
@property (nonatomic, strong) AVCaptureSession* session;
/**
 *  输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
/**
 *  照片输出流
 */

@property (nonatomic, strong) AVCaptureStillImageOutput* stillImageOutput;

/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;

@property(nonatomic,strong)UIView *backView;

@end

@implementation CustCameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"AVFoundation自定义相机";
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - 49)];
    self.backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, self.backView.bottom, SCREEN_WIDTH - 40, 49)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(pick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    [self initAVCaptureSession];
    
    // Do any additional setup after loading the view.
}


- (void)initAVCaptureSession{
    
    self.session = [[AVCaptureSession alloc] init];
    
    NSError *error;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    //设置闪光灯为自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //输出设置。AVVideoCodecJPEG   输出jpeg格式图片
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    NSLog(@"%f",SCREEN_WIDTH);
    self.previewLayer.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight-49);
    
    self.backView.layer.masksToBounds = YES;
    [self.backView.layer addSublayer:self.previewLayer];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    if (self.session) {
        
        [self.session startRunning];
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    if (self.session) {
        
        [self.session stopRunning];
    }
}


//接下来搞一个获取设备方向的方法，再配置图片输出的时候需要使用
-(AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    if ( deviceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deviceOrientation == UIDeviceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pick{
    
   
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput        connectionWithMediaType:AVMediaTypeVideo];
    
    if (!stillImageConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    
    
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avcaptureOrientation = [self avOrientationForDeviceOrientation:curDeviceOrientation];
    [stillImageConnection setVideoOrientation:avcaptureOrientation];
    
    //这个方法是控制焦距用的暂时先固定为1，后边写手势缩放焦距的时候会修改这里
    [stillImageConnection setVideoScaleAndCropFactor:1];
    
    
    
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        
        UIImage * image = [UIImage imageWithData:imageData];
        
        
        NSLog(@"image size = %@",NSStringFromCGSize(image.size));
    }];
    
    
}

//闪光灯的设置非常简单，只需要修改device的flashMode属性即可，这里需要注意的是，修改device时候需要先锁住，修改完成后再解锁，否则会崩溃，设置闪光灯的时候也需要做安全判断，验证设备是否支持闪光灯，有些iOS设备是没有闪光灯的，如果不做判断还是会crash掉 
- (IBAction)flashButtonClick:(UIBarButtonItem *)sender {
    
    NSLog(@"flashButtonClick");
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //修改前必须先锁定
    [device lockForConfiguration:nil];
    //必须判定是否有闪光灯，否则如果没有闪光灯会崩溃
    if ([device hasFlash]) {
        
        if (device.flashMode == AVCaptureFlashModeOff) {
            device.flashMode = AVCaptureFlashModeOn;
            
            [sender setTitle:@"flashOn"];
        } else if (device.flashMode == AVCaptureFlashModeOn) {
            device.flashMode = AVCaptureFlashModeAuto;
            [sender setTitle:@"flashAuto"];
        } else if (device.flashMode == AVCaptureFlashModeAuto) {
            device.flashMode = AVCaptureFlashModeOff;
            [sender setTitle:@"flashOff"];
        }
        
    } else {
        
        NSLog(@"设备不支持闪光灯");
    }
    
    
    
    [device unlockForConfiguration];
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

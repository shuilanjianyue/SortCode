//
//  CustVideoController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/23.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CustVideoController.h"
#import "RecordEngine.h"
#import "RecordProgressView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSUInteger, UploadVieoStyle) {
    VideoRecord = 0,
    VideoLocation,
};

@interface CustVideoController ()<RecordEngineDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic)  UIButton *flashLightBT;
@property (strong, nonatomic)  UIButton *changeCameraBT;
@property (strong, nonatomic)  UIButton *recordNextBT;
@property (strong, nonatomic)  UIButton *recordBt;
@property (strong, nonatomic)  UIButton *locationVideoBT;
@property (strong, nonatomic)  NSLayoutConstraint *topViewTop;
@property (strong, nonatomic)  RecordProgressView *progressView;




@property (strong, nonatomic) RecordEngine         *recordEngine;
@property (assign, nonatomic) BOOL                    allowRecord;//允许录制
@property (assign, nonatomic) UploadVieoStyle         videoStyle;//视频的类型
@property (strong, nonatomic) UIImagePickerController *moviePicker;//视频选择器
@property (strong, nonatomic) MPMoviePlayerViewController *playerVC;



@end

@implementation CustVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
      
    
    self.navBar.titleLabel.text = @"自定义录像";
    
   
    
    
    self.changeCameraBT = [[UIButton alloc]initWithFrame:CGRectMake(30, NavHeight + 20,50 , 30)];
    [self.changeCameraBT setImage:[UIImage imageNamed:@"0-前后摄像头置换按钮"] forState:UIControlStateNormal];
    [self.changeCameraBT addTarget:self action:@selector(changeCameraAction) forControlEvents:UIControlEventTouchUpInside];
    self.changeCameraBT.selected = YES;
    [self.view addSubview:self.changeCameraBT];
    
    
    
    self.flashLightBT = [[UIButton alloc]initWithFrame:CGRectMake(self.changeCameraBT.right + 20, NavHeight + 20,50 , 30)];
    [self.flashLightBT setImage:[UIImage imageNamed:@"0-闪光灯关"] forState:UIControlStateNormal];
    [self.flashLightBT addTarget:self action:@selector(flashLightAction) forControlEvents:UIControlEventTouchUpInside];
    self.flashLightBT.selected = YES;
    [self.view addSubview:self.flashLightBT];
    
    
    self.recordNextBT = [[UIButton alloc]initWithFrame:CGRectMake(self.flashLightBT.right + 20, NavHeight + 20,80 , 30)];
    [self.recordNextBT setImage:[UIImage imageNamed:@"0-下一步按钮－正常态"] forState:UIControlStateNormal];
    [self.recordNextBT addTarget:self action:@selector(recordNextAction) forControlEvents:UIControlEventTouchUpInside];;
    [self.view addSubview:self.recordNextBT];
    
    
    
    
    self.recordBt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80/2, SCREEN_HEIGHT - 120,80 , 80)];
    [self.recordBt setImage:[UIImage imageNamed:@"0-录制按钮"] forState:UIControlStateNormal];
    [self.recordBt setImage:[UIImage imageNamed:@"2-录制暂停按钮"] forState:UIControlStateSelected];
    [self.recordBt addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];;
    [self.view addSubview:self.recordBt];
    
    
    
    self.progressView = [[RecordProgressView alloc]initWithFrame:CGRectMake(0, self.recordBt.top - 10, SCREEN_WIDTH, 5)];
    self.progressView.progressBgColor = [UIColor lightGrayColor];
    self.progressView.progressColor = [UIColor redColor];
    [self.view addSubview:self.progressView];
    
    
    self.allowRecord = YES;
    
    //在这里次
    _recordEngine = [[RecordEngine alloc] init];
    _recordEngine.delegate = self;
    
    [self.recordEngine previewLayer].frame = CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight);
    [self.view.layer insertSublayer:[self.recordEngine previewLayer] atIndex:0];
    
    [self.recordEngine startUp];
    
    // Do any additional setup after loading the view.
}





- (void)dealloc {
    
    _recordEngine = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:[_playerVC moviePlayer]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _progressView.progress = 0.0;
    [_recordEngine shutdown];
}



//根据状态调整view的展示情况
- (void)adjustViewFrame {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.recordBt.selected) {
            self.topViewTop.constant = -64;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }else {
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
            self.topViewTop.constant = 0;
        }
        if (self.videoStyle == VideoRecord) {
            self.locationVideoBT.alpha = 0;
        }
        [self.view layoutIfNeeded];
    } completion:nil];
}



- (UIImagePickerController *)moviePicker {
    if (_moviePicker == nil) {
        _moviePicker = [[UIImagePickerController alloc] init];
        _moviePicker.delegate = self;
        _moviePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _moviePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    return _moviePicker;
}

#pragma mark - Apple相册选择代理
//选择了某个照片的回调函数/代理回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie]) {
        //获取视频的名称
        NSString * videoPath=[NSString stringWithFormat:@"%@",[info objectForKey:UIImagePickerControllerMediaURL]];
        NSRange range =[videoPath rangeOfString:@"trim."];//匹配得到的下标
        NSString *content=[videoPath substringFromIndex:range.location+5];
        //视频的后缀
        NSRange rangeSuffix=[content rangeOfString:@"."];
        NSString * suffixName=[content substringFromIndex:rangeSuffix.location+1];
        //如果视频是mov格式的则转为MP4的
        if ([suffixName isEqualToString:@"MOV"]) {
            
            NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            __weak typeof(self) weakSelf = self;
            [self.recordEngine changeMovToMp4:videoUrl dataBlock:^(UIImage *movieImage) {
                
                [weakSelf.moviePicker dismissViewControllerAnimated:YES completion:^{
                    weakSelf.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[weakSelf.playerVC moviePlayer]];
                    [[weakSelf.playerVC moviePlayer] prepareToPlay];
                    
                    [weakSelf presentMoviePlayerViewControllerAnimated:weakSelf.playerVC];
                    [[weakSelf.playerVC moviePlayer] play];
                }];
            }];
        }
    }
}


#pragma mark - WCLRecordEngineDelegate
- (void)recordProgress:(CGFloat)progress {
    if (progress >= 1) {
        [self recordAction:self.recordBt];
        self.allowRecord = NO;
    }
    self.progressView.progress = progress;
}

#pragma mark - 各种点击事件
//返回点击事件
- (IBAction)dismissAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//开关闪光灯
- (void)flashLightAction{
    
        if (self.flashLightBT.selected == YES) {
            [self.recordEngine openFlashLight];
            
            [self.flashLightBT setImage:[UIImage imageNamed:@"0-闪光灯关"] forState:UIControlStateNormal];
            
        }else {
            
            [self.recordEngine closeFlashLight];
            
            [self.flashLightBT setImage:[UIImage imageNamed:@"0-闪光灯开"] forState:UIControlStateNormal];
            
        }
    
    self.flashLightBT.selected = !self.flashLightBT.selected;
    
}


//切换前后摄像头
- (void)changeCameraAction{
    
    if (self.changeCameraBT.selected == YES) {
        //前置摄像头
        [self.recordEngine closeFlashLight];
        self.flashLightBT.hidden = YES;
        [self.recordEngine changeCameraInputDeviceisFront:YES];
        
    }else {
        
        self.flashLightBT.hidden = NO;
        [self.recordEngine changeCameraInputDeviceisFront:NO];
    }
    
    self.changeCameraBT.selected = !self.changeCameraBT.selected;
    
}

//录制下一步点击事件
- (void)recordNextAction{
    if (_recordEngine.videoPath.length > 0) {
        __weak typeof(self) weakSelf = self;
        [self.recordEngine stopCaptureHandler:^(UIImage *movieImage) {
            weakSelf.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[weakSelf.playerVC moviePlayer]];
            [[weakSelf.playerVC moviePlayer] prepareToPlay];
            
            [weakSelf presentMoviePlayerViewControllerAnimated:weakSelf.playerVC];
            [[weakSelf.playerVC moviePlayer] play];
        }];
    }else {
        NSLog(@"请先录制视频~");
    }
}

//当点击Done按键或者播放完毕时调用此函数
- (void) playVideoFinished:(NSNotification *)theNotification {
    MPMoviePlayerController *player = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [self.playerVC dismissMoviePlayerViewControllerAnimated];
    self.playerVC = nil;
}

////本地视频点击视频
//- (IBAction)locationVideoAction:(id)sender {
//    self.videoStyle = VideoLocation;
//    [self.recordEngine shutdown];
//    [self presentViewController:self.moviePicker animated:YES completion:nil];
//}

//开始和暂停录制事件
- (void)recordAction:(UIButton *)sender {
    if (self.allowRecord) {
        self.videoStyle = VideoRecord;
        self.recordBt.selected = !self.recordBt.selected;
        if (self.recordBt.selected) {
            if (self.recordEngine.isCapturing) {
                [self.recordEngine resumeCapture];
            }else {
                [self.recordEngine startCapture];
            }
        }else {
            [self.recordEngine pauseCapture];
        }
        
        [self adjustViewFrame];
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

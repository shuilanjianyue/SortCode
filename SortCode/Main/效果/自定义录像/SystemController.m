//
//  SystemController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/23.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "SystemController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface SystemController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL shouldAsync;
@end

@implementation SystemController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"系统录像";
    // 录制视频
    UIButton *RecordVideo = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [RecordVideo setTitle:@"开始录制" forState:UIControlStateNormal];
    RecordVideo.backgroundColor = [UIColor lightGrayColor];
    [RecordVideo addTarget:self action:@selector(videoFromcamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RecordVideo];
    
    
    // 从选择视频
    UIButton *SelectLocalVideo = [[UIButton alloc]initWithFrame:CGRectMake(100, 250, 100, 100)];
    [SelectLocalVideo setTitle:@"选择视频" forState:UIControlStateNormal];
    SelectLocalVideo.backgroundColor = [UIColor lightGrayColor];
    [SelectLocalVideo addTarget:self action:@selector(videoFromPhotos) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SelectLocalVideo];
    
    
    // Do any additional setup after loading the view.
}



// 录制视频
- (void)videoFromcamera{
    [self getVideoWithsourceType:UIImagePickerControllerSourceTypeCamera shouldAsync:YES];
    
}


// 从相册中选择视频"
- (void)videoFromPhotos{
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum - 这个是自定义库，是由用户截图或保存到里面的
    [self getVideoWithsourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum shouldAsync:NO];
}


//调用摄像头
- (void)getVideoWithsourceType:(UIImagePickerControllerSourceType)type shouldAsync:(BOOL)shouldAsync{
    //取得授权状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //判断当前状态
    if (authStatus == AVAuthorizationStatusRestricted
        || authStatus == AVAuthorizationStatusDenied) {
        //拒绝当前 app 访问[phtot]运行
        CustomToastView *toast = [[CustomToastView alloc]initWithView:self.view text:@"手机不支持摄像" duration:1];
        
        [toast show];
        return;
    }
    
    
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //可以编辑
        picker.allowsEditing = YES;
        //设置资源获取类型
        picker.sourceType = type;
        picker.mediaTypes = @[(NSString *)kUTTypeMovie];
        [self presentViewController:picker animated:YES completion:NULL];
        
        
        self.shouldAsync = shouldAsync;
        
    }else{
        
        CustomToastView *toast = [[CustomToastView alloc]initWithView:self.view text:@"手机不支持摄像" duration:1];
        
        [toast show];
        
    }
}


//代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        
        
        
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSLog(@"video...");
        //获取媒体 Url
       
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
            
        }
        
       
        //9.0以后
//        PHPhotoLibrary * library = [PHPhotoLibrary sharedPhotoLibrary];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            NSError * error = nil;
//            // 用来抓取PHAsset的字符串标识
//            __block NSString *assetId = nil;
//            // 用来抓取PHAssetCollectin的字符串标识符
//            __block NSString *assetCollectionId = nil;
//            
//            // 保存视频到【Camera Roll】(相机胶卷)
//            
//            [library performChangesAndWait:^{
//                
//                assetId = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url].placeholderForCreatedAsset.localIdentifier;
//                
//            } error:&error];
//            // 获取曾经创建过的自定义视频相册名字
//            PHAssetCollection  * createdAssetCollection = nil;
//            PHFetchResult< PHAssetCollection *>* assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//            for (PHAssetCollection * assetCollection in assetCollections) {
//                if ([assetCollection.localizedTitle isEqualToString: @"录像"]) {
//                    
//                    createdAssetCollection = assetCollection;
//                    
//                    break;
//                    
//                }
//            }
//            
//            //如果这个自定义框架没有创建过
//            if (createdAssetCollection == nil) {
//                //创建新的[自定义的 Album](相簿\相册)
//                [library performChangesAndWait:^{
//                    
//                    assetCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"录像"].placeholderForCreatedAssetCollection.localIdentifier;
//                    
//                    
//                } error:&error];
//                
//                //抓取刚创建完的视频相册对象
//                createdAssetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionId] options:nil].firstObject;
//            }
//            
//            // 将【Camera Roll】(相机胶卷)的视频 添加到 【自定义Album】(相簿\相册)中
//            [library performChangesAndWait:^{
//                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
//                
//                // 视频
//                [request addAssets:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil]];
//            } error:&error];
//            
//            // 提示信息
//            if (error) {
//                CustomToastView *toast = [[CustomToastView alloc]initWithView:self.view text:@"保存视频失败!" duration:1];
//                [toast show];
//                
//                
//            } else {
//                CustomToastView *toast = [[CustomToastView alloc]initWithView:self.view text:@"保存视频成功!" duration:1];
//                [toast show];
//                
//            }
//            
//        });
//        
        
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
        
    }else{
        
        
        NSLog(@"视频保存成功.");
        
        //录制完之后自动播放
        NSURL *url=[NSURL fileURLWithPath:videoPath];

        NSLog(@"%@",url);
        
        
    }
}










#pragma mark - 同步获取帧图
// Get the video's center frame as video poster image
- (UIImage *)frameImageFromVideoURL:(NSURL *)videoURL {
    // result
    UIImage *image = nil;
    
    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    // get the image from
    NSError *error = nil;
    CMTime actualTime;
    // Returns a CFRetained CGImageRef for an asset at or near the specified time.
    // So we should mannully release it
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint
                                                         actualTime:&actualTime
                                                              error:&error];
    
    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
        // Release the CFRetained image
        CGImageRelease(centerFrameImage);
    }
    
    return image;
}



#pragma mark - 异步获取帧图
//异步获取帧图,可以一次回去多帧图片
- (void)centerFrameImageWithVideoURL:(NSURL *)videoURL completion:(void (^)(UIImage *image))completion{
    
    // AVAssetImageGenerator
    AVAsset * asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    //异步获取多帧图
    NSValue * midTime = [NSValue valueWithCMTime:midpoint];
    [imageGenerator generateCGImagesAsynchronouslyForTimes:@[midTime] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        
        if (result == AVAssetImageGeneratorSucceeded && image != NULL) {
            UIImage * centerFrameImage = [[UIImage alloc]initWithCGImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completion) {
                    
                    completion(centerFrameImage);
                    
                }
                
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completion) {
                    completion(nil);
                }
            });
            
            
        }
        
    }];
    
}

#pragma mark - 压缩导出视频
- (void)compressVideoWithVideoURL:(NSURL *)videoURL
                        savedName:(NSString *)savedName
                       completion:(void (^)(NSString *savedPath))completion{
    
    // Accessing video by URL
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    //开始压缩视频
    //现在我们压缩到低分辨率是否支持
    //如果需要上传服务器,但由流媒体服务器不支持上传,
    //可以压缩分辨率降低。或者你可以支持更多的高分辨率。
    if ([presets containsObject:AVAssetExportPreset640x480]) {
        AVAssetExportSession * session = [[AVAssetExportSession alloc]initWithAsset:videoAsset presetName:AVAssetExportPreset640x480];
        //NSHomeDirectory()  得到的是应用程序目录的路径，在该目录下有三个文件夹：Documents、Library、temp以及一个.app包！该目录下就是应用程序的沙盒，应用程序只能访问该目录下的文件夹！！！
        NSString * doc = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSString * folder = [doc stringByAppendingPathComponent:@"录制视频"];
        BOOL isDir = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:folder isDirectory:&isDir];
        if (!isExist || (isExist && !isDir)) {
            
            NSError * error = nil;
            
            [[NSFileManager defaultManager]createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:&error];
            if (error == nil) {
                //[SVProgressHUD showInfoWithStatus:@"目录创建成功"];
            } else {
                //[SVProgressHUD showInfoWithStatus:@"目录创建失败"];
                
            }
        }
        
        NSString * OutPutPath = [folder stringByAppendingPathComponent:savedName];
        session.outputURL = [NSURL fileURLWithPath:OutPutPath];
        // Optimize for network use.
        session.shouldOptimizeForNetworkUse = true;
        
        NSArray * supportedTypeArray = session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            session.outputFileType = AVFileTypeMPEG4;
            
        } else if (supportedTypeArray.count == 0){
            
            //[SVProgressHUD showInfoWithStatus:@"No supported file types"];
            return;
            
        } else {
            
            session.outputFileType = [supportedTypeArray objectAtIndex:0];
            
        }
        
        
        // Begin to export video to the output path asynchronously.
        //开始出口异步视频输出路径。
        [session exportAsynchronouslyWithCompletionHandler:^{
            
            if ([session status] == AVAssetExportSessionStatusCompleted) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (completion) {
                        
                        completion([session.outputURL path
                                    ]);
                        
                    }
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (completion) {
                        completion(nil);
                    }
                    
                });
                
            }
            
        }];
        
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

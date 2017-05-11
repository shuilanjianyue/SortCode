//
//  QiNiuController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/15.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "QiNiuController.h"

@interface QiNiuController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIButton *showButton1;
    
}

@property(nonatomic,strong)UIImage *pickImage;//上传图片

@property(nonatomic,strong)NSString *token;//得到的token

@property(nonatomic,strong)CustomToastView *uploadToast;

@end

@implementation QiNiuController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.navBar.titleLabel.text = @"七牛存储";
    showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"选择照片" forState:UIControlStateNormal];
    [showButton1 addTarget:self action:@selector(showsAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton1];
    
    // Do any additional setup after loading the view.
}



- (void)showsAction1{
    
    
    // 类方法
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil buttonTitles:@[@"拍照",@"从手机相册选择"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        
        
        if (buttonIndex == 0) {
            
            [self takePhoto];
            
        }else if(buttonIndex == 1){
            
            [self localPhoto];
            
        }
    }];
    
    
    [sheet show];
    
    
    
    
}



#pragma mark -从相册选择
/*3:从相册选择*/
- (void)localPhoto
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

#pragma mark -拍照
/*4:拍照*/
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate =  self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else {
   
        
        NSLog(@"该设备不支持拍照");
        
    }
}


//再调用以下委托：
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    
    // self.personImage.image = image;
    
    self.pickImage = image;
    
    
    [self getTokenFromQN];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
}


#pragma mark -照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 0.5);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/persons.png"];
    
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}




#pragma mark - 网络请求
#pragma mark -获取七牛存储的Token
- (void)getTokenFromQN {
    
    __weak typeof(self) weakSelf = self;
    
    self.uploadToast = [[CustomToastView alloc]initWithIndicatorWithView:self.view withText:@"正在提交..."];
    
    [self.uploadToast startTheView];
    
    //1.管理器
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    //    //2.设置登录参数
    //    NSDictionary *dict = @{ @"username":@"xn", @"password":@"123" };
    
    [manger POST:@"" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"第一步：%@",responseObject);
        
        weakSelf.token = responseObject[@"qiniu_token"];
        
        NSLog(@"%@",self.token);
        
        
        [weakSelf uploadImageToQNFilePath:[self getImagePath:self.pickImage]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf.uploadToast stopAndRemoveFromSuperView];
        
        NSLog(@"%@",error);
        
    }];
    
}



#pragma mark -七牛存储上传图片
- (void)uploadImageToQNFilePath:(NSString *)filePath {
    
    __weak typeof(self) weakSelf = self;
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    
    NSLog(@"%@",filePath);
    
    NSLog(@"%@",self.token);
    
    
    [upManager putFile:filePath key:nil token:self.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        
        NSLog(@"info ===== %@", info);
        NSLog(@"respKey ===== %@", resp[@"key"]);
        
        [weakSelf saveInfo:resp[@"key"]];
        
    }
                option:uploadOption];
    
    
}


#pragma mark -上传图像
- (void)saveInfo:(NSString *)restKey{
    
  
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

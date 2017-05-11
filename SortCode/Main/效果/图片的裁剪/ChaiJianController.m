//
//  ChaiJianController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/7.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ChaiJianController.h"
#import "ClipViewController.h"


@interface ChaiJianController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ClipViewControllerDelegate>
{
    UIImagePickerController * imagePicker;
    UIButton * btn;
    ClipType clipType;
    UIButton * circleBtn;
    UIButton * squareBtn;
    UITextField * textField ;
    CGFloat radius;
}

@end

@implementation ChaiJianController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"图片的裁剪";
    
    
    [self ConfigUI];
    
    // Do any additional setup after loading the view.
}


-(void)ConfigUI
{
    btn = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(self.view.frame.size.width/ 2 - 50, 100, 100, 100)];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc]init];
    [label setText:@"上传头像"];
    [label setFont:[UIFont systemFontOfSize:18.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFrame:CGRectMake(self.view.frame.size.width/ 2 - 50, 215, 100, 15)];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/ 2 - 110, 240, 150, 25)];
    [label1 setText:@"选择裁剪类型:"];
    [self.view addSubview:label1];
    
    circleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [circleBtn setBackgroundColor:[UIColor redColor]];
    [circleBtn setFrame:CGRectMake(self.view.frame.size.width/ 2 - 90, 270, 100, 20)];
    [circleBtn setTitle:@"圆形裁剪" forState:UIControlStateNormal];
    [circleBtn addTarget:self action:@selector(selectedClipType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleBtn];
    
    
    squareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [squareBtn setFrame:CGRectMake(self.view.frame.size.width/ 2 + 10, 270, 100, 20)];
    [squareBtn setTitle:@"方形裁剪" forState:UIControlStateNormal];
    [squareBtn addTarget:self action:@selector(selectedClipType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:squareBtn];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/ 2 - 110, 300, 210, 25)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入裁剪半径 默认120";
    [self.view addSubview:textField];
}


-(void)selectedClipType:(UIButton *)sender
{
    [sender setBackgroundColor:[UIColor redColor]];
    if([sender.titleLabel.text isEqualToString:@"圆形裁剪"])
    {
        clipType = CIRCULARCLIP;
        [squareBtn setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        clipType = SQUARECLIP;
        [circleBtn setBackgroundColor:[UIColor whiteColor]];
    }
}
-(void)btnClick:(UIButton *)btn
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - imagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    
    ClipViewController * clipView = [[ClipViewController alloc]initWithImage:image];
    clipView.delegate = self;
    clipView.clipType = clipType; //支持圆形:CIRCULARCLIP 方形裁剪:SQUARECLIP   默认:圆形裁剪
    if(![textField.text isEqualToString:@""])
    {
        radius =textField.text.intValue;
        clipView.radius = radius;   //设置 裁剪框的半径  默认120
    }
    
    //    clipView.scaleRation = 5;// 图片缩放的最大倍数 默认为10
    [picker pushViewController:clipView animated:YES];
    
}



//传来的数据
#pragma mark - ClipViewControllerDelegate
-(void)ClipViewController:(ClipViewController *)clipViewController FinishClipImage:(UIImage *)editImage
{
    [clipViewController dismissViewControllerAnimated:YES completion:^{
        [btn setImage:editImage forState:UIControlStateNormal];
    }];
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [textField resignFirstResponder];
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

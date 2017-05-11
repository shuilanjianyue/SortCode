//
//  QRCodeController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/28.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "QRCodeController.h"
#import "QRCodeGenerator.h"

@interface QRCodeController ()
{
    UIImageView *codeImage;
    QRPointType pointType;
    QRPositionType positionType;
}

@end

@implementation QRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"生成二维码";
    
    codeImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100/2, NavHeight + 100, 100, 100)];
    pointType = QRPointRect;
    positionType = QRPositionNormal;
    UIColor *codeColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    NSString *string =[NSString stringWithFormat:@"https://baidu.com"];
    
    codeImage.image = [QRCodeGenerator qrImageForString:string imageSize:codeImage.frame.size.width withPointType:pointType withPositionType:positionType withColor:codeColor];
    
    [self.view addSubview:codeImage];
    
    
    // Do any additional setup after loading the view.
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

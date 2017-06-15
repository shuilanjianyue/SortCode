//
//  RuntimeController.m
//  SortCode
//
//  Created by dazaoqiancheng on 2017/5/11.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "RuntimeController.h"
#import "UILabel+UILabelRuntime.h"
@interface RuntimeController ()
@property(nonatomic,copy)UILabel *runtimeLabel;

@property(nonatomic,copy)UIButton *runtimeButton;

@end

@implementation RuntimeController

- (UILabel *)runtimeLabel{
    
    if (!_runtimeLabel) {
        
        _runtimeLabel = [[UILabel alloc]init];
        _runtimeLabel.backgroundColor = [UIColor redColor];
        _runtimeLabel.autoWidth = 100;
        
        _runtimeLabel.font = [UIFont systemFontOfSize:14];
        
        //_runtimeLabel.autoTag = 100;
        _runtimeLabel.text = @"国际在线专稿：据今日俄罗斯通讯社5月10日援引《金边邮报》报道称，柬埔寨政府将建立一个条件优越的VIP监";
//        CGSize labelSize = [_runtimeLabel autoLabel];
//        
        _runtimeLabel.frame = CGRectMake(0, NavHeight, 100, 200);
        
       //  NSLog(@"labelSize.height= %f",labelSize.height);
    }
    
    return _runtimeLabel;
    
}



- (UIButton *)runtimeButton{
    
    if (!_runtimeButton) {
        _runtimeButton = [[UIButton alloc]initWithFrame:CGRectMake(120, NavHeight , 100, 50)];
        _runtimeButton.backgroundColor = [UIColor magentaColor];
        _runtimeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_runtimeButton setTitle:@"修改字体" forState:UIControlStateNormal];
        [_runtimeButton addTarget:self action:@selector(updateFont) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _runtimeButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"runtime";
    
//    for(NSString *familyName in [UIFont familyNames]){
//        NSLog(@"Font FamilyName = %@",familyName); //*输出字体族科名字
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            NSLog(@"\t%@",fontName);         //*输出字体族科下字样名字
//        }
//    }
    
    [self.view addSubview:self.runtimeLabel];
    [self.view addSubview:self.runtimeButton];
     // MyLog(@"runtimeLabel %f",_runtimeLabel.characterSpace);
    
    // Do any additional setup after loading the view.
}


- (void)updateFont{
    
    
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

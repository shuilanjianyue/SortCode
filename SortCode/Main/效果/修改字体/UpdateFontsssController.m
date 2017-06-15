//
//  UpdateFontsssController.m
//  SortCode
//
//  Created by dazaoqiancheng on 2017/5/15.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "UpdateFontsssController.h"
#import "UILabelCustom.h"
#import "UIButtonCustom.h"
#import "TextFieldCustom.h"
#import "TextViewCustom.h"
#import "UpdateManger.h"

@interface UpdateFontsssController ()
@property(nonatomic,copy)UILabelCustom *updateLabel;

@property(nonatomic,copy)UISwitch *openSwitch;


@property(nonatomic,copy)UIButtonCustom *updateButton;

@property(nonatomic,copy)TextFieldCustom *updateField;


@end

@implementation UpdateFontsssController

- (UILabel *)updateLabel{
    if (!_updateLabel) {
        _updateLabel = [[UILabelCustom alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100/2, 100, 100, 40)];
        _updateLabel.text = @"修改";
        
    }
    return _updateLabel;
}


- (UISwitch *)openSwitch{
    if (!_openSwitch) {
        _openSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 200/2, 180, 100, 40)];
        _openSwitch.on = NO;//设置初始为ON的一边
        
        [_openSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _openSwitch;
    
}



- (UIButtonCustom *)updateButton{
    if (!_updateButton) {
        _updateButton = [[UIButtonCustom  alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100/2,220 , 100, 40)];
        _updateButton.backgroundColor = [UIColor magentaColor];
        
        
        [_updateButton setTitle:@"修改" forState:UIControlStateNormal];
    }
    
    return _updateButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"修改字体";
    
    [self.view addSubview:self.updateLabel];
    [self.view addSubview:self.openSwitch];
    [self.view addSubview:self.updateButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)switchAction:(UISwitch *)sender{
    
    if (sender.on == NO) {
        
        [[UpdateManger shareManger] setUpdateFont:UpdateFontCustom];
        
    }else{
        
        [[UpdateManger shareManger] setUpdateFont:UpdateFontNormal];
        
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

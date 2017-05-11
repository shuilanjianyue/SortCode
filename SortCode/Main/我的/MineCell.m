//
//  MineCell.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/27.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    self.mineImage.dk_imagePicker = DKImagePickerWithNames(@"孙翠花.jpg",@"孙翠花夜.jpg",@"孙翠花.jpg");
    [self.contentView addSubview:self.mineImage];
    
    
    self.setLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.mineImage.right + 10, 0, SCREEN_WIDTH - 100, 50)];
    self.setLabel.dk_textColorPicker = DKColorPickerWithRGB(0x000000,0xffffff,0x000000);
    [self.contentView addSubview:self.setLabel];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5)];
    lineView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xbfbfbf,0xffffff,0xbfbfbf);
    [self.contentView addSubview:lineView];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

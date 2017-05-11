//
//  SetCell.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/27.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xbfbfbf);
    [self.contentView addSubview:lineView];
    
    
    [self initSubView];
    
    
    // Initialization code
}


- (void)initSubView{
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 100, 50)];
    self.nameLabel.dk_textColorPicker = DKColorPickerWithRGB(0x000000,0xffffff,0x000000);
    [self.contentView addSubview:self.nameLabel];
    
    
    self.nightButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 12.5, 25, 25)];
    [self.nightButton dk_setImage:DKImagePickerWithNames(@"夜间",@"日间",@"夜间") forState:UIControlStateNormal];
    [self.contentView addSubview:self.nightButton];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

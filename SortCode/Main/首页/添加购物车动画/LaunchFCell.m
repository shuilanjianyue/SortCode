//
//  LaunchFCell.m
//  yunsong
//
//  Created by 锤子科技 on 15/9/1.
//  Copyright (c) 2015年 孙翠花. All rights reserved.
//

#import "LaunchFCell.h"

@implementation LaunchFCell

- (void)awakeFromNib {
    
    self.shopLabel.layer.masksToBounds=YES;
    self.shopLabel.layer.cornerRadius=15.0/2;
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=[UIColor blackColor];
    [self.contentView addSubview:line];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

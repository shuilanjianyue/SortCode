//
//  LaunchCell.m
//  yunsong
//
//  Created by 锤子科技 on 15/8/25.
//  Copyright (c) 2015年 孙翠花. All rights reserved.
//

#import "LaunchCell.h"

@implementation LaunchCell

- (void)awakeFromNib {
    
    self.shopImage.layer.masksToBounds=YES;
    self.shopImage.layer.borderWidth=0.5f;
    self.shopImage.layer.borderColor=[UIColor blackColor].CGColor;

    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 89.5, SCREEN_WIDTH-80-10-10, 0.5)];
    line.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    self.dianButton.hidden=YES;
    self.add.hidden=NO;
    
    self.selectedButton.layer.masksToBounds=YES;
    self.selectedButton.layer.borderColor=UIColorFromRGB(0xf37221).CGColor;
    self.selectedButton.layer.borderWidth=0.5f;
    self.selectedButton.layer.cornerRadius=10.f;
    
    
    // Initialization code
}


- (void)setModel:(YunSModel *)model{
    
    self.name.text=model.name;
    self.sellL.text=[NSString stringWithFormat:@"已售%@份",model.sell_number];
    self.priceL.text=[NSString stringWithFormat:@"￥%@",model.price];
    
    self.location.text=model.window_name;

    
    if (model.standards.count==0) {
        
        self.add.hidden=NO;
        self.dianButton.hidden=NO;
        self.selectedButton.hidden=YES;
        
    }else{
        
        self.dianButton.hidden=YES;
        self.selectedButton.hidden=NO;
        self.add.hidden=YES;
        
    }
    
    
    //[self.shopImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

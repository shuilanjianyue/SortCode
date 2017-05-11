//
//  ShopCavCell.m
//  整理文
//
//  Created by dazaoqiancheng on 17/4/5.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ShopCavCell.h"

@implementation ShopCavCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
    self.moneyLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.moneyLabel];
    
    
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 10, 70, 30)];
    self.addButton.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:self.addButton];
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

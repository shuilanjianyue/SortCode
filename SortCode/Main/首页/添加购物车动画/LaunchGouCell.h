//
//  LaunchGouCell.h
//  yunsong
//
//  Created by 锤子科技 on 15/9/1.
//  Copyright (c) 2015年 孙翠花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchGouCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

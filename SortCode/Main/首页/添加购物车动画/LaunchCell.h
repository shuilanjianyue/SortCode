//
//  LaunchCell.h
//  yunsong
//
//  Created by 锤子科技 on 15/8/25.
//  Copyright (c) 2015年 孙翠花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *sellL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property(nonatomic,strong)YunSModel *model;

@property (weak, nonatomic) IBOutlet UIButton *dianButton;
@property (weak, nonatomic) IBOutlet UIImageView *add;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@end

//
//  LaunDeCell.h
//  yunsong
//
//  Created by 锤子科技 on 15/8/25.
//  Copyright (c) 2015年 孙翠花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunDeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *shopImageV;

@property (weak, nonatomic) IBOutlet UILabel *saleLabel;

@property(nonatomic,strong)UIView *lineView;//一条线

@property(nonatomic,strong)UILabel *guigeL;//规格


@property(nonatomic,strong)UIButton *guiButton;//规格按钮

@property(nonatomic,strong)UILabel *moneyLabel;//价格

@property(nonatomic,strong)UIButton *justButton;//加入购物车

@property(nonatomic,strong)UILabel *descLabel;//菜品描述

@property(nonatomic,strong)UILabel *contentLabel;//内容

@property(nonatomic,strong)NSArray *arrays;

@property(nonatomic,strong)NSString *desc;//描述

@property(nonatomic,strong)NSString *money;

- (void)selectId:(UIButton *)button;


@property(nonatomic,strong)UIScrollView *scrollView;

@end

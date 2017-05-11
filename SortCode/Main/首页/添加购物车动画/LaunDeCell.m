//
//  LaunDeCell.m
//  yunsong
//
//  Created by 锤子科技 on 15/8/25.
//  Copyright (c) 2015年 孙翠花. All rights reserved.
//

#import "LaunDeCell.h"

@implementation LaunDeCell

- (void)awakeFromNib {
    
    self.lineView=[[UIView alloc]initWithFrame:CGRectMake(10, self.saleLabel.bottom+20, SCREEN_WIDTH-20, 0.5)];
    self.lineView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.lineView];
    
    
    self.guigeL=[[UILabel alloc]initWithFrame:CGRectZero];
    self.guigeL.text=@"规格:";
    self.guigeL.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.guigeL];
    
    
    self.moneyLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    self.moneyLabel.textColor=UIColorFromRGB(0xf37221);
    self.moneyLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.moneyLabel];
    
    
    self.justButton=[[UIButton alloc]initWithFrame:CGRectZero];
    [self.justButton setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.justButton];
    
    
    
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    self.descLabel.text=@"菜品描述:";
    self.descLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.descLabel];
    
    
    
    self.contentLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    self.contentLabel.numberOfLines=0;
    self.contentLabel.textColor=UIColorFromRGB(0x808080);
    self.contentLabel.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.contentLabel];
    
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectZero];
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    [self.contentView addSubview:self.scrollView];
    
    // Initialization code
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.moneyLabel.text=[NSString stringWithFormat:@"￥%@",self.money];
    
    if (self.arrays.count>0) {
        
        self.guigeL.frame=CGRectMake(10, self.lineView.bottom+15, 35, 25);
        
        self.scrollView.frame=CGRectMake(self.guigeL.right+5, self.lineView.bottom+15, SCREEN_WIDTH-40, 25);
        
        float widths=0;
        
        for (int i=0; i<self.arrays.count; i++) {
            
            YunSModel *model=[self.arrays objectAtIndex:i];
            
            NSDictionary *arrtribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            
            CGSize size = [model.name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 50000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrtribute context:nil].size;
            
            UIButton *guiButton=[[UIButton alloc]initWithFrame:CGRectMake(widths+10*i, 0, size.width+5, 25)];
            
            widths+=size.width;
            
            
            guiButton.tag=i+1;
            
            [guiButton setTitle:model.name forState:UIControlStateNormal];
            
            guiButton.titleLabel.font=[UIFont systemFontOfSize:12];
            [guiButton addTarget:self action:@selector(selectId:) forControlEvents:UIControlEventTouchUpInside];
            
            [guiButton setTitleColor:UIColorFromRGB(0x323232) forState:UIControlStateNormal];
            guiButton.layer.masksToBounds=YES;
            guiButton.layer.cornerRadius=5;
            guiButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
            guiButton.layer.borderWidth=0.5;
            [guiButton setBackgroundColor:UIColorFromRGB(0xffffff)];
            
            [guiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            if (guiButton.tag==1) {
                
                [self selectId:guiButton];
            }
            
            
            [self.scrollView addSubview:guiButton];
        }
        
        self.scrollView.contentSize=CGSizeMake(widths+15*self.arrays.count, 25);
        
        
        self.moneyLabel.frame=CGRectMake(10,self.guigeL.bottom+20, 200, 30);
        
        self.justButton.frame=CGRectMake(SCREEN_WIDTH-40,self.guigeL.bottom+20, 30, 30);
        
        self.descLabel.frame=CGRectMake(10, self.justButton.bottom+10, 200, 20);
        
        NSDictionary *arrtribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGSize size = [self.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 50000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrtribute context:nil].size;
        
        self.contentLabel.frame=CGRectMake(10, self.descLabel.bottom+5, SCREEN_WIDTH-20, size.height);
        
    }else{
        
        
        self.moneyLabel.frame=CGRectMake(10,self.lineView.bottom+15, 200, 30);
        
        self.justButton.frame=CGRectMake(SCREEN_WIDTH-40, self.lineView.bottom+15, 30, 30);
        
        self.descLabel.frame=CGRectMake(10, self.justButton.bottom+10, 200, 20);
        
        NSDictionary *arrtribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGSize size = [self.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 50000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrtribute context:nil].size;
        
        self.contentLabel.frame=CGRectMake(10, self.descLabel.bottom+5, SCREEN_WIDTH-20, size.height);
    }
}


#pragma mark - 点击按钮
- (void)selectId:(UIButton *)button{
    
    _guiButton.selected=NO;
    
    [_guiButton setBackgroundColor:UIColorFromRGB(0xffffff)];
    button.selected=YES;
    [button setBackgroundColor:UIColorFromRGB(0xf37221)];
   _guiButton=button;
    
    _guiButton.tag=button.tag;
    
    
    YunSModel *model=[self.arrays objectAtIndex:button.tag-1];
    
    self.moneyLabel.text=[NSString stringWithFormat:@"￥%@",model.price];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

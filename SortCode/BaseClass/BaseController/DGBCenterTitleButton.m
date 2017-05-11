//
//  DGBCenterTitleButton.m
//  Demo
//
//  Created by douguangbin on 16/9/1.
//  Copyright © 2016年 douguangbin. All rights reserved.
//

#import "DGBCenterTitleButton.h"

@implementation DGBCenterTitleButton

+ (instancetype)centertitleButtonWithImageName:(NSString *)imageName titleName:(NSString *)title {
    
    DGBCenterTitleButton *centerTitleBtn = [[self alloc] init];
    
    centerTitleBtn.imageName = imageName;
    centerTitleBtn.title = title;
    
    return centerTitleBtn;
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:  UIControlStateNormal];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat x = contentRect.size.width * 0.2;
    CGFloat y = contentRect.size.height * 0.2;
    CGFloat w = contentRect.size.width - x * 2;
    CGFloat h = contentRect.size.height * 0.5;
    CGRect rect = CGRectMake(x, y, w, h);
    
    return rect;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat x = 0;
    CGFloat y = contentRect.size.height * 0.65;
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * 0.3;
    
    CGRect rect = CGRectMake(x, y, w, h);
    
    return rect;
    
}


- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}


- (void)setImageName:(NSString *)imageName {
    
    _imageName = imageName;
    
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}


@end

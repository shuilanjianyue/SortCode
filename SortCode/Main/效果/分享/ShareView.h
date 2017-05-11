//
//  ShareView.h
//  整理文
//
//  Created by dazaoqiancheng on 16/11/7.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

- (id)initWithSuperViewController:(UIViewController *)viewController urlString:(NSString *)urlString shareImage:(UIImage *)shareImage;


- (void)show;

@property(nonatomic,strong)NSString *shareUrlS;

@property(nonatomic,strong)UIImage *shareImageS;



@end

//
//  UIImage+UIImageExtra.h
//  100PiFa
//
//  Created by 锤子科技 on 15/12/10.
//  Copyright © 2015年 孙翠花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtra)
@property (nonatomic, strong) NSString *urlStr;    //图片url  相册中
/*
     压缩图片
 */
//-(UIImage *)image:(UIImage*)image newSize:(CGSize)newSize;

/*
     等比例压缩图片
 */
-(UIImage *) sourceImage:(UIImage *)sourceImage targetSize:(CGSize)size;

/*
    指定宽等比例压缩图片
 */
-(UIImage *) sourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end

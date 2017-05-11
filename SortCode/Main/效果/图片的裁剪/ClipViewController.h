//
//  ClipViewControllerController.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/7.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClipViewController;
typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;


@protocol ClipViewControllerDelegate <NSObject>

-(void)ClipViewController:(ClipViewController *)clipViewController FinishClipImage:(UIImage *)editImage;

@end




@interface ClipViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
    UIImage *_image;
    UIView * _overView;
    UIView * _imageViewScale;
    
    CGFloat lastScale;
}


@property (nonatomic, assign)CGFloat scaleRation;//图片缩放的最大倍数
@property (nonatomic, assign)CGFloat radius; //圆形裁剪框的半径
@property (nonatomic, assign)CGRect circularFrame;//裁剪框的frame
@property (nonatomic, assign)CGRect OriginalFrame;
@property (nonatomic, assign)CGRect currentFrame;


@property (nonatomic, assign)ClipType clipType;  //裁剪的形状
@property (nonatomic, strong)id<ClipViewControllerDelegate>delegate;

-(instancetype)initWithImage:(UIImage *)image;

@end

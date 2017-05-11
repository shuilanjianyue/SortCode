//
//  MBProgressController.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/3.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "BaseController.h"

@interface MBProgressController : BaseController
/***********************
 
 1.显示转动的风火轮
 
 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 
 
 2.隐藏掉
 
 [hud hideAnimated:YES];
 
 3.设置颜色
 
 hud.backgroundColor = [UIColor clearColor];//设置大背景的颜色
 hud.contentColor = [UIColor redColor];//风火轮的颜色
 hud.bezelView.color = [UIColor redColor];//小矩形的颜色
 hud.label.textColor = [UIColor redColor];//设置底部的文字颜色
 hud.detailsLabel.textColor = [UIColor redColor];//设置详情的文字颜色
 
 
 4.设置文字样式
 
 hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");//设置底部的文字
 hud.detailsLabel.text = NSLocalizedString(@"Parsing data\n(1/1)", @"HUD title");//设置详情

 
 
 5.样式设计
 
 hud.bezelView --就是小矩形继承自UIView
 hud --就是大的背景
 hud.mode --就是风火轮的样式
 /// UIActivityIndicatorView.
 MBProgressHUDModeIndeterminate,
 /// A round, pie-chart like, progress view.
 MBProgressHUDModeDeterminate,
 /// Horizontal progress bar.
 MBProgressHUDModeDeterminateHorizontalBar,
 /// Ring-shaped progress view.
 MBProgressHUDModeAnnularDeterminate,
 /// Shows a custom view.
 MBProgressHUDModeCustomView,
 /// Shows only labels.
 MBProgressHUDModeText

 hud.label --就是底部文字继承自UILabel
 hud.detailsLabel --就是详情文字继承自UILabel

 hud.animationType动画

 HUD.animationType = MBProgressHUDAnimationFade; //默认类型的，渐变
 HUD.animationType = MBProgressHUDAnimationZoomOut; //HUD的整个view后退 然后逐渐的后退
 HUD.animationType = MBProgressHUDAnimationZoomIn; //和上一个相反，前近，最后淡化消失


 6.其他设置
 
 hud.minShowTime = 10; //设置最短显示时间
 hud.margin = 0; //设置各个元素距离矩形边框的距离
 hud.minSize = CGSizeMake(100, 100);//小矩形的大小
 hud.square = YES; //是否强制背景框宽高相等
 hud.offset = CGPointMake(0.f, MBProgressMaxOffset); //设置偏移量
 
 
 7.高级使用
 
 //自定义上面图片 下面文字
 - (void)customViewExample {
 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
 
 // Set the custom view mode to show any view.
 hud.mode = MBProgressHUDModeCustomView;
 // Set an image view with a checkmark.
 UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
 hud.customView = [[UIImageView alloc] initWithImage:image];
 // Looks a bit nicer if we make it square.
 hud.square = YES;
 // Optional label text.
 hud.label.text = NSLocalizedString(@"Done", @"HUD done title");
 
 [hud hideAnimated:YES afterDelay:3.f];
 }
 
 //在底部添加按钮只需在设置的时候添加按钮即可
 // Configure the button.
 [hud.button setTitle:NSLocalizedString(@"Cancel", @"HUD cancel button title") forState:UIControlStateNormal];
 [hud.button addTarget:self action:@selector(cancelWork:) forControlEvents:UIControlEventTouchUpInside];
 
 
 ***********************/
@end

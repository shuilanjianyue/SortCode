//
//  DGBCenterTitleButton.h
//  Demo
//
//  Created by douguangbin on 16/9/1.
//  Copyright © 2016年 douguangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGBCenterTitleButton : UIButton

@property (nonatomic,strong) NSString *imageName;

@property (nonatomic,strong) NSString *title;

+ (instancetype)centertitleButtonWithImageName:(NSString *)imageName titleName:(NSString *)title;

@end

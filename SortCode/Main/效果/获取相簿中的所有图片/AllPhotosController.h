//
//  AllPhotosController.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/3.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "BaseController.h"

@interface AllPhotosController : BaseController

//所有图片的缩略图
@property(nonatomic,strong)NSArray *photoArray;


//所有图片的PHAsset类
@property(nonatomic,strong)NSArray *assetArray;

@property(nonatomic,strong)NSString *albumName;


@end

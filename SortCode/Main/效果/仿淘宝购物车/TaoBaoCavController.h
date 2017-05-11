//
//  TaoBaoCavController.h
//  总结
//
//  Created by dazaoqiancheng on 16/4/8.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "BaseController.h"

@interface TaoBaoCavController : BaseController
//判断是否展开或者合上的数组.
@property (strong, nonatomic) NSMutableArray *treeOpenArray;
//判断是否展开或者合上的字符串.
@property (strong, nonatomic) NSString *treeOpenString;

@end

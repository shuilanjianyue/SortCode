//
//  ProvinceModel.h
//  总结
//
//  Created by dazaoqiancheng on 16/4/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property(copy,nonatomic)NSString *areano;//地域编号
@property(copy,nonatomic)NSString *areaname;//地域名称
@property(copy,nonatomic)NSString *parentno;//上一级地域编号
@property(copy,nonatomic)NSString *areacode;//编码（一般不用）
@property(copy,nonatomic)NSString *arealevel;//地域级别
@end

//
//  FmdbManger.h
//  总结
//
//  Created by dazaoqiancheng on 16/4/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FmdbManger : NSObject
//所有的省
- (NSMutableArray *)privinceArray;
//所有的市
-(NSMutableArray *)cityArray:(NSString *)parentId;
//所有的区域
-(NSMutableArray *)aeraArray:(NSString *)parentId;
@end

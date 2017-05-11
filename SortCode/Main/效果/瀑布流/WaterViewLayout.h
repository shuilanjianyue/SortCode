//
//  WaterViewLayout.h
//  整理文
//
//  Created by dazaoqiancheng on 17/1/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterViewLayout;
@protocol WaterFlowDelegate <NSObject>


@required
- (CGFloat)waterFlowLayout:(WaterViewLayout *)layout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;


@optional
-(NSInteger)waterFlowLayoutColumnCount:(WaterViewLayout *)layout;

-(CGFloat)waterFlowLayountColumnSpacing:(WaterViewLayout *)layout;


-(NSInteger)waterFlowLayoutRowSpacing:(WaterViewLayout *)layout;

-(UIEdgeInsets)waterFlowLayountEdgeInsets:(WaterViewLayout *)layout;

@end


@interface WaterViewLayout : UICollectionViewLayout<UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *attrArray;

@property(nonatomic,strong)NSMutableArray *maxYarray;

@property(nonatomic,weak)id<WaterFlowDelegate> delegate;

- (NSInteger)columnCount;
- (CGFloat)columSpacing;
-(CGFloat)rowSpacing;
- (UIEdgeInsets)edgeInsets;

@end

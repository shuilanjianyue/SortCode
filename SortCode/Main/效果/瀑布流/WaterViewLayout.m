//
//  WaterViewLayout.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "WaterViewLayout.h"

static NSInteger const DefaultColumnCount =3;
static CGFloat const DefaultColumSpacing = 10;
static CGFloat const DefaultRowSpacing = 10;
static UIEdgeInsets const DefaultEdgeInsets = {10,10,10,10};


@implementation WaterViewLayout

- (NSInteger)columnCount{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnCount:)]) {
        
        return [self.delegate waterFlowLayoutColumnCount:self];
        
    }
    
    return DefaultColumnCount;
    
}
- (CGFloat)columSpacing{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayountColumnSpacing:)]) {
        
        return [self.delegate waterFlowLayountColumnSpacing:self];
        
    }
    
    return DefaultColumSpacing;
}
-(CGFloat)rowSpacing{
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutRowSpacing:)]) {
        
        return [self.delegate waterFlowLayoutRowSpacing:self];
        
    }
    return DefaultRowSpacing;
    
}
- (UIEdgeInsets)edgeInsets{
    
    if ([self.delegate respondsToSelector:@selector(waterFlowLayountEdgeInsets:)]) {
        
        return [self.delegate waterFlowLayountEdgeInsets:self];
        
    }
    
    return DefaultEdgeInsets;
}


- (void)prepareLayout{
    
    [super prepareLayout];
    
    self.attrArray = [NSMutableArray array];
    self.maxYarray = [NSMutableArray array];
    
    
    for (NSInteger i=0; i<[self columnCount]; i++) {
        [self.maxYarray addObject:@([self edgeInsets].top)];
        
    }
    
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i=0; i<itemCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [self.attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
}



-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrArray;
    
}



-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger __block minHeightColumn = 0;
    NSInteger __block minHeight = [self.maxYarray[minHeightColumn] floatValue];
    
    [self.maxYarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        
        if (minHeight>columnHeight) {
            minHeight = columnHeight;
            minHeightColumn = idx;
        }
    }];
    
              
    CGFloat width = (SCREEN_WIDTH-20-[self columSpacing] *([self columnCount]-1))/[self columnCount];
    
    
    CGFloat height = [self.delegate waterFlowLayout:self heightForItemAtIndex:indexPath.item  itemWidth:width];
    
    
    CGFloat originX = [self edgeInsets].left + minHeightColumn *(width + [self columSpacing]);
    
    
    CGFloat originY = minHeight;
    
    
    if (originY != [self edgeInsets].top) {
        
        originY += [self rowSpacing];
    }
    
    
    
    [attributes  setFrame:CGRectMake(originX, originY, width, height)];
    
    self.maxYarray[minHeightColumn] = @(CGRectGetMaxY(attributes.frame));
    
    
    return attributes;
    
}



- (CGSize)collectionViewContentSize{
    
    NSInteger __block maxHeight = 0;
    
    
    [self.maxYarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat columnHeight = [(NSNumber *)obj floatValue];
        
        if (maxHeight<columnHeight) {
            maxHeight = columnHeight;
        }
    }];
    
    
    return CGSizeMake(0, maxHeight + [self edgeInsets].bottom);
}
@end

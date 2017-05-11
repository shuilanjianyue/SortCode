//
//  CustCollectionController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "CustCollectionController.h"
#import "CustHeaderView.h"
#import "CustCell.h"
#import "CustFootView.h"

@interface CustCollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation CustCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
         
    self.navBar.titleLabel.text = @"自定义UICollectionView";
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(75, 75);
    layout.minimumLineSpacing=4;
    layout.minimumInteritemSpacing=0;
    layout.scrollDirection= UICollectionViewScrollDirectionVertical;
    layout.sectionInset=UIEdgeInsetsMake(4, 4,4,4);
    //layout.footerReferenceSize  //定义头部的高度和宽度
    //layout.headerReferenceSize    //定义尾部的高度和宽度
    
    
    //创建一个collection集合视图
    _collectionView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor=UIColorFromRGB(0xebebeb);//背景色
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    //先注册Cell
    [_collectionView registerClass:[CustCell class] forCellWithReuseIdentifier:@"CustCell"];
    
    //先注册头部
     [_collectionView registerClass:[CustHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CustHeaderView"];
    
    [_collectionView registerClass:[CustFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CustFootView"];
    
    [self.view addSubview:_collectionView];
    
    // Do any additional setup after loading the view.
}



#pragma mark - UICollection的数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustCell" forIndexPath:indexPath];
    
    //NSLog(@"%@",self.imArray);
    // UIImage *image21=[self.imArray objectAtIndex:indexPath.row];
    
    
    
    cell.backgroundColor = [UIColor magentaColor];
    
    
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH,55);
    
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH,55);
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind==UICollectionElementKindSectionHeader) {
        
        CustHeaderView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CustHeaderView" forIndexPath:indexPath];
        
       
        return header;
    }else{
        
       CustFootView *footer =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:@"CustFootView" forIndexPath:indexPath];
        
        return footer;
        
    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

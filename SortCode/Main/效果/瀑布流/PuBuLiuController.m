//
//  PuBuLiuController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "PuBuLiuController.h"
#import "WaterViewLayout.h"

@interface PuBuLiuController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowDelegate>


@end

@implementation PuBuLiuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"瀑布流";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    WaterViewLayout *flowLayout = [[WaterViewLayout alloc]init];
    flowLayout.delegate = self;
    
    UICollectionView *myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight) collectionViewLayout:flowLayout];
    
    myCollectionView.dataSource = self;
    myCollectionView.dataSource = self;
    [myCollectionView registerClass:[
                                     UICollectionViewCell class] forCellWithReuseIdentifier:@"pubuliu"];
    
    [self.view addSubview:myCollectionView];
    
    
    // Do any additional setup after loading the view.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pubuliu" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    
    return cell;
}


- (CGFloat)waterFlowLayout:(WaterViewLayout *)layout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    
    return  100 + arc4random_uniform(100);
    
}
- (NSInteger)waterFlowLayoutColumnCount:(WaterViewLayout *)layout{
    
    return 4;
    
}
-(NSInteger)waterFlowLayoutRowSpacing:(WaterViewLayout *)layout{
    
    return 5;
    
}
- (CGFloat)waterFlowLayountColumnSpacing:(WaterViewLayout *)layout{
    
    return 5;
    
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

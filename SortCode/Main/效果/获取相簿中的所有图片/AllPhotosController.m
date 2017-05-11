//
//  AllPhotosController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/3.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "AllPhotosController.h"
#import "BrosePhotoController.h"
#import <Photos/Photos.h>
#import "UIImage+UIImageExtra.h"

@interface AllPhotosController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIButton *broseButton;


@property(nonatomic,strong)UIScrollView *myScrollView;

@property(nonatomic,strong)NSMutableArray *seleArray;


@end

@implementation AllPhotosController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = self.albumName;
    
    self.seleArray = [NSMutableArray array];
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(75, 75);
    layout.minimumLineSpacing=4;
    layout.minimumInteritemSpacing=0;
    layout.scrollDirection= UICollectionViewScrollDirectionVertical;
    layout.sectionInset=UIEdgeInsetsMake(4, 4,4,4);
    //layout.footerReferenceSize  //定义头部的高度和宽度
    //layout.headerReferenceSize    //定义尾部的高度和宽度
    
    
    //创建一个collection集合视图
    _collectionView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight-49) collectionViewLayout:layout];
    _collectionView.backgroundColor=UIColorFromRGB(0xebebeb);//背景色
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.hidden = NO;
    //先注册Cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionCell"];
    
    [self.view addSubview:_collectionView];
    
    
    
    
    _broseButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, SCREEN_HEIGHT - 49 +4.5, 100, 40)];
    [_broseButton setBackgroundColor:[UIColor magentaColor]];
    [_broseButton setTitle:@"浏览" forState:UIControlStateNormal];
    _broseButton.hidden = NO;
    [_broseButton addTarget:self action:@selector(broseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_broseButton];
    
    
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.hidden = YES;
    _myScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_myScrollView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_myScrollView addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}



#pragma mark - UICollection的数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionCell" forIndexPath:indexPath];
    
    UIImageView *shopImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, 75, 75)];
    shopImage.contentMode=UIViewContentModeScaleToFill;
    shopImage.clipsToBounds=YES;
    shopImage.userInteractionEnabled=YES;
    shopImage.image = self.photoArray[indexPath.row];
    [cell addSubview:shopImage];
    
    
    UIButton *seleButton = [[UIButton alloc]initWithFrame:CGRectMake(shopImage.right - 25, shopImage.top + 5, 20, 20)];
    
    seleButton.tag = indexPath.row;
    
    [seleButton addTarget:self action:@selector(slePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [seleButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    
    [shopImage addSubview:seleButton];
    
    
    
    return cell;
    
    
}


- (void)slePhotoAction:(UIButton *)btn{

    
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"未选中"]]) {
        
        //设置放射以及动画
        btn.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            
        }];
        
        [btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        
       [ _seleArray addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        
        [_seleArray removeObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
        
    }
    
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//}





-(void)broseAction{

    
    _collectionView.hidden = YES;
    _broseButton.hidden = YES;
    _myScrollView.hidden = NO;
    
  
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    for (int i=0; i<_seleArray.count; i++) {
        
        NSString *seleID = _seleArray[i];
        
        PHAsset *asset = [_assetArray objectAtIndex:[seleID intValue]];
        
        
        CGSize size =  CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        
        
        //从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            
            //按比例缩小图片
            NSLog(@"%@", result);

            float widths = SCREEN_WIDTH;
            
            float heights = SCREEN_WIDTH/result.size.width *result.size.height;
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, SCREEN_HEIGHT/2 - heights/2, widths, heights)];
            
//            UIImage *newImage = [result image:result newSize:CGSizeMake( widths, heights)];
            
            image.image = result;
            
            [_myScrollView addSubview:image];
            
            _myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *_seleArray.count, SCREEN_HEIGHT);
            
            
            }];
        
    }
    
 
    
    
    
    
    
    
}



- (void)tapAction:(UITapGestureRecognizer *)tap{
    _collectionView.hidden = NO;
    _broseButton.hidden = NO;
    _myScrollView.hidden = YES;
    
    [_myScrollView removeAllSubviews];
    
    
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

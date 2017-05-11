//
//  ShareView.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/7.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "ShareView.h"

#define KSHAREVIEW_HEIGHT   260


@implementation ShareView
{
    UIViewController *_superViewController;
    UIView *_view;
    UICollectionView *_collectionView;
    NSArray *_allImageArray;
    NSArray *_allTitleArray;
    UIButton *_cancellButton;
    
}



- (id)initWithSuperViewController:(UIViewController *)viewController urlString:(NSString *)urlString shareImage:(UIImage *)shareImage
{
    
    CGRect rect = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, KSHAREVIEW_HEIGHT);
    
    
    self = [super initWithFrame:rect];
    if (self) {
        _superViewController = viewController;
        
        
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        
        _view.hidden = YES;
        [_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [viewController.view addSubview:_view];
        
        
        
        [_view addSubview:self];
        
        _view.userInteractionEnabled = YES;
        
        
        UIView *tapView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KSHAREVIEW_HEIGHT)];
        tapView.backgroundColor=[UIColor clearColor];
        
        [_view addSubview:tapView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [tapView addGestureRecognizer:tap];
        
        
        //初始化
        self.backgroundColor=[UIColor whiteColor];
        
        _allTitleArray=@[@"QQ",@"QQ空间",@"微信",@"朋友圈",@"新浪微博",@"短信"];
        
        self.shareUrlS = urlString;
        self.shareImageS = shareImage;
        
        
        [self initSubView];
        
        
        // Initialization code
    }
    
    
    return self;
}






#pragma mark - 初始化
-(void)initSubView
{
    //分享
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(58, 58+25);
    
    //  layout.minimumLineSpacing=(SCREEN_WIDTH-58*3)/4-1;
    layout.minimumLineSpacing=10;
    // layout.minimumInteritemSpacing=(SCREEN_WIDTH-58*3)/4-1;
    
    layout.scrollDirection= UICollectionViewScrollDirectionVertical;
    
    layout.sectionInset=UIEdgeInsetsMake(0, (SCREEN_WIDTH-58*3)/4-1,0,(SCREEN_WIDTH-58*3)/4-1);
    
    //创建一个collection集合视图
    _collectionView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH,180) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor=[UIColor clearColor];
    //先注册  ，里面的class是获取类名的
    // 1.注册cell要用到的xib
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.scrollEnabled = NO;
    
    [self addSubview:_collectionView];
    
    
    //取消
    _cancellButton=[[UIButton alloc]init];
    [_cancellButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancellButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _cancellButton.layer.masksToBounds = YES;
    _cancellButton.layer.cornerRadius = 5;
    _cancellButton.backgroundColor = [UIColor magentaColor];
    _cancellButton.frame=CGRectMake(30, KSHAREVIEW_HEIGHT-40, SCREEN_WIDTH-60, 30);
    [_cancellButton addTarget:self action:@selector(cancellBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancellButton];
    
}


#pragma mark - 取消
- (void)cancellBtn{
    
    [self hideTheView];
    
}


#pragma mark - 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
   // CGPoint point = [tap locationInView:_view];//获取点击位置
   // UIView *tapView = tap.view;//获取点击的视图
    
    
    [self hideTheView];
    
}


- (void)show
{
    _view.hidden = NO;

    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = SCREEN_HEIGHT-KSHAREVIEW_HEIGHT;
        self.frame = frame;
        [_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - 隐藏view
- (void)hideTheView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.frame;
        frame.origin.y = SCREEN_HEIGHT;
        self.frame = frame;
        
        [_view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        
    } completion:^(BOOL finished) {
        _view.hidden = YES;
        
    }];
}


#pragma mark - 数据源事件
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _allTitleArray.count;
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *fenImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 58, 58)];
    fenImage.userInteractionEnabled=YES;
    fenImage.image=[UIImage imageNamed:_allTitleArray[indexPath.row]];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, fenImage.bottom+5, 58, 20)];
    label.font=[UIFont systemFontOfSize:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=UIColorFromRGB(0x646464);
    label.text=_allTitleArray[indexPath.row];
    [cell.contentView addSubview:label];
    
    [cell.contentView addSubview:fenImage];
    
    return cell;
    
}


#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // UIViewController *vc = _superViewController;
    
    [self hideTheView];
    
  
    NSLog(@"fffff");
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

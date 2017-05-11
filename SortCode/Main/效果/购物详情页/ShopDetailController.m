//
//  ShopDetailController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/27.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ShopDetailController.h"
#import "TapButtonView.h"

@interface ShopDetailController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>




@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIView *headerView;//tableView的头部视图


@property(nonatomic,strong)UIView *navBarView;//头部导航条
@property(nonatomic,strong)UIButton *backButton;//返回按钮


@property(nonatomic,strong)UIView *topView;//头部视图


@property(nonatomic,strong)UIScrollView *topScrollView;//轮播图  tableView覆盖住了

@property(nonatomic,strong)NSArray *topArray;//轮播图数组

@property(nonatomic,strong)UIScrollView *bgScrollView;//底部视图

@property(nonatomic,assign)int currentScroll;//topScrollView滚动的位置


@property(nonatomic,strong)UIScrollView *clearScrollView;//透明的ScrollView

@property(nonatomic,strong)UIWebView *myWebView;//加载


@end

@implementation ShopDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.hidden = YES;
    
    
    //返回按钮第一层
    self.backButton = [[UIButton alloc]initWithFrame:CGRectMake(8, 31, 27, 27)];
    [self.backButton setImage:[UIImage imageNamed:@"shopDetailBack"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    //头部导航条第二层
    self.navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavHeight)];
    self.navBarView.backgroundColor = [UIColor whiteColor];
    self.navBarView.alpha = 0.0f;
    [self.view insertSubview:self.navBarView belowSubview:self.backButton];
    
    
    
    //tableView第三层
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavHeight,SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-NavHeight)];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.myTableView.tableHeaderView = self.headerView;
    self.myTableView.tableHeaderView.height = SCREEN_WIDTH-NavHeight;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view insertSubview:self.myTableView belowSubview:self.navBarView];
    
    
    
    //顶部视图第四层
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.topView.userInteractionEnabled = YES;
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:self.topView belowSubview:self.myTableView];
    
    
    [self initTopScrollView];
    [self initClearScrollView];
    
    // Do any additional setup after loading the view.
}

#pragma maek - 加载
-(void)initTopScrollView{
    
    self.topArray = @[@"孙翠花.jpg",@"孙翠花夜.jpg",@"孙翠花4.jpg"];
    self.topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.pagingEnabled = YES;
    self.topScrollView.backgroundColor = [UIColor clearColor];
    self.topScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_WIDTH);
    
    [self.topView addSubview:self.topScrollView];
    
    
    
    for (int i=0; i<3; i++) {
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        images.image = [UIImage imageNamed:self.topArray[i]];
        [self.topScrollView addSubview:images];
        
    }
  
}



#pragma maek - 创建透明的ScrollView
-(void)initClearScrollView{
    
    self.clearScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-NavHeight)];
    self.clearScrollView.showsVerticalScrollIndicator = NO;
    self.clearScrollView.showsHorizontalScrollIndicator = NO;
    self.clearScrollView.pagingEnabled = YES;
    self.clearScrollView.delegate = self;
    self.clearScrollView.backgroundColor = [UIColor clearColor];
    self.clearScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_WIDTH-NavHeight);
    
    [self.headerView addSubview:self.clearScrollView];
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
         return 10;
    }
   
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *indentifer = @"gouwu";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        }
        
        cell.textLabel.text=@"购物详情页";
        
        
        return cell;
    }else{
        
       UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        _myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight-50)];
        _myWebView.scrollView.delegate = self;
        _myWebView.scrollView.scrollEnabled = NO;
        //添加webview到当前viewcontroller的view上
        [cell.contentView addSubview:_myWebView];
        
        
        //网址
        NSURL *htmlUrl = [NSURL URLWithString:@"https://baidu.com"];
        NSURLRequest *httpRequest=[NSURLRequest requestWithURL:htmlUrl];
        [_myWebView loadRequest:httpRequest];
        
        
        return cell;
        
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return SCREEN_HEIGHT - NavHeight - 50;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0000001;
    }
    
    
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
        
    }
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    TapButtonView *button = [[TapButtonView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    NSArray *buA = @[@"商品详情",@"产品参数",@"支付流程"];
    
    [button addButton:buA index:1];
    
    
    [bgView addSubview:button];
    
    return bgView;
}



#pragma mark - 改变位置关系
- (void)change:(CGFloat)offSet{
    
   // NSLog(@"self.myTableView= %f",offSet);
    
    if (offSet>0) {
        
        CGRect frame = self.topView.frame;
        frame.origin.y = - offSet / 2.0;
        self.topView.frame = frame;
        
        
        if (offSet>=(SCREEN_WIDTH-NavHeight)) {
            self.navBarView.alpha = 1.0f;//导航条
            [self.backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];//按钮
        }else{
            
            self.navBarView.alpha = offSet / (SCREEN_WIDTH - NavHeight);
            //yidongdao(SCREEN_WIDTH-NavHeight)的一半时
            if (offSet>(SCREEN_WIDTH-NavHeight)/2) {
                [self.backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];//按钮
                self.backButton.alpha = offSet / ((SCREEN_WIDTH - 64) / 2.0) - 1;
            }else{
                
                [self.backButton setImage:[UIImage imageNamed:@"shopDetailBack"] forState:UIControlStateNormal];//按钮
                self.backButton.alpha =1- offSet / ((SCREEN_WIDTH - 64) / 2.0);
            }
            
        }
       
        
        NSLog(@"self.myTableView.contentOffset.y %f",self.myTableView.contentOffset.y);
        
        NSLog(@"self.myTableView.contentSize.height %f",self.myTableView.contentSize.height - self.myTableView.height);
        
        if (self.myTableView.contentOffset.y<self.myTableView.contentSize.height - self.myTableView.height-1) {
            _myWebView.scrollView.scrollEnabled = NO;
            self.myTableView.bounces = YES;
            
        }else{
            
            _myWebView.scrollView.scrollEnabled = YES;
            self.myTableView.bounces = NO;
            
        }
        
    }else{
        
        
        //顶部视图的位置变化
        CGRect frame = self.topView.frame;
        frame.origin.y = 0;
        frame.size.height = SCREEN_WIDTH-offSet;
        self.topView.frame = frame;
        
        //轮播图位置变化
        CGRect topScrollViewFrame = self.topScrollView.frame;
        topScrollViewFrame.size.height =SCREEN_WIDTH-offSet;
        self.topScrollView.frame = topScrollViewFrame;
        self.topScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_WIDTH-offSet);
        
        
        UIImageView *images =self.topScrollView.subviews[self.currentScroll];
        
        images.clipsToBounds = YES;
        images.contentMode = UIViewContentModeScaleAspectFill;
        images.frame = CGRectMake(SCREEN_WIDTH *self.currentScroll, 0, SCREEN_WIDTH, SCREEN_WIDTH-offSet);
        //
        
        self.navBarView.alpha = 0.0f;
        [self.backButton setImage:[UIImage imageNamed:@"shopDetailBack"] forState:UIControlStateNormal];//按钮
        self.backButton.alpha = 1.0f;
        
    }
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.myTableView) {
        
        [self change:scrollView.contentOffset.y];
        
        
    }else if (scrollView == self.clearScrollView){
        
        self.topScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        
        //NSLog(@"self.clearScrollView = %f",scrollView.contentOffset.x);
        
        
    }else if (scrollView == _myWebView.scrollView){
        
        if (_myWebView.scrollView.contentOffset.y < 0) {
            _myWebView.scrollView.scrollEnabled = NO;
        }
        
    }
    
    
}


#pragma mark - 结束滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.clearScrollView) {
        
        self.currentScroll = scrollView.contentOffset.x/SCREEN_WIDTH;
        
    }else{
        return;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

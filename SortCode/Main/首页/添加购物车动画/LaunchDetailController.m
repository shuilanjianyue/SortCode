//
//  LaunchDetailController.m
//  总结
//
//  Created by dazaoqiancheng on 16/3/25.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "LaunchDetailController.h"
#import "LaunDeCell.h"
#import "LaunchFCell.h"
#import "LaunchGouCell.h"

@interface LaunchDetailController ()
{
    UIScrollView *scrollView;
    NSMutableDictionary *nameDic;//名字
    NSMutableDictionary *priceDic;//价格
    NSMutableDictionary *countDic;//数量
    
    UIView *shopView;//这早视图
    
    LaunchFCell *bottomCell;
    
    float totl;//总价
}

@property(nonatomic,strong)LaunDeCell *launCell;

@property(nonatomic,strong)NSMutableArray *goodArray;//规格

@property(nonatomic,strong)NSDictionary *dictsD;

@end

@implementation LaunchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"菜品详情";
    
    
    //适配iOS系统
    if (iOS7) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    

    
    nameDic=[NSMutableDictionary dictionary];
    priceDic=[NSMutableDictionary dictionary];
    countDic=[NSMutableDictionary dictionary];
    
    self.dictsD=[NSDictionary dictionary];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.goodArray=[NSMutableArray array];
    
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64-55-NavHeight)];
    
    //    scrollView.backgroundColor=[UIColor redColor];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    [self getCategoryGood];
    
    [self initMask];
    

    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    bottomCell = [[[NSBundle mainBundle]loadNibNamed:@"LaunchFCell" owner:self options:nil]lastObject];
    
    [bottomCell.tapButton addTarget:self action:@selector(tapB) forControlEvents:
     UIControlEventTouchUpInside];
    
    [bottomCell.seleButton addTarget:self action:@selector(selectB) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *nameDictory=[ds objectForKey:@"nameDic"];
    [nameDic addEntriesFromDictionary:nameDictory];
    
    NSDictionary *priceDictory=[ds objectForKey:@"priceDic"];
    [priceDic addEntriesFromDictionary:priceDictory];
    NSDictionary *countDictory=[ds objectForKey:@"countDic"];
    [countDic addEntriesFromDictionary:countDictory];
    NSArray *allPrice=[priceDictory allValues];
    NSArray *allPrKey=[priceDictory allKeys];
    
    int counta=0;
    
    totl=0;
    
    for (int i=0; i<allPrice.count; i++) {
        
        float pri=[[allPrice objectAtIndex:i] floatValue];
        
        NSString *gh=[allPrKey objectAtIndex:i];
        float cou=[[countDictory objectForKey:gh] floatValue];
        counta=counta+cou;
        
        totl=totl+cou*pri;
    }
    
    
    if (totl>0) {
        
        bottomCell.shopLabel.hidden=NO;
        bottomCell.shopLabel.text=[NSString stringWithFormat:@"%d",counta];
        bottomCell.stateLabel.text=[NSString stringWithFormat:@"￥%.2f元",totl];
        
    }else{
        bottomCell.stateLabel.text=@"购物车是空的";
        bottomCell.shopLabel.hidden=YES;
    }
    
    
    bottomCell.frame=CGRectMake(0, SCREEN_HEIGHT-55-64, SCREEN_WIDTH, 55);
    
    
    [self.view addSubview:bottomCell];
}



#pragma mark -选好了

- (void)selectB{
    
    
    shopView.hidden=YES;

    
    
    
    if ([bottomCell.peiLabel.text isEqualToString:@"选好了"]) {
        
        
        
    }else {
        
       
        
    }
    
    
}


#pragma mark - 初始化遮早视图
- (void)initMask{
    
    shopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-55-64)];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [shopView addGestureRecognizer:tap];
    
    self.shopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-55-64) style:UITableViewStyleGrouped];
    self.shopTableView.backgroundView = nil;
    self.shopTableView.showsHorizontalScrollIndicator=NO;
    self.shopTableView.showsVerticalScrollIndicator=NO;
    self.shopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.shopTableView.delegate=self;
    self.shopTableView.dataSource=self;
    self.shopTableView.backgroundColor=[UIColor clearColor];
    [shopView addSubview:self.shopTableView];
    
    shopView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    
    shopView.hidden=YES;
    
    [self.view addSubview:shopView];
    // [self.view insertSubview:shopView aboveSubview:self.leftTableView];
    
}


- (void)tapView:(UITapGestureRecognizer *)tap{
    
    shopView.hidden=YES;
    
}


#pragma mark  - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *nameDictory=[ds objectForKey:@"nameDic"];
    
    return nameDictory.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *indentifer = @"LaunchGouCell";
    LaunchGouCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LaunchGouCell" owner:self options:nil]lastObject];
        
    }
    
    
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *nameDictory=[ds objectForKey:@"nameDic"];
    
    NSDictionary *priceDictory=[ds objectForKey:@"priceDic"];
    
    NSDictionary *countDictory=[ds objectForKey:@"countDic"];
    
    if(nameDictory.count>0){
        
        NSArray *fir=[nameDictory allValues];
        NSArray *sec=[nameDictory allKeys];
        
        cell.nameLabel.text=[fir objectAtIndex:indexPath.row];
        
        cell.priceLabel.text= [NSString stringWithFormat:@"￥%@",[priceDictory objectForKey:[sec objectAtIndex:indexPath.row]]];
        cell.countLabel.text=[countDictory objectForKey:[sec objectAtIndex:indexPath.row]];
        cell.plusButton.tag=indexPath.row;
        [cell.plusButton addTarget:self action:@selector(addButtons:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.minusButton.tag=indexPath.row;
        [cell.minusButton addTarget:self action:@selector(minusButtons:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor=UIColorFromRGB(0xf0f0f0);
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-100, 30)];
    label.text=@"购物车";
    label.textColor=UIColorFromRGB(0x646464);
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, 2.5, 80, 25)];
    [button setImage:[UIImage imageNamed:@"clearGouwuche"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancellT) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 点击购物车
- (void)tapB{
    
    
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *nameDictory=[ds objectForKey:@"nameDic"];
    
    
    if (nameDictory.count==0) {
        
        shopView.hidden=YES;
        
    }else{
        
        if (shopView.hidden==NO) {
            
            
            shopView.hidden=YES;
            
            
        }else{
            
            if (nameDictory.count==1) {
                
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-55-40-30-64, SCREEN_WIDTH, 40+30);
            }else if (nameDictory.count==2){
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-55-30-40*2-64, SCREEN_WIDTH, 40*2+30);
            }else if (nameDictory.count==3){
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-55-30-40*3-64, SCREEN_WIDTH, 40*3+30);
            }else if (nameDictory.count==4){
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-55-30-40*4-64, SCREEN_WIDTH, 40*4+30);
            }else{
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-40*5-55-30-64, SCREEN_WIDTH, 40*5+30);
            }
            
            shopView.hidden=NO;
        }
    }
    
    
    [self.shopTableView reloadData];
    
}


#pragma mark - 清除全部
- (void)cancellT{
    
    [nameDic removeAllObjects];
    [countDic removeAllObjects];
    [priceDic removeAllObjects];
    shopView.hidden=YES;
    bottomCell.stateLabel.text=@"购物车是空的";
    bottomCell.shopLabel.hidden=YES;
    bottomCell.shopLabel.text=@"0";
    
    
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setValue:nameDic forKey:@"nameDic"];
    [userDef setValue:priceDic forKey:@"priceDic"];
    [userDef setValue:countDic forKey:@"countDic"];
    [userDef synchronize];
    
    
    float pei=2.0;
    
    totl=0;
    
    if(pei-totl>0){
        
        NSString *fg=[NSString stringWithFormat:@"还差%.2f配送",pei-totl];
        
        bottomCell.peiLabel.text=fg;
        
    }else{
        bottomCell.peiLabel.text=@"选好了";
        
    }
    
}

#pragma mark - 添加
- (void)addButtons:(UIButton *)button{
    
    bottomCell.shopLabel.hidden=NO;
    
    int  couf=[bottomCell.shopLabel.text intValue];
    
    bottomCell.shopLabel.text=[NSString stringWithFormat:@"%d",couf+1];
    
    NSArray *allkey=[nameDic allKeys];
    
    NSString *gooid2;
    
    gooid2=[NSString stringWithFormat:@"%@",[allkey objectAtIndex:button.tag]];
    
    
    int count=[[countDic objectForKey:gooid2] intValue];
    count=count+1;
    
    [countDic setObject:[NSString stringWithFormat:@"%d",count] forKey:gooid2];
    
    NSArray *allPrice=[priceDic allValues];
    NSArray *allPrKey=[priceDic allKeys];
    
    totl=0;
    
    for (int i=0; i<allPrice.count; i++) {
        float pri=[[allPrice objectAtIndex:i] floatValue];
        
        NSString *gh=[allPrKey objectAtIndex:i];
        float cou=[[countDic objectForKey:gh] floatValue];
        totl=totl+cou*pri;
    }
    
    
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setValue:nameDic forKey:@"nameDic"];
    [userDef setValue:priceDic forKey:@"priceDic"];
    [userDef setValue:countDic forKey:@"countDic"];
    [userDef synchronize];
    
    bottomCell.stateLabel.text=[NSString stringWithFormat:@"￥%.2f元",totl];
    
    
    float pei=2.0;
    
    if(pei-totl>0){
        
        NSString *fg=[NSString stringWithFormat:@"还差%.2f配送",pei-totl];
        
        bottomCell.peiLabel.text=fg;
        
    }else{
        bottomCell.peiLabel.text=@"选好了";
        
    }
    
    
    [self.shopTableView reloadData];
    
}


#pragma mark - 减少

- (void)minusButtons:(UIButton *)button{
    
    int  couf=[bottomCell.shopLabel.text intValue];
    if (couf==1) {
        bottomCell.shopLabel.hidden=YES;
        shopView.hidden=YES;
    }else{
        bottomCell.shopLabel.hidden=NO;
        shopView.hidden=NO;
    }
    
    
    bottomCell.shopLabel.text=[NSString stringWithFormat:@"%d",couf-1];
    
    NSArray *allkey=[nameDic allKeys];
    
    NSString *gooid2;
    
    gooid2=[NSString stringWithFormat:@"%@",[allkey objectAtIndex:button.tag]];
    
    
    int count=[[countDic objectForKey:gooid2] intValue];
    
    if (couf==1) {
        
        shopView.hidden=YES;
        [nameDic removeObjectForKey:gooid2];
        [priceDic removeObjectForKey:gooid2];
        [countDic removeObjectForKey:gooid2];
    }else{
        
        if (count==1) {
            
            [nameDic removeObjectForKey:gooid2];
            [priceDic removeObjectForKey:gooid2];
            [countDic removeObjectForKey:gooid2];
            
            
            
            if (nameDic.count<5) {
                
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-nameDic.count*40-55-30-64, SCREEN_WIDTH, nameDic.count*40+30);
                
            }else{
                
            }
            
        }else{
            
            count=count-1;
            
            [countDic setObject:[NSString stringWithFormat:@"%d",count] forKey:gooid2];
            
        }
    }
    
    
    if (nameDic.count>0) {
        NSArray *allPrice=[priceDic allValues];
        NSArray *allPrKey=[priceDic allKeys];
        
        totl=0;
        
        for (int i=0; i<allPrice.count; i++) {
            float pri=[[allPrice objectAtIndex:i] floatValue];
            
            NSString *gh=[allPrKey objectAtIndex:i];
            float cou=[[countDic objectForKey:gh] floatValue];
            totl=totl+cou*pri;
        }
        
        
        bottomCell.stateLabel.text=[NSString stringWithFormat:@"￥%.2f元",totl];
    }else{
        totl=0;
        bottomCell.stateLabel.text=@"购物车是空的";
    }
    
    
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setValue:nameDic forKey:@"nameDic"];
    [userDef setValue:priceDic forKey:@"priceDic"];
    [userDef setValue:countDic forKey:@"countDic"];
    [userDef synchronize];
    
    float pei=2.0;
    
    if(pei-totl>0){
        
        NSString *fg=[NSString stringWithFormat:@"还差%.2f配送",pei-totl];
        
        bottomCell.peiLabel.text=fg;
        
    }else{
        bottomCell.peiLabel.text=@"选好了";
        
    }
    
    
    [self.shopTableView reloadData];
    
    
}


#pragma mark - 加入购物车
- (void)dianButtons:(UIButton *)button{
    
    
    //实现加入购物车动画
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    transitionLayer.cornerRadius = 7.5;
    transitionLayer.masksToBounds=YES;
    transitionLayer.contents = (id)button.titleLabel.layer.contents;
    transitionLayer.backgroundColor=[UIColor redColor].CGColor;
    
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:CGRectMake(0, 0, 15, 15) fromView:button.titleLabel];//参照的视图
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    CGPoint toPoint = CGPointMake(bottomCell.center.x+33-SCREEN_WIDTH/2, bottomCell.center.y+55);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(bottomCell.center.x+28-SCREEN_WIDTH/2,transitionLayer.position.y)];
    
    //关键帧 位置的变化
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion=NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration =1.f;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    
    [transitionLayer addAnimation:group forKey:@"opacity"];
    
    [self performSelector:@selector(addShopFinished:) withObject:transitionLayer afterDelay:1];
    
}


//加入购物车 步骤2
- (void)addShopFinished:(CALayer*)transitionLayer{
    
    transitionLayer.opacity = 0;
    [transitionLayer removeAllAnimations];
    
    bottomCell.shopLabel.hidden=NO;
    
    int  couf=[bottomCell.shopLabel.text intValue];
    
    bottomCell.shopLabel.text=[NSString stringWithFormat:@"%d",couf+1];
    
    NSString *gooid2;
    
    if (self.goodArray.count>0) {
        
        YunSModel *model=[self.goodArray objectAtIndex:self.launCell.guiButton.tag-1];
        
        NSString *good3=[NSString stringWithFormat:@"%@",model.id];
        
        gooid2=[NSString stringWithFormat:@"%@|%@",self.shopid,good3];
        
        NSString *goodName=[NSString stringWithFormat:@"%@(%@)",[self.dictsD objectForKey:@"name"],model.name];
        
        [nameDic setObject:goodName forKey:gooid2];
        
        [priceDic setObject:[NSString stringWithFormat:@"%@",model.price] forKey:gooid2];
        
        
    }else{
        
        gooid2=[NSString stringWithFormat:@"%@",self.shopid];
        [nameDic setObject:[self.dictsD objectForKey:@"name"] forKey:gooid2];
        
        [priceDic setObject:[self.dictsD objectForKey:@"price"] forKey:gooid2];
    }
    
    
    
    
    
    
    
    int count=[[countDic objectForKey:gooid2] intValue];
    count=count+1;
    
    [countDic setObject:[NSString stringWithFormat:@"%d",count] forKey:gooid2];
    
    
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setValue:nameDic forKey:@"nameDic"];
    [userDef setValue:priceDic forKey:@"priceDic"];
    [userDef setValue:countDic forKey:@"countDic"];
    [userDef synchronize];
    
    
    
    NSArray *allPrice=[priceDic allValues];
    NSArray *allPrKey=[priceDic allKeys];
    
    totl=0;
    
    
    for (int i=0; i<allPrice.count; i++) {
        float pri=[[allPrice objectAtIndex:i] floatValue];
        
        NSString *gh=[allPrKey objectAtIndex:i];
        float cou=[[countDic objectForKey:gh] floatValue];
        totl=totl+cou*pri;
    }
    
    bottomCell.stateLabel.text=[NSString stringWithFormat:@"￥%.2f元",totl];
    
    float pei=2.0;
    
    if(pei-totl>0){
        
        NSString *fg=[NSString stringWithFormat:@"还差%.2f配送",pei-totl];
        
        bottomCell.peiLabel.text=fg;
        
        
    }else{
        
        bottomCell.peiLabel.text=@"选好了";
        
    }
    
    [self.shopTableView reloadData];
}



#pragma mark - 获取美食详情

- (void)getCategoryGood{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.shopid, @"id", nil];
    
    __weak typeof(self) weakSelf = self;
    
    [manager GET:@"http://101.200.211.9/yunsong/phone/food_get.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *codes=[responseObject objectForKey:@"code"];
        if([codes integerValue] == 1){
            
            NSString *dataNs=[responseObject objectForKey:@"data"];
            //转化
            NSData *data=[dataNs dataUsingEncoding:NSUTF8StringEncoding];
            //解析数据
            weakSelf.dictsD=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *stand=[weakSelf.dictsD objectForKey:@"standards"];
            
            
            
            for (id all in stand) {
                
                YunSModel *model=[[YunSModel alloc]init];
                [model setValuesForKeysWithDictionary:all];
                [weakSelf.goodArray addObject:model];
                
            }
            
            weakSelf.launCell= [[[NSBundle mainBundle]loadNibNamed:@"LaunDeCell" owner:self options:nil]lastObject];
            weakSelf.launCell.userInteractionEnabled=YES;
            
            weakSelf.launCell.arrays=weakSelf.goodArray;
            
            weakSelf.launCell.money=[NSString stringWithFormat:@"%@",[weakSelf.dictsD objectForKey:@"price"]] ;
            
            [weakSelf.launCell.justButton addTarget:self action:@selector(dianButtons:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollView addSubview:weakSelf.launCell];
            
            //[weakSelf.launCell.shopImageV sd_setImageWithURL:[NSURL URLWithString:[weakSelf.dictsD objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@""]];
            weakSelf.launCell.nameLabel.text=[weakSelf.dictsD objectForKey:@"name"];
            weakSelf.launCell.saleLabel.text=[NSString stringWithFormat:@"已售%@份",[weakSelf.dictsD objectForKey:@"sell_number"]];
            weakSelf.launCell.contentLabel.text=[weakSelf.dictsD objectForKey:@"descr"];
            weakSelf.launCell.desc=[weakSelf.dictsD objectForKey:@"descr"];
            
            
            NSDictionary *arrtribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            CGSize size = [[weakSelf.dictsD objectForKey:@"descr"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 50000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrtribute context:nil].size;
            
            weakSelf.launCell.frame=CGRectMake(0,0, SCREEN_WIDTH, 320+size.height+180);
            
            scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 320+size.height+180);
            
            
        } else {
            
            
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
  
    
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

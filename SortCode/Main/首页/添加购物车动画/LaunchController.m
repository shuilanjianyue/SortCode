//
//  LaunchController.m
//  总结
//
//  Created by dazaoqiancheng on 16/3/25.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "LaunchController.h"
#import "LaunchCell.h"
#import "LaunchFCell.h"
#import "LaunchGouCell.h"
#import "LaunchDetailController.h"


@interface LaunchController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger indexRow;//点击左边时
    NSString *cateid;//分类id
    
    
    UIView *shopView;//这早视图
    
    LaunchFCell *bottomCell;
    
    NSString *bodfess;//餐盒费
    
    NSMutableDictionary *nameDic;//名字
    NSMutableDictionary *priceDic;//价格
    NSMutableDictionary *countDic;//数量
    
    float totl;//总价
    
    int allCount;//数量
    
    NSString *allGoodid;//餐品id
    
    YunSModel *goodModel;

    
}
@property(nonatomic,strong)UITableView *myTableView;//餐厅

@property(nonatomic,strong)UITableView *leftTableView;//左边

@property(nonatomic,strong)UITableView *shopTableView;//加入购物车
@property(nonatomic,strong)NSMutableArray *cateArray;//美食分类列表

@property(nonatomic,strong)NSMutableArray *goodArray;//美食列表
@end

@implementation LaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text =@"餐厅";
    
    //适配iOS系统
    if (iOS7) {
                   self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    
    self.view.backgroundColor=[UIColor whiteColor];

    
    
    self.cateArray=[NSMutableArray array];
    self.goodArray=[NSMutableArray array];
    
    [self initSubView];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //[self getfree];
    [self getCategory];

    
    nameDic=[NSMutableDictionary dictionary];
    priceDic=[NSMutableDictionary dictionary];
    countDic=[NSMutableDictionary dictionary];
    
    
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
    
    bottomCell.frame=CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH, 55);
    
    
    [self.view addSubview:bottomCell];
    
    
}


#pragma mark -选好了

- (void)selectB{
    
    shopView.hidden=YES;

    
    if ([bottomCell.peiLabel.text isEqualToString:@"选好了"]) {
        
        
    }else {
        
    }
    
    
}




- (void)initSubView{
    
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, 80, SCREEN_HEIGHT-64-55-NavHeight) style:UITableViewStylePlain];
    //去掉背景色
    self.leftTableView.showsVerticalScrollIndicator=NO;
    self.leftTableView.showsHorizontalScrollIndicator=NO;
    
    self.leftTableView.backgroundView = nil;
    self.leftTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.leftTableView.delegate=self;
    self.leftTableView.dataSource=self;
    self.leftTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.leftTableView];
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.leftTableView.right+10, NavHeight, SCREEN_WIDTH-80-10, SCREEN_HEIGHT-64-55-NavHeight) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.backgroundView = nil;
    self.myTableView.showsHorizontalScrollIndicator=NO;
    self.myTableView.showsVerticalScrollIndicator=NO;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];
   
    [self initMask];
}

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
    
}


-(void)tapView:(UITapGestureRecognizer *)tap{
    
    shopView.hidden=YES;
    
}


#pragma mark  - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.leftTableView) {
        return self.cateArray.count+1;
        
    }else if (tableView==self.myTableView){
        return self.goodArray.count;
    }
    
    
    NSUserDefaults *ds=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *nameDictory=[ds objectForKey:@"nameDic"];
    
    return nameDictory.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView==self.leftTableView){
        
        UITableViewCell  *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        
        
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2.5, 40)];
        im.backgroundColor=UIColorFromRGB(0xf37221);
        im.hidden=YES;
        [cell.contentView addSubview:im];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==indexRow) {
            label.textColor=UIColorFromRGB(0xf37221);
            im.hidden=NO;
            cell.backgroundColor=UIColorFromRGB(0xffffff);
            
        }else{
            
            label.textColor=[UIColor blackColor];
            im.hidden=YES;
            cell.backgroundColor=[UIColor lightGrayColor];
        }
        

            if(indexPath.row==0){
                label.text=@"全部商品";
            }else{
                
                if (self.cateArray.count>0) {
                    YunSModel *model=[self.cateArray objectAtIndex:indexPath.row-1];
                    label.text=model.name;
                }
                
            }

        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, 80, 0.5)];
        line.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:line];
        
        return cell;
        
        
    }else if(tableView==self.myTableView){
        
        static NSString *indentifer = @"LaunchCell";
        LaunchCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LaunchCell" owner:self options:nil]lastObject];
            
        }
        
        
        [cell.selectedButton addTarget:self action:@selector(seleDesc:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectedButton.tag=indexPath.row;
        
        cell.dianButton.tag=indexPath.row;
        [cell.dianButton addTarget:self action:@selector(dianButtons:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.goodArray.count>0) {
            YunSModel *model=[self.goodArray objectAtIndex:indexPath.row];
            
            cell.model=model;
            
        //    bodfess=model.box_fee;
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
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
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.myTableView) {
        return 90;
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView==self.shopTableView) {
        return 30;
    }else{
        return 0.0000001;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==self.shopTableView) {
        
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
        
        
    }else{
        
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.leftTableView) {
        
        indexRow=indexPath.row;
        
        if (indexPath.row==0) {
            
            cateid=@"";
            
            [self getCategoryGood:@"" pageNu:@"1" orderBy:@"" orderType:@""];
            
        }else{
            
            YunSModel *model=[self.cateArray objectAtIndex:indexPath.row-1];
            
            cateid=model.id;
            
            [self getCategoryGood:model.id pageNu:@"1" orderBy:@"" orderType:@""];
        }
        
        
        [self.leftTableView reloadData];
        
    }else if (tableView==self.myTableView){
        
        LaunchDetailController *laun=[[LaunchDetailController alloc]init];
        YunSModel *model=[self.goodArray objectAtIndex:indexPath.row];
        laun.shopid=model.id;
        
        [self.navigationController pushViewController:laun animated:YES];
    }
}



#pragma mark - 点击可选规格
- (void)seleDesc:(UIButton *)btn{
    
    LaunchDetailController *laun=[[LaunchDetailController alloc]init];
    YunSModel *model=[self.goodArray objectAtIndex:btn.tag];
    laun.shopid=model.id;
    [self.navigationController pushViewController:laun animated:YES];
    
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
                
                self.shopTableView.frame=CGRectMake(0, SCREEN_HEIGHT-nameDic.count*40-55-30, SCREEN_WIDTH, nameDic.count*40+30);
                
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
    
    
    
    allCount=[bottomCell.shopLabel.text intValue];
    
    bottomCell.shopLabel.text=[NSString stringWithFormat:@"%d",allCount+1];
    
    goodModel=[self.goodArray objectAtIndex:button.tag];
    
    
    allGoodid=[NSString stringWithFormat:@"%@",goodModel.id];
    
    
    //动画的核心部分
    
    //实现加入购物车动画
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    transitionLayer.cornerRadius = 7.5;
    transitionLayer.masksToBounds=YES;
    transitionLayer.contents = (id)button.titleLabel.layer.contents;
    transitionLayer.backgroundColor=[UIColor redColor].CGColor;
    
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:CGRectMake(10, 15, 15, 15) fromView:button.titleLabel];//参照的视图
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    CGPoint toPoint = CGPointMake(bottomCell.center.x+33-SCREEN_WIDTH/2, bottomCell.center.y+55);//这个55可是关键呀
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(bottomCell.center.x+28-SCREEN_WIDTH/2,transitionLayer.position.y)];
    
    //关键帧 位置的变化
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion=NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 1;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    
    [transitionLayer addAnimation:group forKey:@"opacity"];
    
    [self performSelector:@selector(addShopFinished:) withObject:transitionLayer afterDelay:1.f];
    
}

//加入购物车 步骤2
- (void)addShopFinished:(CALayer*)transitionLayer{
    
    transitionLayer.opacity = 0;
    [transitionLayer removeAllAnimations];
    
    bottomCell.shopLabel.hidden=NO;
    
    
    
    
    [nameDic setObject:goodModel.name forKey:allGoodid];
    
    [priceDic setObject:goodModel.price forKey:allGoodid];
    
    
    int count=[[countDic objectForKey:allGoodid] intValue];
    count=count+1;
    
    [countDic setObject:[NSString stringWithFormat:@"%d",count] forKey:allGoodid];
    
    
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




#pragma mark - 美食分类列表

- (void)getCategory{
    
    [self.cateArray removeAllObjects];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //传入的参数
    
    
    //NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"pageNo",@"100", @"pageSize", nil];
    
    __weak typeof(self) weakSelf = self;
   
    [manager GET:@"http://101.200.211.9/yunsong/phone/foodCategory_list.action" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *codes=[responseObject objectForKey:@"code"];
        
        
        if([codes integerValue] == 1){
            
            NSString *dataNs=[responseObject objectForKey:@"data"];
            //转化
            NSData *data=[dataNs dataUsingEncoding:NSUTF8StringEncoding];
            //解析数据
            NSArray *infoArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // NSArray *infoArray=[dicts objectForKey:@"data"];
            
            for (id all in infoArray) {
                YunSModel *model=[[YunSModel alloc]init];
                [model setValuesForKeysWithDictionary:all];
                [weakSelf.cateArray addObject:model];
                
            }
            
            cateid=@"";
            
            
            [self getCategoryGood:@"" pageNu:@"1" orderBy:@"" orderType:@""];
            
        }else{
            
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.leftTableView reloadData];
        });

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
    

    
}


#pragma mark - 获取美食列表

- (void)getCategoryGood:(NSString *)categoryid pageNu:(NSString *)pageNu orderBy:(NSString *)orderBy orderType:(NSString *)orderType{
    
    
        [self.goodArray removeAllObjects];

    
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //传入的参数
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:pageNu, @"pageNo",@"10",@"pageSize",categoryid,@"categoryId",orderBy,@"orderBy",orderType,@"orderType", nil];
    
    __weak typeof(self) weakSelf = self;

    [manager GET:@"http://101.200.211.9/yunsong/phone/food_list.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSString *codes=[responseObject objectForKey:@"code"];
        
        
        if([codes integerValue] == 1){
            
            NSString *dataNs=[responseObject objectForKey:@"data"];
            //转化
            NSData *data=[dataNs dataUsingEncoding:NSUTF8StringEncoding];
            //解析数据
            NSDictionary *dicts=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *infoArray=[dicts objectForKey:@"data"];
            
            for (id all in infoArray) {
                YunSModel *model=[[YunSModel alloc]init];
                [model setValuesForKeysWithDictionary:all];
                [weakSelf.goodArray addObject:model];
                
            }
            
            
        }else{
            
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.myTableView reloadData];
        });

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
   
    
}



- (void)upload:(UIImage *)image{
    
//    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *fileP=[NSString stringWithFormat:@"%@.pdf",self.model.name];
//    
//    NSString *path = [docs[0] stringByAppendingPathComponent:fileP];
//    
//    NSURL *url = [NSURL URLWithString:urlD];//下载地址
//    
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];//path必须是真实的路径
//    
//    [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
   
    
}


//#pragma mark - 配送费
//
//-(void)getfree{
//    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    //传入的参数
//    
//    __weak typeof(self) weakSelf = self;
//    
//    //发送请求
//    [manager POST:FoodFoodConfigInfo parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        NSString *codes=[responseObject objectForKey:@"code"];
//        
//        if([codes integerValue] == 1){
//            
//            NSString *dataNs=[responseObject objectForKey:@"data"];
//            
//            //转化
//            NSData *data=[dataNs dataUsingEncoding:NSUTF8StringEncoding];
//            
//            //解析数据
//            weakSelf.dictes=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            
//            float pei=[[weakSelf.dictes objectForKey:@"send_price"] floatValue];
//            
//            if(pei-totl>0){
//                
//                NSString *fg=[NSString stringWithFormat:@"还差%.2f配送",pei-totl];
//                
//                bottomCell.peiLabel.text=fg;
//                
//            }else{
//                bottomCell.peiLabel.text=@"选好了";
//                
//            }
//            
//            
//        } else {
//            
//            CustomToastView *toast=[[CustomToastView alloc]initWithView:self.view text:[responseObject objectForKey:@"desc"] duration:KDuration];
//            [toast show];
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

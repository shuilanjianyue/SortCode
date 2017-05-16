//
//  ShopCavController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/4/5.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ShopCavController.h"
#import "ShopCavCell.h"
#import "UIButton+ExteralButton.h"

@interface ShopCavController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIButton *cavButton;

@property(nonatomic,strong)UILabel *text1Label;

@end

@implementation ShopCavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"购物车动画效果";
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavHeight,SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight - 60) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.rowHeight = 50;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];
    
    
    self.cavButton = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 50, 40, 40)];
    self.cavButton.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.cavButton];
    
    
    self.text1Label = [[UILabel alloc]initWithFrame:CGRectMake(self.cavButton.right, self.cavButton.top+5, 100, 30)];
    self.text1Label.text = @"50";
    self.text1Label.backgroundColor = [UIColor whiteColor];
    self.text1Label.font = [UIFont systemFontOfSize:14];
    self.text1Label.textColor =[UIColor blackColor];
    [self.view addSubview:self.text1Label];
    
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     static NSString *indentifer = @"ShopCavCell";
    ShopCavCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopCavCell" owner:self options:nil]lastObject];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moneyLabel.text = @"50";
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //cell.addButton.indexPath = indexPath;
    
    
    return cell;
}



- (void)addAction:(UIButton *)btn{
    
//    NSLog(@"btn.indexPath.row %d",btn.indexPath.row);
//    
//    NSLog(@"btn.indexPath.section %d",btn.indexPath.section);
    
    
    //加入购物车动画效果
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    transitionLayer.cornerRadius = 10.0;
    transitionLayer.masksToBounds=YES;
    transitionLayer.contents =@"50";
    transitionLayer.backgroundColor=[UIColor redColor].CGColor;
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:CGRectMake(70/2-20/2, 5, 20, 20) fromView:btn];//参照的视图
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    
    
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    CGPoint toPoint = CGPointMake(_cavButton.center.x, _cavButton.center.y);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(_cavButton.center.x,transitionLayer.position.y)];
    
    //关键帧 位置的变化
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion=NO;
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.7;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    
    [transitionLayer addAnimation:group forKey:@"opacity"];
    
    
    [self performSelector:@selector(addShopFinished:) withObject:transitionLayer afterDelay:0.7f];
    
}


//加入购物车 步骤2
- (void)addShopFinished:(CALayer*)transitionLayer{
    
    transitionLayer.opacity = 0.0f;
    [transitionLayer removeAllAnimations];
    
    
    
    
    
    CALayer *transitionLayer1 = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer1.opacity = 1.0;
    transitionLayer1.contents = (id)_text1Label.layer.contents;
    transitionLayer1.backgroundColor=[UIColor yellowColor].CGColor;
    transitionLayer1.frame = [[UIApplication sharedApplication].keyWindow convertRect:_text1Label.bounds fromView:_text1Label];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer1];
    [CATransaction commit];
    
    
    
    //移动
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_text1Label.frame.origin.x+50, _text1Label.frame.origin.y+30)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_text1Label.frame.origin.x+50, _text1Label.frame.origin.y)];
    
    //透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0];
    
    //旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    rotateAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 2.0f;
    group.animations = [NSArray arrayWithObjects:positionAnimation,opacityAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    
    [transitionLayer1 addAnimation:group forKey:@"opacity"];
    
    
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

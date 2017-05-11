//
//  ShouShiController.m
//  整理文
//
//  Created by dazaoqiancheng on 2017/5/4.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ShouShiController.h"

@interface ShouShiController ()<UIGestureRecognizerDelegate>


@property(nonatomic,strong)UIView *bgView;


@property(nonatomic,strong)UILabel *panLabel;

@property(nonatomic,strong)UIImageView *pinchImage;

@end

@implementation ShouShiController

- (UIView *)bgView{
    
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 50);
        _bgView.backgroundColor = [UIColor greenColor];
    }
    
    return _bgView;
    
}

- (UILabel *)panLabel{
    if (!_panLabel) {
        _panLabel = [UILabel new];
        _panLabel.userInteractionEnabled = YES;
        _panLabel.frame = CGRectMake(100, _bgView.bottom, 100, 100);
        _panLabel.backgroundColor = [UIColor blueColor];
    }
    return _panLabel;
}


- (UIImageView *)pinchImage{
    if (!_pinchImage) {
        _pinchImage = [UIImageView new];
        _pinchImage.userInteractionEnabled = YES;
        _pinchImage.frame = CGRectMake(100, _panLabel.bottom + 100, 100, 100);
        _pinchImage.image = [UIImage imageNamed:@"孙翠花.jpg"];
        
    }
    
    return _pinchImage;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text = @"手势";
    
    [self initSubView];
    
    
#pragma mark - 点击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [_bgView addGestureRecognizer:tapGesture];
  
    
#pragma mark - 长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 1;//设置长按时间
    [_bgView addGestureRecognizer:longPress];
    

    
#pragma mark - 轻扫
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];//常用于进入下一个界面
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;//上下左右 默认是向右
    [_bgView addGestureRecognizer:swipeGesture];

    
#pragma mark - 拖动平移
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_panLabel addGestureRecognizer:panGesture];
    
    
#pragma mark - 捏合手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [_pinchImage addGestureRecognizer:pinchGesture];

    
    
#pragma mark - 旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesture:)];
    [self.view addGestureRecognizer:rotationGesture];
    // Do any additional setup after loading the view.
}


-(void)initSubView{
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.panLabel];
    [self.view addSubview:self.pinchImage];
}





- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了时间");
}



- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
    }else if (longPress.state == UIGestureRecognizerStateChanged){
       NSLog(@"改变长按");
    }else if (longPress.state == UIGestureRecognizerStateEnded){
       NSLog(@"结束长按");
    }else if (longPress.state == UIGestureRecognizerStateCancelled){
        NSLog(@"取消长按");
    }else{
       NSLog(@"失败长按");
    }
}



- (void)swipeAction:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"向左轻扫");
        //
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"向右轻扫");
        //
    }
    
}




//拖移手势
- (void)panAction:(UIPanGestureRecognizer *)panGesture {
    
    //移动的坐标值
    CGPoint p1=[panGesture translationInView:self.view];//
    
    NSLog(@"p1%@",NSStringFromCGPoint(p1));
    
    //移动后的坐标
    panGesture.view.center=CGPointMake(panGesture.view.center.x+p1.x, panGesture.view.center.y+p1.y);
    
    
    //设定坐标值
    [panGesture setTranslation:CGPointZero inView:self.view];
    
    
    NSLog(@"你要把我放在哪啊");
    
    
}


//捏合手势触发方法
-(void) pinchGesture:(UIPinchGestureRecognizer *)gesture
{
    //手势改变时
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        //捏合手势中scale属性记录的缩放比例
        _pinchImage.transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
        
    }else if(gesture.state==UIGestureRecognizerStateEnded)//结束后
    {
        [UIView animateWithDuration:0.5 animations:^{
            _pinchImage.transform = CGAffineTransformIdentity;//取消一切形变
        }];
    }
}



//旋转手势触发方法
-(void)rotationGesture:(UIRotationGestureRecognizer *)gesture
{

    if (gesture.state==UIGestureRecognizerStateChanged)
    {
        _pinchImage.transform=CGAffineTransformMakeRotation(gesture.rotation);
    }
    if(gesture.state==UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:1 animations:^{
            _pinchImage.transform=CGAffineTransformIdentity;//取消形变
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





// 询问一个手势接收者是否应该开始解释执行一个触摸接收事件
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //    CGPoint currentPoint = [gestureRecognizer locationInView:self.view];
    //    if (CGRectContainsPoint(CGRectMake(0, 0, 100, 100), currentPoint) ) {
    //        return YES;
    //    }
    //
    //    return NO;
    
    return YES;
}

// 询问delegate，两个手势是否同时接收消息，返回YES同事接收。返回NO，不同是接收（如果另外一个手势返回YES，则并不能保证不同时接收消息）the default implementation returns NO。
// 这个函数一般在一个手势接收者要阻止另外一个手势接收自己的消息的时候调用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}


// 询问delegate是否允许手势接收者接收一个touch对象
// 返回YES，则允许对这个touch对象审核，NO，则不允许。
// 这个方法在touchesBegan:withEvent:之前调用，为一个新的touch对象进行调用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
        
        if ([touch.view isKindOfClass:[UIButton class]]) {
            return NO;
        }
        return YES;
    

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

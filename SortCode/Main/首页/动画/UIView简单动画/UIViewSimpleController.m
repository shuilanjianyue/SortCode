//
//  UIViewSimpleController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/29.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "UIViewSimpleController.h"

@interface UIViewSimpleController ()
{
    UIButton *headbtn;
}
@end

@implementation UIViewSimpleController

//枚举类型，从1开始
 //枚举类型有一个很大的作用，就是用来代替程序中的魔法数字
 typedef enum
 {
        ktopbtntag=1,
        kdownbtntag,
        krightbtntag,
        kleftbtntag
}btntag;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text= @"动画";
    
    headbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置对象的各项属性

 //(1)位置等通用属性设置
    headbtn.frame=CGRectMake(100, 100, 100, 100);

   //(2)设置普通状态下按钮的属性
    [headbtn setBackgroundImage:[UIImage imageNamed:@"孙翠花4.jpg"] forState:UIControlStateNormal];
    [headbtn setTitle:@"点我！" forState:UIControlStateNormal];
    [headbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
 
        //(3)设置高亮状态下按钮的属性
//    [headbtn setBackgroundImage:[UIImage imageNamed:@"a"] forState:UIControlStateHighlighted];
//    [headbtn setTitle:@"还行吧~" forState:UIControlStateHighlighted];
//    [headbtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
   
       //3.把对象添加到视图中展现出来
    [self.view addSubview:headbtn];
    
    
    
    
       UIButton *topbtn=[UIButton buttonWithType:UIButtonTypeCustom];
         //2.设置对象的属性
        topbtn.frame=CGRectMake(100, 250, 40, 40);
        topbtn.backgroundColor = [UIColor redColor];
        [topbtn setTag:1];
    //4.按钮的单击控制事件
        [topbtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
         //3.把控件添加到视图中
        [self.view addSubview:topbtn];
    
    
    
    
           /**================向下的按钮=====================*/
         //1.创建按钮对象
         UIButton *downbtn=[UIButton buttonWithType:UIButtonTypeCustom];
         //2.设置对象的属性
         downbtn.frame=CGRectMake(100, 350, 40, 40);
         downbtn.backgroundColor = [UIColor blueColor];
         [downbtn setTag:2];
         //3.把控件添加到视图中
       //4.按钮的单击控制事件
       [downbtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
         [self.view addSubview:downbtn];
    
    
    /**================向右的按钮=====================*/
    //1.创建按钮对象
    UIButton *rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //2.设置对象的属性
    rightbtn.frame=CGRectMake(150, 300, 40, 40);
    rightbtn.backgroundColor = [UIColor lightGrayColor];
    [rightbtn setTag:3];
    //3.把控件添加到视图中
    //4.按钮的单击控制事件
    [rightbtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightbtn];
    
    
    
          /**================向左的按钮=====================*/
         //1.创建按钮对象
         UIButton *leftbtn=[UIButton buttonWithType:UIButtonTypeCustom];
         //2.设置对象的属性
        leftbtn.frame=CGRectMake(50, 300, 40, 40);
         leftbtn.backgroundColor = [UIColor purpleColor];
         [leftbtn setTag:4];
         //3.把控件添加到视图中
        //4.按钮的单击控制事件
        [leftbtn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
         [self.view addSubview:leftbtn];
    
    
    
    
    
    
    
    
           //三、写两个缩放按钮
        /**================放大的按钮=====================*/
         //1.创建对象
         UIButton *plusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
         //2.设置属性
        plusbtn.frame=CGRectMake(75, 400, 40, 40);
         [plusbtn setBackgroundImage:[UIImage imageNamed:@"plus_normal"] forState:UIControlStateNormal];
         [plusbtn setBackgroundImage:[UIImage imageNamed:@"plus_highlighted"] forState:UIControlStateHighlighted];
         [plusbtn setTag:10];
         //3.添加到视图
         [self.view addSubview:plusbtn];
         //4.单击事件
         [plusbtn addTarget:self action:@selector(Zoom:) forControlEvents:UIControlEventTouchUpInside];
    
        /**================缩小的按钮=====================*/
         UIButton *minusbtn=[UIButton buttonWithType:UIButtonTypeCustom];
         minusbtn.frame=CGRectMake(125, 400, 40, 40);
        [minusbtn setBackgroundImage:[UIImage imageNamed:@"minus_normal"] forState:UIControlStateNormal];
         [minusbtn setBackgroundImage:[UIImage imageNamed:@"minus_highlighted"] forState:UIControlStateHighlighted];
         [minusbtn setTag:11];
         [self.view addSubview:minusbtn];
         [minusbtn addTarget:self action:@selector(Zoom:) forControlEvents:UIControlEventTouchUpInside];
    
         /**================向左旋转按钮=====================*/
         UIButton *leftrotatebtn=[UIButton buttonWithType:UIButtonTypeCustom];
         [leftrotatebtn setFrame:CGRectMake(175, 400, 40, 40)];
    leftrotatebtn.backgroundColor = [UIColor greenColor];
         [leftrotatebtn setTag:12];
         [self.view addSubview:leftrotatebtn];
         [leftrotatebtn addTarget:self action:@selector(Rotate:) forControlEvents:UIControlEventTouchUpInside];
    
         /**================向右旋转按钮=====================*/
         UIButton *rightrotatebtn=[UIButton buttonWithType:UIButtonTypeCustom];
         [rightrotatebtn setFrame:CGRectMake(225, 400, 40, 40)];
    rightrotatebtn.backgroundColor = [UIColor cyanColor];
         [rightbtn setTag:13];
         [self.view addSubview:rightrotatebtn];
         [rightrotatebtn addTarget:self action:@selector(Rotate:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//控制方向的多个按钮调用同一个方法
 -(void)Click:(UIButton *)button
 {
    
         //练习使用frame属性
         //CGRect frame=self.headImageView.frame;
    
         /**注意，这里如果控制位置的两个属性frame和center同时使用的话，会出现很好玩的效果，注意分析*/
         //练习使用center属性
         CGPoint center=headbtn.center;
         switch (button.tag) {
                     case 1:
                         center.y-=30;
                         break;
                     case 2:
                        center.y+=30;
                         break;
                     case 3:
                 
                         center.x-=50;
                 
                        break;
                    case 4:
                         center.x+=50;
                         break;
             }
      //  self.headImageView.frame=frame;
    
         //首尾式设置动画效果
         [UIView beginAnimations:nil context:nil];
         headbtn.center=center;
         //设置时间
        [UIView setAnimationDelegate:self];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [UIView setAnimationDuration:2.0];
         [UIView commitAnimations];
         NSLog(@"移动!");
    
     }




 -(void)Zoom:(UIButton *)btn
 {
        //使用bounds，以中心点位原点进行缩放
         CGRect bounds = headbtn.bounds;
         if (btn.tag) {
                 bounds.size.height+=30;
                 bounds.size.width+=30;
            }
         else
             {
                     bounds.size.height-=50;
                     bounds.size.width-=50;
                 }
    
         //设置首尾动画
         [UIView beginAnimations:nil context:nil];
         headbtn.bounds=bounds;
        [UIView setAnimationDuration:2.0];
        [UIView commitAnimations];
     }

 -(void)Rotate:(UIButton *)rotate
{
         //位移（不累加）
         //self.headImageView.transform=CGAffineTransformMakeTranslation(50, 200);
         //缩放
        //self.headImageView.transform=CGAffineTransformMakeScale(1.2, 10);
         //在原有的基础上位移（是累加的）
         //self.headImageView.transform=CGAffineTransformTranslate(self.headImageView.transform, 50, 50);
         //在原有的基础上进行缩放
         //self.headImageView.transform=CGAffineTransformScale(self.headImageView.transform, 1.5, 1.6);
    
        //在原有的基础上进行旋转
         if (rotate.tag == 12) {
                //旋转角度为1/pi，逆时针
             headbtn.transform=CGAffineTransformMakeTranslation(100, 100);
             
             }
         else
             {
                //旋转的角度为pi/2，顺时针
                 headbtn.transform=CGAffineTransformTranslate(headbtn.transform, 100, 100);
;
                }
    
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

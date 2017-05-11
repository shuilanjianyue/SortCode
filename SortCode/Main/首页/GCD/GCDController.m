//
//  GCDController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/2/7.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "GCDController.h"

@interface GCDController ()
{
    UIButton *showButton1;
    UIButton *showButton2;
    UIButton *showButton3;
    UIButton *showButton4;
    UIButton *showButton5;
    UIButton *showButton6;
    UIButton *showButton7;
    UIButton *showButton8;
}
@end

@implementation GCDController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"GCD";

    
    showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"并发＋同步" forState:UIControlStateNormal];
    [showButton1 addTarget:self action:@selector(createBingSy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton1];
    
    
    showButton2=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton1.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton2 setBackgroundColor:[UIColor magentaColor]];
    [showButton2 setTitle:@"并发＋异步" forState:UIControlStateNormal];
    [showButton2 addTarget:self action:@selector(createBingASync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton2];
    
    showButton3=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton2.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton3 setBackgroundColor:[UIColor magentaColor]];
    [showButton3 setTitle:@"全局＋同步" forState:UIControlStateNormal];
    [showButton3 addTarget:self action:@selector(gloalSync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton3];
    
    showButton4=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton3.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton4 setBackgroundColor:[UIColor magentaColor]];
    [showButton4 setTitle:@"全局＋异步" forState:UIControlStateNormal];
    [showButton4 addTarget:self action:@selector(gloalASync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton4];
    
    
    showButton5=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton4.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton5 setBackgroundColor:[UIColor magentaColor]];
    [showButton5 setTitle:@"串行＋同步" forState:UIControlStateNormal];
    [showButton5 addTarget:self action:@selector(createChuanSy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton5];

    showButton6=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton5.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton6 setBackgroundColor:[UIColor magentaColor]];
    [showButton6 setTitle:@"串行＋异步" forState:UIControlStateNormal];
    [showButton6 addTarget:self action:@selector(createChuanASync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton6];
    
    showButton7=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton6.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton7 setBackgroundColor:[UIColor magentaColor]];
    [showButton7 setTitle:@"主＋同步" forState:UIControlStateNormal];
    [showButton7 addTarget:self action:@selector(mainSync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton7];
    
    
    showButton8=[[UIButton alloc]initWithFrame:CGRectMake(20, showButton7.bottom + 10, SCREEN_WIDTH - 40, 40)];
    [showButton8 setBackgroundColor:[UIColor magentaColor]];
    [showButton8 setTitle:@"主＋异步" forState:UIControlStateNormal];
    [showButton8 addTarget:self action:@selector(mainASync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton8];
    // Do any additional setup after loading the view.
}


//并发队列＋同步任务：没有开启新的线程，任务是逐个执行的
-(void)createBingSy{
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //在队列里面添加任务
    //同步任务
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}

//并发队列＋异步任务 开启了新线程
-(void)createBingASync{
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    //在队列里面添加任务
    //异步任务
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }

    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}
//全局队列＋同步任务：没有开启新的线程，任务是逐个执行的
-(void)gloalSync{
    //获取全部队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    //同步任务
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}

//全局队列＋异步任务：开启了新线程，任务并发
-(void)gloalASync{
    //获取全部队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    //异步任务
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
        
    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}

//串行队列＋同步任务：没有开启新的线程，任务是逐个执行的
-(void)createChuanSy{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    
    //在队列里面添加任务
    //同步任务
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}


//串行队列＋异步任务 开启了新线程 任务逐个完成
-(void)createChuanASync{
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    
    //在队列里面添加任务
    //异步任务
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
        
    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}


//主队列＋同步任务 主界面卡死
-(void)mainSync{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    //同步任务
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_sync(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
}

//主队列＋异步任务 没有开启新线程 任务逐个完成
-(void)mainASync{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    //同步任务
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----1----%@",[NSThread currentThread]);
            
        }
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----2----%@",[NSThread currentThread]);
            
        }
    });
    
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"----3----%@",[NSThread currentThread]);
            
        }
    });
    
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

//
//  DGBClassifyViewController.m
//  Demo
//
//  Created by douguangbin on 16/8/4.
//  Copyright © 2016年 douguangbin. All rights reserved.
//
#import "ActivityController.h"
#import "TapButtonView.h"

@interface  ActivityController ()<TapButtonViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)TapButtonView *tapView;
@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation ActivityController

                    
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    CGRect frame = self.navBar.frame;
    frame.size.height = 100;
    self.navBar.frame = frame;
    
    self.navBar.titleLabel.text = @"活动";
    
    self.lineView.hidden = YES;
    
    
   
    NSArray *buttonArray = @[@"已报名",@"已通知",@"已入职",@"已付费",@"已关注",@"人才库"];
    
    
    _tapView = [[TapButtonView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 35)];
    _tapView.delegate = self;
    [_tapView addButton1:buttonArray index:1];
    [self.navBar addSubview:_tapView];
    
    
    self.navBar.transform = CGAffineTransformMakeTranslation(0,0);
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - _tapView.bottom - 49) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];
    
    
    self.myTableView.transform = CGAffineTransformMakeTranslation(0,0);
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifer = @"ZuoHuaffCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    
    
    cell.textLabel.text=@"活动";
    
    
    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSIndexPath *path =  [self.myTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    
    
    NSLog(@"这是第%i部分",(int)path.row);
    
    if (path.row < 4) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.navBar.titleLabel.hidden = NO;
            self.navBar.transform = CGAffineTransformIdentity;
            self.myTableView.transform = CGAffineTransformIdentity;
            
            
            
            CGRect fame = self.myTableView.frame;
            fame.size.height =SCREEN_HEIGHT - 100- 49;
            self.myTableView.frame =fame;
            
            
        }];
        
        
       
        
    }else if (path.row == 4){
        
        [UIView animateWithDuration:0.5 animations:^{
            self.navBar.titleLabel.hidden = YES;
            self.navBar.transform = CGAffineTransformMakeTranslation(0, -36);
            self.myTableView.transform = CGAffineTransformMakeTranslation(0, -36);
            
            CGRect fame = self.myTableView.frame;
            fame.size.height =SCREEN_HEIGHT - 100- 49+36;
            self.myTableView.frame =fame;
            
        }];
        
    }
    
    
    
}




@end

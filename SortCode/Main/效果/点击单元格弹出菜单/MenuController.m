//
//  MenuController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/17.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "MenuController.h"
#import "MenuCell.h"

@interface MenuController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;



@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text=@"点击单元格弹出菜单";
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.backgroundView = nil;
    self.myTableView.rowHeight=60;
    //self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];
    
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifer = @"MenuCell";
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MenuCell" owner:self options:nil]lastObject];
    }
    
    
    cell.textLabel.text=@"点击单元格弹出菜单";
    
    return cell;
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

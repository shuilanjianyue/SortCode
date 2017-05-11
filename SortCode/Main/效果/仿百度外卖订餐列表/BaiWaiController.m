//
//  BaiWaiController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/17.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "BaiWaiController.h"

@interface BaiWaiController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger index;
    
}
@property(strong,nonatomic)UITableView *leftTableView;

@property(strong,nonatomic)UITableView *rightTableView;



@end

@implementation BaiWaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    index=0;
    self.navBar.titleLabel.text = @"仿百度外卖订餐列表";
    self.leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, 80, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.leftTableView.delegate=self;
    self.leftTableView.dataSource=self;
    self.leftTableView.rowHeight=40;
    [self.view addSubview:self.leftTableView];
    
    
    
    
    self.rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(80, NavHeight, SCREEN_WIDTH-80, SCREEN_HEIGHT-64) style: UITableViewStylePlain];
    //self.rightTableView.separatorStyle=UITableViewCellStyleDefault;
    self.rightTableView.delegate=self;
    self.rightTableView.dataSource=self;
    self.rightTableView.rowHeight=40;
    [self.view addSubview:self.rightTableView];
    
    // Do any additional setup after loading the view.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.leftTableView) {
        return 1;
    }
    
    
    return 20;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==self.leftTableView) {
        return 20;
    }else{
        
        return 3;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView==self.leftTableView) {
        static NSString *identifi=@"ffffff";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifi];
        
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
            
        }
        
        if (indexPath.row==index) {
            cell.textLabel.textColor=[UIColor cyanColor];
            
        }else{
            cell.textLabel.textColor=[UIColor lightGrayColor];
        }
        
        
        cell.textLabel.text=[NSString stringWithFormat:@"left-%d",(int)indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        
        return cell;
    }else{
        
        
        static NSString *identifi=@"dddddddd";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifi];
        
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
            
        }
        
        
        cell.textLabel.text=[NSString stringWithFormat:@"right-row-%d",(int)indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        
        
        
        return cell;
        
    }
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView==self.leftTableView) {
        return 0.00001;
    }else{
        
        return 30;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (tableView==self.leftTableView) {
        return @"";
        
    }else{
        
        NSString *fff=[NSString stringWithFormat:@"right-section-%d",(int)section];
        
        return fff;
        
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.leftTableView) {
        
        index=indexPath.row;
        
        [self.leftTableView reloadData];
        
        
        //移动右边的部分
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        
        [self.rightTableView scrollToRowAtIndexPath:scrollIndexPath
                                   atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
    }else{
        
        
        
    }
    
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView==self.leftTableView) {
        
    }else{
        
        
        NSIndexPath *path =  [self.rightTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
        
        NSLog(@"这是第%i部分",(int)path.section);
        
        
        index=path.section;
        
        
        //移动左边的行
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        [self.leftTableView scrollToRowAtIndexPath:scrollIndexPath
                                  atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self.leftTableView reloadData];
        
    }
    
    
    
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

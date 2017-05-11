//
//  TaoBaoCavController.m
//  总结
//
//  Created by dazaoqiancheng on 16/4/8.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "TaoBaoCavController.h"
#import "TaoBaoCavCell.h"
#import "UIButton+ExteralButton.h"

@interface TaoBaoCavController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSArray *_rowArray;
    NSArray *_sectionArray;
    
    
}
        

@property (nonatomic,retain) UITableView* tableView;

@property(nonatomic,strong)NSMutableDictionary *sectionDic;//部分

@property(nonatomic,strong)NSMutableDictionary *rowDic;

@end

@implementation TaoBaoCavController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text=@"仿淘宝购物车";
    

    
    self.treeOpenArray=[NSMutableArray array];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.sectionDic=[NSMutableDictionary dictionary];
    self.rowDic=[NSMutableDictionary dictionary];
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=60;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    _rowArray=@[@"1",@"2",@"3"];
    
    
    
    _sectionArray=@[@"section1",@"section2",@"section3"];
    
    for (int  i=0; i<_sectionArray.count; i++) {
        
        [self.sectionDic setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
        
        
        for (int j=0; j<_rowArray.count; j++) {
            
            NSString *row=[NSString stringWithFormat:@"%d|%d",i,j];
            
            [self.rowDic setObject:@"0" forKey:row];
            
        }
    }
    
    // Do any additional setup after loading the view.
}



#pragma mark - tableview datasourece and delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _sectionArray.count;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *tempSectionString = [NSString stringWithFormat:@"%d",(int)section];
    
    if ([self.treeOpenArray containsObject:tempSectionString]) {
        
        return  _rowArray.count;
        
//        cell.tempImage.image = [UIImage imageNamed:@"suoSelectSize"];
//        cel   l.tempImage.transform = CGAffineTransformMakeRotation(M_PI);
//        cell.tempType=@"1";//张开的
        
    }else{
        
        return 0;
    }
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TaoBaoCavCell";
    
    TaoBaoCavCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
         cell = [[[NSBundle mainBundle]loadNibNamed:@"TaoBaoCavCell" owner:self options:nil]lastObject];
        
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 60-0.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
        
        
    }
    
    
    
    [cell.seleBtn addTarget:self action:@selector(rowSele:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.seleBtn.indexP=indexPath;
    
    
    NSString *secRow=[NSString stringWithFormat:@"%d|%d",(int)indexPath.section,(int)indexPath.row];
    
    
    NSString *gggg=[self.rowDic objectForKey:secRow];
    
    
    if ([gggg intValue]==1) {
        
        [cell.seleBtn setImage:[UIImage imageNamed:@"shopCavSelected"] forState:UIControlStateNormal];
        
    }else{
       
        [cell.seleBtn setImage:[UIImage imageNamed:@"shopCavUnSelected"] forState:UIControlStateNormal];

        
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentLabel.text = _rowArray[indexPath.row];
    
    return cell;
}


#pragma mark - 选择行
- (void)rowSele:(UIButton *)btn{
    
    NSString *secRow=[NSString stringWithFormat:@"%d|%d",(int)btn.indexP.section,(int)btn.indexP.row];
    
    NSString *hhhh=[self.rowDic objectForKey:secRow];
    
    
    if ([hhhh intValue]==1) {
        
        [self.rowDic setObject:@"0" forKey:secRow];
        [self.sectionDic setObject:@"0" forKey:[NSString stringWithFormat:@"%d",(int)btn.indexP.section]];
        
        
    }else{
        
        [self.rowDic setObject:@"1" forKey:secRow];
        
        NSMutableArray *tempArray=[NSMutableArray array];
        
        for (int i=0; i<_rowArray.count; i++) {
            
            NSString *rrr=[NSString stringWithFormat:@"%d|%d",(int)btn.indexP.section,i];
            
            NSString *bbbbbb=[self.rowDic objectForKey:rrr];
            
            [tempArray addObject:bbbbbb];
            
        }
        
        //判断所有的行是否全部选择了
        if([tempArray containsObject:@"0"]){
            
        }else{
            
            [self.sectionDic setObject:@"1" forKey:[NSString stringWithFormat:@"%d",(int)btn.indexP.section]];
            
        }
    }
    
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:btn.indexP.section];
    
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    NSString *ddd=[NSString stringWithFormat:@"section---%d",section+1];
//    
//    return ddd;
//    
//}
 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    //左边
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    
    [button addTarget:self action:@selector(sectionSele:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=section;
    
    NSString *fff=[self.sectionDic objectForKey:[NSString stringWithFormat:@"%d",(int)section]];
    
    if ([fff intValue]==0) {
        [button setImage:[UIImage imageNamed:@"shopCavUnSelected"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"shopCavSelected"] forState:UIControlStateNormal];
        
    }
    
    [view addSubview:button];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(button.right+10, 0, SCREEN_WIDTH-100, 50)];
    label.text=_sectionArray[section];
    [view addSubview:label];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor=[UIColor orangeColor];
    [view addSubview:lineView];
    
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 10, 30, 30)];
    imageView.userInteractionEnabled=YES;
    
    
    NSString *tempSectionString = [NSString stringWithFormat:@"%d",(int)section];
    
    
    //下啦
    if ([self.treeOpenArray containsObject:tempSectionString]) {
        
        imageView.image = [UIImage imageNamed:@"suoSelectSize"];
        imageView.transform = CGAffineTransformMakeRotation(M_PI);
        //cell.tempType=@"1";//张开的
        
    }else{
        
        imageView.image = [UIImage imageNamed:@"suoSelectSize"];
        //cell.tempType=@"2";//关闭的
    }
    
    
    
    UIButton *imBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 10, 40, 30)];
    [imBtn addTarget:self action:@selector(imBtn:) forControlEvents:UIControlEventTouchUpInside];
    imBtn.tag=section;
    [view addSubview:imageView];
    
    [view addSubview:imBtn];
    return view;
    
    
}



#pragma mark - 选择部分
- (void)sectionSele:(UIButton *)btn{
    
    
    NSString *sections=[NSString stringWithFormat:@"%d",(int)btn.tag];
    
    NSString *sectionYes=[self.sectionDic objectForKey:sections];
    
    
    //相互交换 0未选中 1选中
    if ([sectionYes intValue]==0) {
        [self.sectionDic setObject:@"1" forKey:sections];
        
        
        for (int i=0; i<_rowArray.count; i++) {
            NSString *rrr=[NSString stringWithFormat:@"%@|%d",sections,i];
            
            [self.rowDic setObject:@"1" forKey:rrr];
            
        }
        
        
    }else{
        
        [self.sectionDic setObject:@"0" forKey:sections];
        
        
        for (int i=0; i<_rowArray.count; i++) {
            NSString *rrr=[NSString stringWithFormat:@"%@|%d",sections,i];
            
            [self.rowDic setObject:@"0" forKey:rrr];
            
        }
        
    }
    
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:btn.tag];
    
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    
}


#pragma mark - 选择下啦箭头
- (void)imBtn:(UIButton *)bnt{
    
    self.treeOpenString = [NSString stringWithFormat:@"%d",(int)bnt.tag];
    
    if ([self.treeOpenArray containsObject:self.treeOpenString]) {
        [self.treeOpenArray removeObject:self.treeOpenString];
    }else{
        [self.treeOpenArray addObject:self.treeOpenString];
    }
    
    
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:bnt.tag];
    
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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

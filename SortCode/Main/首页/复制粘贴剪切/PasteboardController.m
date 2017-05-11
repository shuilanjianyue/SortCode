//
//  PasteboardController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/6.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "PasteboardController.h"
#import "PasteboardTableViewCell.h"
@interface PasteboardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, getter=isMenuVisible) BOOL menuVisible;
@property (nonatomic, strong   )  UITableView *myTableView;

@end

@implementation PasteboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"复制粘贴剪切";
    
    
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
    
    static NSString *indentifer = @"PasteboardTableViewCell";
    
    PasteboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PasteboardTableViewCell" owner:self options:nil]lastObject];
    }
    
    
    cell.textLabel.text=@"点击单元格弹出菜单";
    
     
    return cell;
}


         
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self isMenuVisible]){
        return;
    }
    
    [[[self myTableView] cellForRowAtIndexPath:indexPath] setSelected:YES  animated:YES];
}



//显示菜单
- (void)showMenu:(id)cell {
    if ([cell isHighlighted]) {
        [cell becomeFirstResponder];
        UIMenuController * menu = [UIMenuController sharedMenuController];
        [menu setTargetRect: [cell frame] inView: [self view]];
        [menu setMenuVisible: YES animated: YES];
    }   
}


//复制
- (void)readFromPasteboard:(id)sender {
    [self setTitle:[NSString stringWithFormat:@"Pasteboard = %@",[[UIPasteboard generalPasteboard] string]]];
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

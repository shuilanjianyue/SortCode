//
//  SetController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/27.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "SetController.h"
#import "SetCell.h"
@interface SetController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation SetController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"设置";
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff,0x000000,0xffffff);
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavHeight) style:UITableViewStylePlain];
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifer = @"SetCell";
    
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SetCell" owner:self options:nil]lastObject];
    }
    
    if(indexPath.row == 0){
        cell.nightButton.hidden = NO;
        [cell.nightButton addTarget:self action:@selector(nightAction) forControlEvents:UIControlEventTouchUpInside];
        cell.nameLabel.text = @"夜间模式";
        
    }else{
        cell.nightButton.hidden = YES;
        
    }
   
    cell.dk_backgroundColorPicker =DKColorPickerWithRGB(0xffffff,0x000000,0xffffff);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
}



- (void)nightAction{
    
    
    if ([self.dk_manager.themeVersion isEqualToString:@"NIGHT"]) {
        
        self.dk_manager.themeVersion = DKThemeVersionNormal;
    }else{
        
        self.dk_manager.themeVersion = DKThemeVersionNight;
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

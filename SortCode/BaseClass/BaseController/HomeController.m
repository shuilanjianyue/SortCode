//
//  DGBFoundShopsTableViewController.m
//  Demo
//
//  Created by douguangbin on 16/8/4.
//  Copyright © 2016年 douguangbin. All rights reserved.
//

#import "HomeController.h"
#import "AddressController.h"
#import "ShareController.h"
#import "DeleTableController.h"
#import "WebJsController.h"
#import "WebBridgeController.h"
#import "LanYaViewController.h"
#import "BeaconController.h"
#import "PasteboardController.h"
#import "ConnectionController.h"
#import "SessionController.h"
#import "LaunchController.h"
#import "GCDController.h"
#import "UIViewSimpleController.h"
#import "CATransitionController.h"
#import "ShouShiController.h"
#import "FMDBController.h"
#import "NSTimersController.h"


@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation HomeController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.dataArray = @[@"省市区",@"蓝牙开发",@"微定位服务iBeacon技术",@"复制粘贴剪切",@"淘宝购物车动画",@"动画",@"CATransition",@"手势",@"数据库",@"NSTimer"];
    
    self.navBar.titleLabel.text = @"首页";
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - 49) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"homeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        AddressController *add = [[AddressController alloc]init];
        [self.navigationController pushViewController:add animated:YES];
        
    }else if (indexPath.row == 1){
        LanYaViewController *lanya = [[LanYaViewController alloc]init];
        
        [self.navigationController pushViewController:lanya animated:YES];
        
    }else if (indexPath.row == 2){
        BeaconController *bea = [[BeaconController alloc]init];
        [self.navigationController pushViewController:bea animated:YES];
        
        
    }else if (indexPath.row == 3){
        PasteboardController *past = [[PasteboardController alloc]init];
        [self.navigationController pushViewController:past animated:YES];
    }else if (indexPath.row == 4){
        LaunchController *qq = [[LaunchController alloc]init];
        [self.navigationController pushViewController:qq animated:YES];
        
    }else if (indexPath.row == 5){
        UIViewSimpleController *sim = [[UIViewSimpleController alloc]init];
        
        [self pushNewViewController:sim];
        
        
        
    }else if (indexPath.row == 6){
        
        CATransitionController *ca = [[CATransitionController alloc]init];
        [self pushNewViewController:ca];
        
        
        
    }else if (indexPath.row == 7){
        ShouShiController *shou = [[ShouShiController alloc]init];
        [self pushNewViewController:shou];
        
        
    }else if (indexPath.row == 8){
        
        FMDBController *fmdb = [[FMDBController alloc]init];
        [self pushNewViewController:fmdb];
        
    }else if (indexPath.row == 9){
        NSTimersController *time = [[NSTimersController alloc]init];
        [self pushNewViewController:time];
        
        
    }else if (indexPath.row == 10){
        
        
    }else if (indexPath.row == 11){
        
        
    }else if (indexPath.row == 12){
       
        
    }else if (indexPath.row == 13){
        
        
    }else if (indexPath.row == 14){
        
       
        
        
    }else if(indexPath.row == 15){
       
        
        
    }else if (indexPath.row == 16){
        
       
        
        
    }else if (indexPath.row == 17){
        
        
    }else if (indexPath.row == 18){
        
        
        
        
    }else if (indexPath.row == 19){
      
        
        
    }else if (indexPath.row == 20){
       
        
        
    }else if (indexPath.row == 21){
       
        
    }else if (indexPath.row == 22){
        
        
    }else if (indexPath.row == 23){
       
        
    }else if (indexPath.row == 24){
        
        
    }
}

@end

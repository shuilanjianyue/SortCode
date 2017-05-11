//
//  DGBExperienceTableViewController.m
//  Demo
//
//  Created by douguangbin on 16/8/4.
//  Copyright © 2016年 douguangbin. All rights reserved.
//

#import "XiaoGuoController.h"
#import "SaoSaoController.h"
#import "HuaDongController.h"
#import "PhotosController.h"
#import "MBProgressController.h"
#import "TaoBaoCavController.h"
#import "PuBuLiuController.h"
#import "YaoYiYaoController.h"
#import "CustFieldController.h"
#import "ToastAndSheetController.h"
#import "JTKeyboardController.h"
#import "MenuController.h"
#import "QiNiuController.h"
#import "TextViewController.h"
#import "AlertLoginController.h"
#import "CaptController.h"
#import "BaiWaiController.h"
#import "WPLabelController.h"
#import "ShareController.h"
#import "ChaiJianController.h"
#import "AplyPasswordController.h"
#import "AddressListController.h"
#import "GHCalendarController.h"
#import "TimePickerController.h"
#import "ZuoHuaController.h"
#import "AlertViewsController.h"
#import "CustomAlertController.h"
#import "CustCameraController.h"
#import "JKLockController.h"
#import "VideoController.h"
#import "ShopDetailController.h"
#import "QRCodeController.h"
#import "AFSharkerController.h"
#import "CustPressController.h"
#import "CommentController.h"
#import "ExchangeController.h"
#import "ShopCavController.h"
#import "UPAndDownController.h"


@interface XiaoGuoController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)UITableView *myTableView;


@end


@implementation XiaoGuoController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"效果展示";
    
    
    
    self.dataArray = @[@"1、二维码扫描",@"2、购物详情页",@"3、仿淘宝购物车",@"4、界面之间的滑动1",@"5、获取相簿中的所有图片",@"6、MBProgressHUD",@"7、瀑布流",@"8、摇一摇",@"9、自定义UITextField的Placeholder颜色",@"10、CustomToastView和LCActionSheet",@"11、自定义键盘",@"12、点击单元格弹出菜单",@"13、七牛存储",@"14、自定义TextView",@"15、UIAlertController登录",@"16、校验码",@"17、仿百度外卖订餐列表",@"18、自定义Label的位置",@"19、分享",@"20、图片的裁剪",@"21、支付宝支付密码",@"22、通讯录",@"23、日历",@"24、时间选择器",@"25、左划单元格",@"26、UIAlert修改字体颜色",@"27、自定义UIAlert",@"28、AVFoundation自定义相机",@"29、手势密码锁",@"30、录像",@"31、生成二维码",@"32、震动动画效果",@"33、进度条",@"34、上下左右滑动（未完成）",@"35、滑动评价",@"36、交换界面",@"37、购物车动画效果"];
    
    
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
        SaoSaoController *sao = [[SaoSaoController alloc]init];
        
        [self.navigationController pushViewController:sao animated:YES];
        
        
    }else if (indexPath.row == 1){
        ShopDetailController *shop = [[ShopDetailController alloc]init];
        
        [self.navigationController pushViewController:shop animated:YES];
        
    }else if (indexPath.row == 2){
        TaoBaoCavController *taobao = [[TaoBaoCavController alloc]init];
        [self.navigationController pushViewController:taobao animated:YES];
        
    }else if (indexPath.row == 3){
        HuaDongController *huadong = [[HuaDongController alloc]init];
        [self.navigationController pushViewController:huadong animated:YES];
        
    }else if (indexPath.row == 4){
        
        PhotosController *photo = [[PhotosController alloc]init];
        [self.navigationController pushViewController:photo animated:YES];
        
    }else if (indexPath.row == 5){
        
        MBProgressController *progress = [[MBProgressController alloc]init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 6){
        PuBuLiuController *pubu = [[PuBuLiuController alloc]init];
        [self.navigationController pushViewController:pubu animated:YES];
        
    }else if (indexPath.row == 7){
        YaoYiYaoController *yao = [[YaoYiYaoController alloc]init];
        [self.navigationController pushViewController:yao animated:YES];
        
        
    }else if (indexPath.row == 8){
        CustFieldController *field = [[CustFieldController alloc]init];
        
        [self.navigationController pushViewController:field animated:YES];
        
    }else if (indexPath.row == 9){
        ToastAndSheetController *toast = [[ToastAndSheetController alloc]init];
        [self.navigationController pushViewController:toast animated:YES];
        
    }else if (indexPath.row == 10){
        JTKeyboardController *keyboard = [[JTKeyboardController alloc]init];
        [self.navigationController pushViewController:keyboard animated:YES];
        
        
    }else if (indexPath.row == 11){
        MenuController *menu = [[MenuController alloc]init];
        [self.navigationController pushViewController:menu animated:YES];
        
    }else if (indexPath.row == 12){
        QiNiuController *qiniu = [[QiNiuController alloc]init];
        [self.navigationController pushViewController:qiniu animated:YES];
    }else if (indexPath.row == 13){
       
        TextViewController *text = [[TextViewController alloc]init];
        [self.navigationController pushViewController:text animated:YES];
        
    }else if (indexPath.row == 14){
        AlertLoginController *alert = [[AlertLoginController alloc]init];
        [self.navigationController pushViewController:alert animated:YES];
        
    }else if (indexPath.row == 15){
        CaptController *cap = [[CaptController alloc]init];
        [self.navigationController pushViewController:cap animated:YES];
    }else if (indexPath.row == 16){
        BaiWaiController *baidu = [[BaiWaiController alloc]init];
        [self.navigationController pushViewController:baidu animated:YES];
        
    }else if (indexPath.row == 17){
        WPLabelController *wpLabel = [[WPLabelController alloc]init];
        [self.navigationController pushViewController:wpLabel animated:YES];
        
    }else if (indexPath.row == 18){
        ShareController *share = [[ShareController alloc]init];
        [self.navigationController pushViewController:share animated:YES];
        
    }else if (indexPath.row == 19){
        ChaiJianController *chai = [[ChaiJianController alloc]init];
        [self.navigationController pushViewController:chai animated:YES];
        
    }else if (indexPath.row == 20){
        AplyPasswordController *aply = [[AplyPasswordController alloc]init];
        [self.navigationController pushViewController:aply animated:YES];
        
    }else if (indexPath.row == 21){
        AddressListController *list = [[AddressListController alloc]init];
        [self pushNewViewController:list];
        
    }else if (indexPath.row == 22){
        GHCalendarController *calen = [[GHCalendarController alloc]init];
        [self pushNewViewController:calen];
    }else if (indexPath.row == 23){
        
        TimePickerController *time = [[TimePickerController alloc]init];
        
        [self pushNewViewController:time];
        
        
    }else if (indexPath.row == 24){
        ZuoHuaController *zuo = [[ZuoHuaController alloc]init];
        [self pushNewViewController:zuo];
        
    }else if (indexPath.row == 25){
        AlertViewsController *alerts = [[AlertViewsController alloc]init];
        [self pushNewViewController:alerts];
        
    }else if (indexPath.row == 26){
        CustomAlertController *alerts = [[CustomAlertController alloc]init];
        
        [self pushNewViewController:alerts];
 
    }else if (indexPath.row == 27){
        
        CustCameraController *camera = [[CustCameraController alloc]init];
        
        [self pushNewViewController:camera];
        
        
    }else if (indexPath.row == 28){
        
        JKLockController *lock = [[JKLockController alloc]init];
        [self pushNewViewController:lock];
        
    }else if (indexPath.row == 29){
        
        
        VideoController *video = [[VideoController alloc]init];
        [self pushNewViewController:video];
        
        
        
    }else if (indexPath.row == 30){
        
        QRCodeController *code = [[QRCodeController alloc]init];
        
        [self pushNewViewController:code];
        
    }else if (indexPath.row == 31){
        AFSharkerController *shark = [[AFSharkerController alloc]init];
        [self pushNewViewController:shark];
        
    }else if (indexPath.row == 32){
        CustPressController *prss = [[CustPressController alloc]init];
        [self pushNewViewController:prss];
        
    }else if (indexPath.row == 33){
        
        UPAndDownController *upandDown = [[UPAndDownController alloc]init];
        [self pushNewViewController:upandDown];
                           
    }else if (indexPath.row == 34){
        CommentController *comment =[[CommentController alloc]init];
        
        [self pushNewViewController:comment];
        
    }else if (indexPath.row == 35){
        ExchangeController *exchange = [[ExchangeController alloc]init];
        [self pushNewViewController:exchange];
        
    }else if (indexPath.row == 36){
        
        ShopCavController *cav = [[ShopCavController alloc]init];
        [self pushNewViewController:cav];
        
    }
}




@end

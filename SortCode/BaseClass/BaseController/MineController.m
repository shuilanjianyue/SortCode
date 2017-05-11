//
//  DGBSettingViewController.m
//  Demo
//
//  Created by douguangbin on 16/8/11.
//  Copyright © 2016年 douguangbin. All rights reserved.
//

#import "MineController.h"
#import "MineCell.h"
#import "SetController.h"

@interface MineController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat BackGroupHeight;
    CGFloat HeadImageHeight;
}

@property(nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) UIImageView *imageBG;
@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation MineController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    BackGroupHeight = 200;
    HeadImageHeight= 80;
    self.navBar.hidden = YES;
    
   self.view.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff,0x000000,0xffffff);
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];
    
    
    self.myTableView.contentInset = UIEdgeInsetsMake(BackGroupHeight, 0, 0, 0);
    
    
    
    _imageBG = [[UIImageView alloc]init];
    _imageBG.frame = CGRectMake(0, -BackGroupHeight, SCREEN_WIDTH, BackGroupHeight);
    _imageBG.userInteractionEnabled = YES;
    _imageBG.image = [UIImage imageNamed:@"BG.jpg"];
    
    [self.myTableView addSubview:_imageBG];
    
    
    
    //
    _BGView = [[UIView alloc]init];
    _BGView.backgroundColor=[UIColor clearColor];
    _BGView.frame=CGRectMake(0, -BackGroupHeight, SCREEN_WIDTH, BackGroupHeight);
    
    [self.myTableView addSubview:_BGView];
    
    
    //
    _headImageView=[[UIImageView alloc]init];
    _headImageView.image=[UIImage imageNamed:@"myheadimage.jpeg"];
    _headImageView.frame=CGRectMake((SCREEN_WIDTH-HeadImageHeight)/2, 40, HeadImageHeight, HeadImageHeight);
    _headImageView.layer.cornerRadius = HeadImageHeight/2;
    _headImageView.clipsToBounds = YES;
    
    
    
    [_BGView addSubview:_headImageView];
    
    //
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.text=@"BISON";
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.frame=CGRectMake((SCREEN_WIDTH-HeadImageHeight)/2, CGRectGetMaxY(_headImageView.frame)+5, HeadImageHeight, 20);
    
    [_BGView addSubview:_nameLabel];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *indentifer = @"MineCell";
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineCell" owner:self options:nil]lastObject];
    }

    if (indexPath.row == 0) {
        cell.setLabel.text = @"设置";
    }
    
    
    cell.dk_backgroundColorPicker =DKColorPickerWithRGB(0xffffff,0x000000,0xffffff);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        SetController *set = [[SetController alloc]init];
        
        [self pushNewViewController:set];
        
    }
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + BackGroupHeight)/2;
    
    NSLog(@"yOffset==%f",yOffset);
    
    NSLog(@"xOffset==%f",xOffset);
    
    
    if (yOffset < -BackGroupHeight) {
        
        CGRect rect = _imageBG.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = SCREEN_WIDTH + fabs(xOffset)*2;
        _imageBG.frame = rect;
        
    }else{
        
        
     
        
    }

    
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}



@end

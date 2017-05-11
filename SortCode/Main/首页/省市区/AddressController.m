//
//  AddressController.m
//  总结
//
//  Created by dazaoqiancheng on 16/4/12.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "AddressController.h"
#import "CityModel.h"
#import "FmdbManger.h"
#import "ProvinceModel.h"


@interface AddressController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView *backView;
    UIView *maskView;
    UIPickerView *pickView;
    
    
    //UIPickView
    UILabel *pickLabel;
    UIButton *pickButton;
    //List
    UILabel *listLabel;
    UIButton *listButton;
    
    NSString *provineString;//省
    NSString *cityString;//市
    NSString *areaString;//区
    
}


@property(nonatomic,strong)NSArray *provinceArray;//省份的数组
@property(nonatomic,strong)NSArray *cityArray;//城市的数组
@property(nonatomic,strong)NSArray *areaArray;//区的数组

@property(nonatomic,strong)NSMutableArray *tempA;

@end

@implementation AddressController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   self.navBar.titleLabel.text = @"省市区";
    
    
    pickLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, NavHeight + 30, SCREEN_WIDTH-20, 40)];
    pickLabel.backgroundColor=[UIColor magentaColor];
    pickLabel.userInteractionEnabled=YES;
    pickLabel.textAlignment=NSTextAlignmentCenter;
    pickLabel.font=[UIFont systemFontOfSize:14];
    pickLabel.text=@"省市区";
    [self.view addSubview:pickLabel];
    
    
    pickButton=[[UIButton alloc]initWithFrame:CGRectMake(0, pickLabel.top, SCREEN_WIDTH-20, 40)];
    [pickButton addTarget:self action:@selector(pickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pickButton];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark - UIPickView
- (void)pickBtn{
    
    [self initPick];
    
}



#pragma mark - 列表

- (void)listBtn{
    
   
    
    
}

- (void)proCity:(NSNotification *)noti{
    
    listLabel.text=noti.object;
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


#pragma mark - 自定义UIPickView
- (void)initPick{
    
    
    self.provinceArray = [[FmdbManger alloc] privinceArray];
    
    ProvinceModel *proModel=[[ProvinceModel alloc]init];

    
    if (self.provinceArray.count>0) {
        proModel=[self.provinceArray objectAtIndex:0];
        provineString=proModel.areaname;
        
        NSLog(@"%@",provineString);
    }
    
    
    
    self.cityArray = [[FmdbManger alloc] cityArray:proModel.areano];
    
    ProvinceModel *cityModel=[[ProvinceModel alloc]init];
    
    if (self.cityArray.count>0) {
        cityModel=[self.cityArray objectAtIndex:0];
        cityString=cityModel.areaname;
        
        NSLog(@"cityString%@",cityString);
    }
    
    
    
    self.areaArray = [[FmdbManger alloc] aeraArray:cityModel.areano];
    
    if (self.areaArray.count>0) {
        ProvinceModel *areaModel=[self.areaArray objectAtIndex:0];
        
        areaString=areaModel.areaname;
        NSLog(@"areaString%@",areaString);
    }

    
    if (backView==nil) {
        
    }else{
        
        return  ;
        
    }
    
    backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    backView.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    [self.view addSubview:backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [backView addGestureRecognizer:tap];
    

    maskView=[[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT , SCREEN_WIDTH,176+41)];
    maskView.backgroundColor=[UIColor whiteColor];
    [backView addSubview:maskView];
    
    
    UIButton *cancellButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancellButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancellButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancellButton.frame=CGRectMake(0, 0.5, SCREEN_WIDTH/2, 40);
    [cancellButton addTarget:self action:@selector(cancell) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:cancellButton];
    
    
    UIButton *sureButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    sureButton.frame=CGRectMake(SCREEN_WIDTH/2, 0.5, SCREEN_WIDTH/2, 40);
    [sureButton addTarget:self action:@selector(surePick) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:sureButton];
    
    UIView  *topLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 40.5, SCREEN_WIDTH, 0.5)];
    topLineView.backgroundColor=[UIColor lightGrayColor];
    [maskView addSubview:topLineView];
    
    UIView  *bottomLineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    bottomLineView.backgroundColor=[UIColor lightGrayColor];
    [maskView addSubview:bottomLineView];
    
    
    pickView= [[UIPickerView alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, 176)];
    pickView.delegate = self;
    pickView.dataSource = self;
    pickView.showsSelectionIndicator = YES;
    [maskView addSubview:pickView];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        CGRect frame = maskView.frame;
        frame.origin.y = SCREEN_HEIGHT-176-41;
        maskView.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


#pragma mark -取消
- (void)cancell{
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        CGRect frame = maskView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        maskView.frame = frame;
        
    } completion:^(BOOL finished) {
       
        while (backView.subviews.count) {
            UIView* child = backView.subviews.lastObject;
            [child removeFromSuperview];
        }
        
        
        [backView removeFromSuperview];
        
        backView=nil;
        
    }];
    
    
    
    
    
}


#pragma mark -确定
- (void)surePick{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        CGRect frame = maskView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        maskView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        while (backView.subviews.count) {
            UIView* child = backView.subviews.lastObject;
            [child removeFromSuperview];
        }
        
        
        [backView removeFromSuperview];
        
        backView=nil;
        
    }];
    
    
    pickLabel.text=[NSString stringWithFormat:@"%@%@%@",provineString,cityString,areaString];

    
}


- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:backView];//获取点击位置
    
    UIView *tapView = tap.view;//获取点击的视图
    
    NSLog(@"%d",(int)tapView.tag);
    
    
    if (point.y<=SCREEN_HEIGHT-176-41) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            
            CGRect frame = maskView.frame;
            frame.origin.y = SCREEN_HEIGHT;
            maskView.frame = frame;
            
        } completion:^(BOOL finished) {
            
            while (backView.subviews.count) {
                UIView* child = backView.subviews.lastObject;
                [child removeFromSuperview];
            }
            
            
            [backView removeFromSuperview];
            
            backView=nil;
            
        }];

        
    }else{
        
        
    }
    
}

#pragma mark - UIPickerView delegate
//返回有列数 Component列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
    
}

//返回每一列中的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component==0) {
        return self.provinceArray.count;
    }else if(component==1){
        return self.cityArray.count;
    }else{
        return self.areaArray.count;
        
    }
}



////返回每个item中的title  实际上返回的就是一个label
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    if (component==0) {
        if (self.provinceArray.count>0) {
            ProvinceModel *proModel=[self.provinceArray objectAtIndex:row];
            return proModel.areaname;

        }else{
            return @"";
            
        }
    }else if (component==1){
        if (self.cityArray.count>0) {
            ProvinceModel *model=[self.cityArray objectAtIndex:row];
            return model.areaname;
            
        }else{
            return @"";
            
        }
    }else{
        
        if (self.areaArray.count>0) {
            ProvinceModel *model=[self.areaArray objectAtIndex:row];
            return model.areaname;
            
        }else{
            return @"";
            
        }
        
    }
    
}


//#pragma mark - 设置列宽
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    if(component==2)
//    {
//        //设置第3列的宽度
//        return SCREEN_WIDTH-160;
//        
//    }else
//    {
//        return 80;
//    }
//}

#pragma mark - 自定义调整字体的大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textAlignment=NSTextAlignmentCenter;
        pickerLabel.textColor=[UIColor magentaColor];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
        
    }
    
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}



//选择行的事件
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    if (component==0) {
        
        if (self.provinceArray.count>0) {
            
            //省
            ProvinceModel *model=[self.provinceArray objectAtIndex:row];
            
            provineString=model.areaname;
            
            
            //市
            self.cityArray=[[FmdbManger alloc] cityArray:model.areano];
            ProvinceModel *cityModel=[self.cityArray objectAtIndex:0];
            cityString=cityModel.areaname;
            

            //区
            self.areaArray=[[FmdbManger alloc] aeraArray:cityModel.areano];
            
            if (self.areaArray.count>0) {
                ProvinceModel *areaModel=[self.areaArray objectAtIndex:0];
                areaString=areaModel.areaname;
            }
            
            
            [pickView reloadComponent:1];
            [pickView reloadComponent:2];
            
        }
    }else if (component==1){
        
        if (self.cityArray.count>0) {
            
            //市
            ProvinceModel *cityModel=[self.cityArray objectAtIndex:row];
            cityString=cityModel.areaname;
            
            // 区
            self.areaArray=[[FmdbManger alloc] cityArray:cityModel.areano];
            
            if (self.areaArray.count>0) {
                
                ProvinceModel *areaModel=[self.areaArray objectAtIndex:0];
                areaString=areaModel.areaname;
            }
            
            
            [pickView reloadComponent:2];
//            [self getSchool:model.region_id];
        }
        
    }else{
        
        if (self.areaArray.count>0) {
            //区
            ProvinceModel *aeraModel=[self.areaArray objectAtIndex:row];
            
            areaString=aeraModel.areaname;
            
        }
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

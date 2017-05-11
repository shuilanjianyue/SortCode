//
//  TimePickerController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/16.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "TimePickerController.h"

@interface TimePickerController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIPickerView * pickerView;
@property (nonatomic,strong)NSCalendar *calendar;
@property (nonatomic,strong)NSDate *startDate; //其实时间
@property (nonatomic,strong)NSDate *endDate;  //结束时间
@property (nonatomic,strong)NSDate *selectDate;
@property (nonatomic,strong)NSDateComponents *selectedDateComponets;
@end

@implementation TimePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"时间选择器";
    
    [self initData];//初始化时间戳
    [self initPickerView];//创建pickerView

    // Do any additional setup after loading the view.
}


-(void)initData{
    
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _startDate = [dateFormatter dateFromString:@"1900-01-01"];
    _endDate = [NSDate date];  //现在的时间
    _selectDate = _startDate;
    _selectedDateComponets = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_selectDate];
    
}


-(void)initPickerView{
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 200)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    switch (component) { // component是栏目index，从0开始，后面的row也一样是从0开始
        case 0: { // 第一栏为年，这里startDate和endDate为起始时间和截止时间，请自行指定
            NSDateComponents *startCpts = [_calendar components:NSCalendarUnitYear fromDate:_startDate];
            NSDateComponents *endCpts = [_calendar components:NSCalendarUnitYear fromDate:_endDate];
            return [endCpts year] - [startCpts year] + 1;
        }
        case 1: // 第二栏为月份
            return 12;
        case 2: { // 第三栏为对应月份的天数
            NSRange dayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.selectDate];
            
            return dayRange.length;
        }
        default:
            return 0;
    }
}


// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return SCREEN_WIDTH/3;
}

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


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case 0: {
            NSDateComponents *components = [self.calendar components:NSCalendarUnitYear fromDate:self.startDate];
            NSString * currentYear = [NSString stringWithFormat:@"%d年", (int)[components year] + (int)row];
            return currentYear;
            break;
        }
        case 1: { // 返回月份可以用DateFormatter，这样可以支持本地化
            NSString *currentMonth = [NSString stringWithFormat:@"%d月",(int)row + 1];
            return currentMonth;
            break;
            
        }
        case 2: {
            
            NSRange dateRange = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.selectDate];
            NSString *currentDay = [NSString stringWithFormat:@"%d日", ((int)row + 1) % (dateRange.length + 1)];
            
            return currentDay;
            break;
        }
        default:
            break;
    }
    return nil;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    switch (component) {
        case 0: {
            
            
            _selectDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"1900-01-01"]];
            NSDateComponents *indicatorComponents = [_calendar components:NSCalendarUnitYear fromDate:_startDate];
            NSInteger year = [indicatorComponents year] + row;
            NSDateComponents *targetComponents = [_calendar components:unitFlags fromDate:self.selectDate];
            [targetComponents setYear:year];
            self.selectedDateComponets = targetComponents;
            _selectDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d",(int)targetComponents.year,(int)_selectedDateComponets.month,(int)_selectedDateComponets.day]];
            [pickerView selectRow:0 inComponent:1 animated:YES];//刷新
            [pickerView selectRow:0 inComponent:2 animated:YES];//刷新
            
            break;
        }
        case 1: {
            _selectDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-01-01",(int)_selectedDateComponets.year]];
            NSDateComponents *targetComponents = [self.calendar components:unitFlags fromDate:self.selectDate];
            [targetComponents setMonth:row + 1];
            self.selectedDateComponets = targetComponents;
            _selectDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d",(int)_selectedDateComponets.year,(int)targetComponents.month,(int)_selectedDateComponets.day]];
            [pickerView reloadComponent:2];//移除
            [pickerView selectRow:0 inComponent:2 animated:YES];//刷新
            
            break;
        }
        case 2: {
            
            NSDateComponents *targetComponents = [self.calendar components:unitFlags fromDate:self.selectDate];
            [targetComponents setDay:row + 1];
            self.selectedDateComponets = targetComponents;
            _selectDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d",(int)_selectedDateComponets.year,(int)targetComponents.month,(int)_selectedDateComponets.day]];
            break;
        }
        default:
            break;
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

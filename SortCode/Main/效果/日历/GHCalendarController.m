//
//  GHCalendarController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/10.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "GHCalendarController.h"

@interface GHCalendarController ()
@property(nonatomic,strong)UIButton *lastButton;

@property(nonatomic,strong)UIButton *nextButton;

@property(nonatomic,strong)UILabel *yearLabel;

@property(nonatomic,strong)UIView *caView;

@property(nonatomic,strong)NSDate *currentDate;//当前选择的日期


@end



@implementation GHCalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"日历";
    
    // weekday
    NSArray *array = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    UIView *weekBg = [[UIView alloc]init];
    weekBg.frame = CGRectMake(0, NavHeight, SCREEN_WIDTH, 50);
    [self.view addSubview:weekBg];
    
    
    for (int i = 0; i < array.count; i ++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor redColor];
        label.frame = CGRectMake((SCREEN_WIDTH/7.0) * i, 0, SCREEN_WIDTH/7.0, 50);
        label.textAlignment = NSTextAlignmentCenter;
        [weekBg addSubview:label];
    }
    
    
    NSDate *date = [NSDate date];
    
    self.currentDate = date;
    
    
    
    
    [self rili:self.currentDate];
    
    _lastButton = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 100, 50, 25)];
    _lastButton.backgroundColor = [UIColor magentaColor];
    [_lastButton setTitle:@"上" forState:UIControlStateNormal];
    [_lastButton addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_lastButton];
    
    
    
    _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(_lastButton.right , SCREEN_HEIGHT - 100, 150, 25)];
    _yearLabel.text = [NSString stringWithFormat:@"%d年%d月",[self year:self.currentDate],[self month:self.currentDate]];
    _yearLabel.font = [UIFont systemFontOfSize:14];
    _yearLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_yearLabel];
    
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(_yearLabel.right, SCREEN_HEIGHT - 100, 50, 25)];
    _nextButton.backgroundColor = [UIColor magentaColor];
    [_nextButton setTitle:@"下" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    // Do any additional setup after loading the view.
}


- (void)rili:(NSDate *)date{
    
    
    _caView = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight + 50, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - 50-100)];
    [self.view addSubview:_caView];
    
    
    float itemW =  SCREEN_WIDTH/7.0;
    float itemH = 50;
    
    // 1.分析这个月的第一天是第一周的星期几
    NSInteger firstWeekday = [self firstWeekdayInThisMotnth:date];
    
    // 2.分析这个月有多少天
    NSInteger dayInThisMonth = [self totaldaysInMonth:date];
    
    
    for (int i = 0; i < 42; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.caView addSubview:button];
        
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH ;
        
        button.frame = CGRectMake(x, y, itemW, itemH);
        
        NSInteger day = 0;
        
        if (i < firstWeekday) {
                     //   day = dayInLastMonth - firstWeekday + i + 1;
            continue;
            
        }else if (i > firstWeekday + dayInThisMonth - 1){
                     //   day = i + 1 - firstWeekday - dayInThisMonth;
            continue;
        }else{
            
            day = i - firstWeekday + 1;
        }
        
        [button setTitle:[NSString stringWithFormat:@"%d",(int)day] forState:UIControlStateNormal];
        
    }
}



- (void)lastAction{
    [self.caView removeAllSubviews];
    [self.caView removeFromSuperview];
    self.caView = nil;
    
    self.currentDate = [self lastMonth:self.currentDate];
    
    [self rili:self.currentDate];
    
     _yearLabel.text = [NSString stringWithFormat:@"%d年%d月",[self year:self.currentDate],[self month:self.currentDate]];
    
}


- (void)nextAction{
    [self.caView removeAllSubviews];
    [self.caView removeFromSuperview];
    self.caView = nil ;
    
    
    self.currentDate = [self nextMonth:self.currentDate];
    
    [self rili:self.currentDate];
    
    _yearLabel.text = [NSString stringWithFormat:@"%d年%d月",[self year:self.currentDate],[self month:self.currentDate]];
    
}


#pragma mark - ------------------------------
// 1.分析这个月的第一天是第一周的星期几
- (NSInteger)firstWeekdayInThisMotnth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar]; // 取得当前用户的逻辑日历(logical calendar)
    
    [calendar setFirstWeekday:1]; //  设定每周的第一天从星期几开始，比如:. 如需设定从星期日开始，则value传入1 ，如需设定从星期一开始，则value传入2 ，以此类推
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comp setDay:1]; // 设置为这个月的第一天
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate]; // 这个月第一天在当前日历的顺序
    // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的顺序
    return firstWeekday - 1;
}

// 2.分析这个月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date]; // 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围
    
    return daysInOfMonth.length;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// 日历的上一个月
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = -1;
    NSDate *lastDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:date options:0];
    return lastDate;
}

// 日历的上一个月
- (NSDate *)nextMonth:(NSDate *)date{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.month = 1;
    NSDate *nextDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:date options:0];
    return nextDate;
}

// 获取日历的年份
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

// 获取日历的月份
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}


// 获取日历的为第几天
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
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

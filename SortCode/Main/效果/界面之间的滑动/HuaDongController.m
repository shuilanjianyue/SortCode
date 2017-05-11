//
//  HuaDongController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/1.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "HuaDongController.h"
#import "SlideSwitchView.h"
#import "HuaDong1Controller.h"
#import "HuaDong2Controller.h"
#import "HuaDong3Controller.h"
#import "HuaDong4Controller.h"

NSString *const Notification_ChangeMainDisplay = @"Notification_ChangeMainDisplay";

@interface HuaDongController ()<SlideSwitchViewDelegate>

//显示的内容view
@property (nonatomic, strong) HuaDong1Controller *sessionView;
@property (nonatomic, strong) HuaDong2Controller *contactView;
@property (nonatomic, strong) HuaDong3Controller *groupListView;
@property (nonatomic, strong) HuaDong4Controller *discussGroupList;

@end

@implementation HuaDongController{
    SlideSwitchView *_slideSwitchView;
    BOOL notFirst;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"滑动1";
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMainDisplaySubview:) name:Notification_ChangeMainDisplay object:nil];
    
    //滑动效果的添加
    _slideSwitchView = [[SlideSwitchView alloc] initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight)];
    [self.view addSubview:_slideSwitchView];
    _slideSwitchView.slideSwitchViewDelegate = self;
    
    _slideSwitchView.tabItemNormalColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1];
    _slideSwitchView.tabItemSelectedColor = [UIColor redColor];
    _slideSwitchView.shadowImage = [[UIImage imageNamed:@"navigation_bar_on"]
                                    stretchableImageWithLeftCapWidth:50.f topCapHeight:5.0f];
    
    self.sessionView = [[HuaDong1Controller alloc] init];
    self.sessionView.title = @"沟通";
//    self.sessionView.mainView = self;
//    self.sessionView.tableView.scrollsToTop = YES;
    
    self.contactView = [[HuaDong2Controller alloc] init];
    self.contactView.title = @"联系人";
//    self.contactView.mainView = self;
//    self.contactView.tableView.scrollsToTop = YES;
    
    self.groupListView = [[HuaDong3Controller alloc] init];
    self.groupListView.title = @"群组";
//    self.groupListView.mainView = self;
//    self.groupListView.isDiscuss = NO;
//    self.groupListView.tableView.scrollsToTop = YES;
    
    //讨论组
    
    self.discussGroupList = [[HuaDong4Controller alloc] init];
    _discussGroupList.title = @"讨论组";
//    _discussGroupList.mainView = self;
//    _discussGroupList.isDiscuss = YES;
//    _discussGroupList.tableView.scrollsToTop = YES;
    
    [_slideSwitchView buildUI];
    
    
    // Do any additional setup after loading the view.
}


-(void)changeMainDisplaySubview:(NSNotification*)notification {
    NSInteger selectIndex = [notification.object integerValue];
    [_slideSwitchView setSelectedViewIndex:selectIndex andAnimation:NO];
}


/*
 * 返回tab个数
 */


- (NSUInteger)numberOfTab:(SlideSwitchView *)view {
    return 4;
}

/*
 * 每个tab所属的viewController
 */
- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number {
    if (number == 0) {
        return self.sessionView;
    } else if (number == 1) {
        return self.contactView;
    } else if (number == 2) {
        return self.groupListView;
    } else if (number == 3) {
        return self.discussGroupList;
    } else {
        return nil;
    }
}

/*
 * 点击tab
 */
- (void)slideSwitchView:(SlideSwitchView *)view didselectTab:(NSUInteger)number {
    if (number == 0) {
//        self.groupListView.tableView.scrollsToTop = NO;
//        self.sessionView.tableView.scrollsToTop = YES;
//        self.contactView.tableView.scrollsToTop = NO;
//        self.discussGroupList.tableView.scrollsToTop = NO;
        //[self.sessionView prepareDisplay];
    } else if (number == 1) {
//        self.groupListView.tableView.scrollsToTop = NO;
//        self.sessionView.tableView.scrollsToTop = NO;
//        self.contactView.tableView.scrollsToTop = YES;
//        self.discussGroupList.tableView.scrollsToTop = NO;
//        [self.contactView prepareDisplay];
    } else if (number == 2) {
//        self.groupListView.tableView.scrollsToTop = YES;
//        self.sessionView.tableView.scrollsToTop = NO;
//        self.contactView.tableView.scrollsToTop = NO;
//        self.discussGroupList.tableView.scrollsToTop = NO;
//        [self.groupListView prepareGroupDisplay];
    } else if (number == 3) {
//        self.discussGroupList.tableView.scrollsToTop = YES;
//        self.groupListView.tableView.scrollsToTop = NO;
//        self.sessionView.tableView.scrollsToTop = NO;
//        self.contactView.tableView.scrollsToTop = NO;
//        [self.discussGroupList prepareGroupDisplay];
    } else {
        
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

//
//  LaunchDetailController.h
//  总结
//
//  Created by dazaoqiancheng on 16/3/25.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "BaseController.h"

@interface LaunchDetailController : BaseController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSString *shopid;

@property(nonatomic,strong)UITableView *shopTableView;

@end

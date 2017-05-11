//
//  FMDBController.m
//  整理文
//
//  Created by dazaoqiancheng on 2017/5/5.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "FMDBController.h"
#import "FMDB.h"
#import "PersonModel.h"


@interface FMDBController ()
@property(nonatomic,strong)FMDatabase *database;

@property(nonatomic,strong)UIButton *insertButton;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,strong)UIButton *updateButton;

@property(nonatomic,strong)UIButton *selectButton;

@end

@implementation FMDBController


- (UIButton *)insertButton{
    if (!_insertButton) {
        _insertButton = [[UIButton alloc]init];
        _insertButton.frame = CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40);
        _insertButton.backgroundColor = [UIColor blueColor];
        [_insertButton addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
        [_insertButton setTitle:@"插入数据" forState:UIControlStateNormal];
    }
    return _insertButton;
    
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc]init];
        _deleteButton.frame = CGRectMake(20, _insertButton.bottom+ 20, SCREEN_WIDTH - 40, 40);
        _deleteButton.backgroundColor = [UIColor blueColor];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitle:@"删除数据" forState:UIControlStateNormal];
    }
    return _deleteButton;
}

-(UIButton *)updateButton{
    if (!_updateButton) {
        _updateButton = [[UIButton alloc]init];
        _updateButton.frame = CGRectMake(20, _deleteButton.bottom+ 20, SCREEN_WIDTH - 40, 40);
        _updateButton.backgroundColor = [UIColor blueColor];
        [_updateButton addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
        [_updateButton setTitle:@"修改数据" forState:UIControlStateNormal];
    }
    
    return _updateButton;
}

-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]init];
        _selectButton.frame = CGRectMake(20, _updateButton.bottom+ 20, SCREEN_WIDTH - 40, 40);
        _selectButton.backgroundColor = [UIColor blueColor];
        [_selectButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton setTitle:@"查询数据" forState:UIControlStateNormal];
    }
    return _selectButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"数据库";
    
    
    
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"temp.db"];
    NSLog(@"filePath%@",filePath);
    
    
    _database = [FMDatabase databaseWithPath:filePath];
    
    BOOL flag = [_database open];
    
    if (flag) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
    
    
    //创建表
    BOOL createTable =  [_database executeUpdate:@"create table if not exists t_health(id integer primary key  autoincrement, name text,phone text)"];
    
    
    if (createTable) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    
    
    
    [self.view addSubview:self.insertButton];
    [self.view addSubview:self.deleteButton];
    [self.view addSubview:self.updateButton];
    [self.view addSubview:self.selectButton];
    
    
    
    // Do any additional setup after loading the view.
}


- (void)insertAction{
    
    BOOL insert = [_database executeUpdate:@"insert into t_health (name,phone) values(?,?)",@"jacob",@"138000000000"];
    
    if (insert) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
    
    
}



- (void)deleteAction{
    
    BOOL delete = [_database executeUpdate:@"delete from t_health where name like ?",@"jacob"];
    if (delete) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败");
    }
}


- (void)updateAction{
    
    BOOL update = [_database executeUpdate:@"update t_health set name = ?  where phone = ?",@"suncuihua",@"138000000000"];
    if (update) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败");
    }
    
    
}

- (void)selectAction{
    
    FMResultSet *set = [_database executeQuery:@"select * from t_health "];
    
    while ([set next]) {
        NSString *name =  [set stringForColumn:@"name"];
        NSString *phone = [set stringForColumn:@"phone"];
        
        NSLog(@"name : %@ phone: %@",name,phone);
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

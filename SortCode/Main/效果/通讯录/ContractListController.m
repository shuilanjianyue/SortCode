//
//  ContractListController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ContractListController.h"
#import <Contacts/Contacts.h>

@interface ContractListController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;


@property(nonatomic,strong)NSMutableArray *nameArray;

@property(nonatomic,strong)NSMutableArray *phoneArray;


@end

@implementation ContractListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"通讯录列表";
    
    self.nameArray = [NSMutableArray array];
    
    self.phoneArray = [NSMutableArray array];
    
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.backgroundView = nil;
    self.myTableView.rowHeight=60;
    //self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];
    
    [self getAddressList];
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifer = @"DeleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifer];
    }
    
    
    cell.textLabel.text=self.nameArray[indexPath.row];
    cell.detailTextLabel.text = self.phoneArray[indexPath.row];
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -获取指定的字段,并不是要获取所有字段，需要指定具体的字段
- (void)getAddressList{
    
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        
        NSString *name = [NSString stringWithFormat:@"%@%@",familyName,givenName];
        
        
        //某个人的所有电话
        NSArray *phoneNumbers = contact.phoneNumbers;
        
        //            for (CNLabeledValue *labelValue in phoneNumbers) {
        //                NSString *label = labelValue.label;
        //                CNPhoneNumber *phoneNumber = labelValue.value;
        //
        //                NSLog(@"label=%@, phone=%@", label, phoneNumber.stringValue);
        //            }
        
        
        CNLabeledValue *phoneLabel = phoneNumbers[0];
        
        CNPhoneNumber *phoneNumber = phoneLabel.value;
        
        NSLog(@"Name=%@",phoneLabel.label);
        
        
        //去除数字以外的所有字符
        //invertedSet方法是去反字符,把所有的除了@"0123456789"里的字符都找出来(包含去空格功能)
        NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
        NSString *strPhone = @"";
        if (phoneNumber.stringValue.length>0) {
            strPhone  = [[phoneNumber.stringValue componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
        }
        
        //去掉手机号前面的＋86或86
        if (strPhone.length>11) {
            strPhone = [strPhone substringWithRange:NSMakeRange(strPhone.length-11, 11)];
            
        }
        
        if(name.length>0){
            [self.nameArray addObject:name];
            [self.phoneArray addObject:strPhone];
        }
        
        //        *stop = YES;  // 停止循环，相当于break；
    }];
    
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

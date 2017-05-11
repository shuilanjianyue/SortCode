//
//  AddressListController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/9.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "AddressListController.h"
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>

#import "ContractListController.h"

@interface AddressListController ()<CNContactPickerDelegate>

@end

@implementation AddressListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"通讯录";
    
    
   UIButton *showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"打开系统通讯录" forState:UIControlStateNormal];
    
    [showButton1 addTarget:self action:@selector(showsAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton1];
    
    
    UIButton *showButton2=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 80, SCREEN_WIDTH - 40, 40)];
    [showButton2 setBackgroundColor:[UIColor magentaColor]];
    [showButton2 setTitle:@"自定义通讯录列表" forState:UIControlStateNormal];
    
    [showButton2 addTarget:self action:@selector(showsAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton2];

    
    
    [self requestAuthorizationForAddressBook];

    // Do any additional setup after loading the view.
}


- (void)showsAction1{
    
    CNContactPickerViewController *contact = [[CNContactPickerViewController alloc]init];
    contact.delegate = self;
    
    [self presentViewController:contact animated:YES completion:nil];
    
}

-(void)showsAction2{
    ContractListController *contact = [[ContractListController alloc]init];
    [self pushNewViewController:contact];
    
}

//// 选择单个联系人
//// 如果实现该方法当选中联系人时就不会再出现联系人详情界面， 如果需要看到联系人详情界面只能不实现这个方法，
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
//    
//    [self printContactInfo:contact];
//    
//}


// 同时选中多个联系人
// 如果实现该方法当选中联系人时就不会再出现联系人详情界面， 如果需要看到联系人详情界面只能不实现这个方法，
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
    for (CNContact *contact in contacts) {
        
        [self printContactInfo:contact];
    }
}


//注意:如果实现该方法，上面那个方法就不能实现了，这两个方法只能实现一个
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
//    
//    NSLog(@"%@",contactProperty);
//    NSLog(@"选中某个联系人的某个属性时调用");
//    
//}


- (void)printContactInfo:(CNContact *)contact {
    NSString *givenName = contact.givenName;
    NSString *familyName = contact.familyName;
    NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
    NSArray * phoneNumbers = contact.phoneNumbers;
    for (CNLabeledValue<CNPhoneNumber*>*phone in phoneNumbers) {
        NSString *label = phone.label;
        CNPhoneNumber *phonNumber = (CNPhoneNumber *)phone.value;
        NSLog(@"label=%@, value=%@", label, phonNumber.stringValue);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/***************以下是*********************/
- (void)requestAuthorizationForAddressBook {
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusNotDetermined) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
               
                NSLog(@"授权成功");
                
                
                
            } else {
                NSLog(@"授权失败, error=%@", error);
            }
        }];
    }
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

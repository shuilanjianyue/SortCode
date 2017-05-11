//
//  IOS.h
//  整理文
//
//  Created by dazaoqiancheng on 16/12/12.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjectProtocol <JSExport>

@required
#pragma mark -js调用该oc方法，并且将jsonstring打印出来
- (void)print:(NSString *)jsonString;


@end


@interface iOS : NSObject

@end

//
//  WKDelegateController.h
//  DZQCStudent
//
//  Created by wangyibo on 2017/4/19.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "BaseController.h"
#import <WebKit/WebKit.h>

@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : BaseController <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKDelegate> delegate;

@end

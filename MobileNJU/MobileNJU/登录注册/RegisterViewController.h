//
//  RegisterViewController.h
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface RegisterViewController : BaseViewController<UITextFieldDelegate>
- (void) showAlert:(NSString*) msg;
@end

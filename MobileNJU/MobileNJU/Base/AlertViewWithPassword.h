//
//  AlertViewWithPassword.h
//  MobileNJU
//
//  Created by luck-mac on 14-8-4.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AlertViewWithPassword : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UIButton *searchBt;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *tintLabel;
@end

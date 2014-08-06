//
//  AlertView.h
//  MobileNJU
//
//  Created by luck-mac on 14-8-4.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBt;
@property (weak, nonatomic) IBOutlet UIButton *searchBt;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@end

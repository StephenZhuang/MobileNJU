//
//  GradeVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface GradeVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *maskView;
- (void)showAlert;
- (IBAction)cancelAlert:(id)sender;
@end

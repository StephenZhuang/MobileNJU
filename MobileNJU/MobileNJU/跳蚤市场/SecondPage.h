//
//  SecondPage.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQActionSheetPickerView.h"

@interface SecondPage : UIView<UITextFieldDelegate,IQActionSheetPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *QQField;
@property (weak, nonatomic) IBOutlet UILabel *QQLabel;
@property(nonatomic,strong)NSArray* typeArr;
@property (nonatomic,strong)NSString* typeId;
@property (strong,nonatomic)UIFont *font;
@property (strong,nonatomic)UITextField* lastField;
@end

//
//  FirstPage.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageDelegate.h"
@interface FirstPage : UIView<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *takePhotoBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceFIeld;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *originPriceField;
@property (weak, nonatomic) IBOutlet UITextView *discriptionField;
@property (weak, nonatomic) IBOutlet UILabel *discLabel;
@property (weak, nonatomic) IBOutlet UILabel *discLabel2;
@property (weak, nonatomic) IBOutlet UIView *photoArea;
@property (strong,nonatomic)UIFont *font;
@property (strong,nonatomic)id lastField;
@property (strong,nonatomic)NSMutableArray* photoArray;
@property (strong,nonatomic)NSMutableArray* buttonArray;
@property (nonatomic,assign)IBOutlet id<PageDelegate> myDelegate;
-(void) initial;

@end

//
//  AddTreeHoleViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"
#import "UIPlaceHolderTextView.h"
#import "GKImagePicker.h"

typedef void(^AddSuccessBlock)(void);

@interface AddTreeHoleViewController : BaseViewController<UIImagePickerControllerDelegate , UIActionSheetDelegate ,UITableViewDelegate ,UITableViewDataSource ,GKImagePickerDelegate , UITextViewDelegate>
@property (nonatomic , weak) IBOutlet UITableView *tableView;
@property (nonatomic , weak) IBOutlet UIPlaceHolderTextView *textView;
@property (nonatomic , strong) UIImage *image;
@property (nonatomic , weak) IBOutlet UIView *bottomView;
@property (nonatomic , copy) AddSuccessBlock addSuccessBlock;
@property (nonatomic , strong) GKImagePicker *imagePicker;
@property (nonatomic , strong) MTag *mtag;
@property (nonatomic , weak) IBOutlet UIView *footView;
@end

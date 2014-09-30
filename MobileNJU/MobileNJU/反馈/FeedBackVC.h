//
//  FeedBackVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-9-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedBackVC : BaseViewController <UITextViewDelegate>
@property (strong, nonatomic) UIButton *submitBt;
@property (weak, nonatomic) IBOutlet UITextView *textArea;

@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@end

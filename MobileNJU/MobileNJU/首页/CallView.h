//
//  CallView.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-18.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallView : UIView
@property (nonatomic , strong) IBOutlet UIView *backView;
@property (nonatomic , strong) IBOutlet UIButton *cancelButton;
@property (nonatomic , strong) IBOutlet UIButton *confirmButton;
@property (nonatomic , copy) NSString *targetid;
@end

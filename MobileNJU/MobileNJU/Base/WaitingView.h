//
//  WaitingView.h
//  MobileNJU
//
//  Created by luck-mac on 14-8-3.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingView : UIView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UILabel *msgLbel;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImg;

@end

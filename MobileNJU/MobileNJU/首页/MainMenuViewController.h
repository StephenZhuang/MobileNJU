//
//  MainMenuViewController.h
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CallView.h"
@interface MainMenuViewController : UIViewController
@property(nonatomic,strong)NSMutableArray* photoList;
@property (nonatomic , strong) CallView *callView;
@property (nonatomic , strong) UIView *maskView;
@end

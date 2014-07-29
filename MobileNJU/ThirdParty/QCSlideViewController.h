//
//  QCSlideViewController.h
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"
#import "ShoppingVC.h"
#import "BaseViewController.h"
#import "ShoppingVCDelegate.h"
@interface QCSlideViewController : BaseViewController<QCSlideSwitchViewDelegate,ShoppingVCDelegate>
{
    QCSlideSwitchView *_slideSwitchView;
    NSArray* viewControllers;
   }

@property (nonatomic, strong) IBOutlet QCSlideSwitchView *slideSwitchView;

@property (nonatomic,strong)NSArray *viewControllers;

@end


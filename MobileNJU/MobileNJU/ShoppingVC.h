//
//  ShoppingVC.h
//  CreateLesson
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshCollectionViewController.h"
#import "ShoppingVCDelegate.h"
@interface ShoppingVC : RefreshCollectionViewController
@property (nonatomic,strong) id<ShoppingVCDelegate> myDelegate;
@property(nonatomic,strong)NSString* type;
-(void)startRefresh;
@end

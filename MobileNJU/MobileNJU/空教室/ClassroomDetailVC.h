//
//  ClassroomDetailVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZsndSystem.pb.h"
@interface ClassroomDetailVC : BaseViewController
@property (nonatomic,strong)NSDictionary* classrooms;
@property (nonatomic,strong)NSArray* floors;
@property (nonatomic,strong)NSArray* roomList;
@end

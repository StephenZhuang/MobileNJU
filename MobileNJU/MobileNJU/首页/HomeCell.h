//
//  HomeCell.h
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-20.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuButton.h"
@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MenuButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak,nonatomic) NSString* menuName;
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UILabel *menuSubTitle;
@property (weak, nonatomic) IBOutlet UIView *redCircle;
-(void)addUnread;
@end

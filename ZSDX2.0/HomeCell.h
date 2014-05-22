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
@property (weak,nonatomic) NSString* menuName;
@end

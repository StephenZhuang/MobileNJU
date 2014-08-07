//
//  AddImageCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-8-5.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageCell : UITableViewCell
@property (nonatomic , strong) IBOutlet UIImageView *backImage;
@property (nonatomic , strong) IBOutlet UIButton *changeButton;
@property (nonatomic , strong) IBOutlet UIButton *deleteButton;
@end

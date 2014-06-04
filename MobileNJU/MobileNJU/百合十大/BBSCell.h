//
//  BBSCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *idImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@property (weak, nonatomic) IBOutlet UIControl *Content;
@end

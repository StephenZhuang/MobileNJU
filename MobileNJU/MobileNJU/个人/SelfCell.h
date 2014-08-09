//
//  SelfCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-23.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
- (void)setImageName:(NSString *)imageName;
- (void)setContent:(NSString *)content;
@end

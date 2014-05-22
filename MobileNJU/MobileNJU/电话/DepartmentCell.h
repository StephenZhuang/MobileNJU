//
//  DepartmentCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
- (void)changeArrowWithUp:(BOOL)up;
@end

//
//  SubscribeCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscribeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
- (void)addNews:(NSArray*) news;
@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (strong,nonatomic)NSMutableArray* myNews;
@end

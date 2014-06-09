//
//  ActivityCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActivityCellDelegate<NSObject>

@required
-(void)showAll:(NSURL*)url;
@end

@interface ActivityCell : UITableViewCell
@property (nonatomic , assign) IBOutlet id<ActivityCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (strong,nonatomic)NSURL* url;
@property (weak, nonatomic) IBOutlet UIControl *activityView;
@property (nonatomic,strong)NSString* imageName;
- (void)setActivity:(NSDictionary*)activity;
@end

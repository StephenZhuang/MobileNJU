//
//  ActivityCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZsndNews.pb.h"
@protocol ActivityCellDelegate<NSObject>

@required
-(void)showAll:(MNews*)news img:(UIImage*)img;
@end

@interface ActivityCell : UITableViewCell
@property (nonatomic , assign) IBOutlet id<ActivityCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong,nonatomic)NSURL* url;
@property (weak, nonatomic) IBOutlet UIControl *activityView;
@property (nonatomic,strong)NSString* imageName;
- (void)setActivity:(NSDictionary*)activity;
@property(nonatomic,strong)UIImageView* imgView;

@property (nonatomic,strong)MNews* currentNew;
@end

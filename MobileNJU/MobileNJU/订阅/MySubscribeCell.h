//
//  MySubscribeCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RssDelegate <NSObject>

- (void)changeState:(NSString*)id;

@end

@interface MySubscribeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *subscribeSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeTitle;
@property (weak, nonatomic) IBOutlet UILabel *typeDetail;
@property (strong,nonatomic)NSString* id;
@property (nonatomic , assign) IBOutlet id<RssDelegate> delegate;
@end

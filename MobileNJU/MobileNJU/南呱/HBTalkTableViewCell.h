//
//  HBTalkTableViewCell.h
//  MyTest
//
//  Created by weqia on 13-8-10.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HBCoreLabel.h"
#import "ZsndChat.pb.h"
//#import "HBLabel.h"
//#import "HBAnimationUtil.h"
//#import "UIImageView+HBHttpCache.h"
//#import "HBImageScroller.h"
//#import "HBTalkData.h"
//#import "HBActivityIndicatorView.h"
//#import "TimeUtil.h"


#define ACTIVITYINDICATOR_TAG 1000
#define IMAGE_MAX_WIDTH  150
#define IMAGE_MAX_HEIGHT  100

@interface HBTalkTableViewCell : UITableViewCell
{
    UIView * _time;
    UIView * _cellContent;
    
    UIImageView * _mLogo;
    UIImageView * _backView;
    UIView *_content;
}

@property(nonatomic,strong) MChat * talkData;

-(void)clear;

-(void)setContent;

+(float)getHeightByContent:(MChat *)data;

-(void) setLogoImage:(NSString*)url;

-(void)setLogoImageWithImage:(UIImage*)image;

@end

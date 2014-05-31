//
//  NewsListView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListView : UIView
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDetail;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@end

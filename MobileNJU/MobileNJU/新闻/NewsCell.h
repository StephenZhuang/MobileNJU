//
//  NewsCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsType;
@property (weak, nonatomic) IBOutlet UILabel *newsDate;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsDetail;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;


@property (strong,nonatomic)NSString* imageName;
@property (strong,nonatomic)NSString* type;
@property (strong,nonatomic)NSString* date;
@property (strong,nonatomic)NSString* title;
@property (strong,nonatomic)NSString* detail;
@end

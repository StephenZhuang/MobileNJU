//
//  SubscribeCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SubscribeCell.h"
#import "NewsListView.h"
#import "ZsndNews.pb.h"
#import "UtilMethods.h"
@implementation SubscribeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)myNews
{
    if (!_myNews) {
        _myNews = [[NSMutableArray alloc]init];
    }
    return _myNews;
}

- (void)addNews:(NSArray *)news
{
    if (self.myNews.count>=3) {
        return;
    }
    self.newsView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.newsView.layer.borderWidth = 1 ;
    self.newsView.layer.cornerRadius = 5;
    for (int i = 0 ; i < news.count; i++) {
#warning 此处需要写一个判断重复的。或者遍历现有的view，重新设置。
//        NSDictionary* each_news = [news objectAtIndex:i];
        NewsListView* view  = [[[NSBundle mainBundle] loadNibNamed:@"NewsListView" owner:self options:nil] firstObject];
        CGRect frame = CGRectMake(2, 153+60*i, 280, 59);
        view.frame = frame;
        MNews* new = [news objectAtIndex:i];
        [view.newsTitle setText:new.title];
        [view.newsDetail setText:new.content];
        [view.newsImage setImageWithURL:[UtilMethods getImageUrlWtihString:new.url width:60 height:60]];
        [self.newsView addSubview:view];
        CGRect frame_of_newsView = self.newsView.frame;
        frame_of_newsView.size.height = frame_of_newsView.size.height+60;
        self.newsView.frame = frame_of_newsView;
        [self.myNews addObject:new];
        if (self.myNews.count==3) {
            return;
        }
    }
}

@end

//
//  SubscribeCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SubscribeCell.h"
#import "NewsListView.h"
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

- (void)addNews:(NSArray *)news
{
    for (int i = 0 ; i < news.count; i++) {
//        NSDictionary* each_news = [news objectAtIndex:i];
        NewsListView* view  = [[[NSBundle mainBundle] loadNibNamed:@"NewsListView" owner:self options:nil] firstObject];
        CGRect frame = CGRectMake(0, 153+60*i, 280, 59);
        view.frame = frame;
        [self.newsView addSubview:view];
        CGRect frame_of_newsView = self.newsView.frame;
        frame_of_newsView.size.height = frame_of_newsView.size.height+60;
        self.newsView.frame = frame_of_newsView;
    }
}

@end

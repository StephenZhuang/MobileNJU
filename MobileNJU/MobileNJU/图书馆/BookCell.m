//
//  BookCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BookCell.h"
#import "BookView.h"
@implementation BookCell


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBooks:(NSArray *)books delegate:(id<BookChooseDelegate>)myDelegate
{
    self.books = books;
    for (int i = 0 ; i<[books count]; i++) {
         BookView* bookView = [[[NSBundle mainBundle] loadNibNamed:@"BookView" owner:self options:nil] firstObject];
        [bookView setBook:[books objectAtIndex:i]];
        CGRect frame = CGRectMake(10+i*105, 7, 90, 127);
        bookView.frame = frame;
        [bookView setMyDelegate:myDelegate];
        [self addSubview:bookView];
    }
}


@end

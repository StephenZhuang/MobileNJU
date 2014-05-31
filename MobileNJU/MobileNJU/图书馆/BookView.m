//
//  BookView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BookView.h"

@implementation BookView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMyDelegate:(id<BookChooseDelegate>)delegate
{
    myDelegate = delegate;
}

- (void)setBook:(Book *)book
{
    _book = book;
    [self.bookName setText:book.bookName];
    [self.hasCount setText:book.hasCount];
    [self.canLentCount setText:book.canLentCount];
    [self.press setText:book.press];
    [self.auther setText:book.author];
}
- (IBAction)chooseBook:(id)sender {
    [myDelegate chooseBook:self.book];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

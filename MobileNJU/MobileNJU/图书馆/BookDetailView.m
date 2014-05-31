//
//  BookDetailView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BookDetailView.h"

@implementation BookDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)closeAlert:(id)sender {
    [myDelegate closeAlert];
}

- (void)setDelegate:(id<AlertCloseDelegate>)delegate
{
    myDelegate = delegate;
}

- (void)setBook:(Book *)book
{
    _book = book;
    [self.borrowId setText: book.borrowId];
    [self.barCode setText:book.barCode];
    [self.location setText:book.location];
    [self.state setText:book.state];
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

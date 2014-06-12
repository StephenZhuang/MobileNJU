//
//  BookDetailScrollerView.m
//  MobileNJU
//
//  Created by luck-mac on 14-6-9.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BookDetailScrollerView.h"

@implementation BookDetailScrollerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.scrollerView) {
        int index=scrollView.contentOffset.x/scrollView.frame.size.width;
        self.pageControl.currentPage=index;
    }
}

- (IBAction)closeAlert:(id)sender {
    [myDelegate closeAlert];
}


-(void)pageChange:(UIPageControl *)sender{
    CGFloat offset= self.pageControl.currentPage*260;
    [self.scrollerView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)setDelegate:(id<AlertCloseDelegate>)delegate
{
    myDelegate = delegate;
}

- (void)initNewScroller
{
    self.scrollerView.delegate = self;
    self.scrollerView.pagingEnabled=YES;
    self.pageControl.currentPage=0;
    [self.pageControl addTarget:self action:@selector(pageChange:)
                  forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBooks:(NSArray *)books
{
    
    [self initNewScroller];
    self.scrollerView.contentSize = CGSizeMake(260*books.count, 180);
    self.pageControl.numberOfPages=books.count;
    for (int i = 0 ; i < books.count ; i++){
        BookDetailView*   bookDetail = [[[NSBundle mainBundle] loadNibNamed:@"BookDetailView" owner:self options:nil] objectAtIndex:0];
        [bookDetail setFrame:CGRectMake(i*260, 0,260,180)];
        [bookDetail setBook:[books objectAtIndex:i]];
        [self.scrollerView addSubview:bookDetail];
    }
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

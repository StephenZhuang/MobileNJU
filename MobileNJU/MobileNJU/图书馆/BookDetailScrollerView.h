//
//  BookDetailScrollerView.h
//  MobileNJU
//
//  Created by luck-mac on 14-6-9.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailView.h"
@interface BookDetailScrollerView : UIView
<UIScrollViewDelegate>

{
    id<AlertCloseDelegate> myDelegate;
}
- (void) setDelegate:(id<AlertCloseDelegate>)delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void)addBooks:(NSArray*)books;
@end

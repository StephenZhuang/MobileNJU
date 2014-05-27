//
//  BookCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookChooseDelegate.h"

@interface BookCell : UITableViewCell
@property (nonatomic,strong)NSArray* books;

- (void)setBooks:(NSArray *)books delegate:(id<BookChooseDelegate>)myDelegate;
@end

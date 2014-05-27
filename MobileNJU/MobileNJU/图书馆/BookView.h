//
//  BookView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookChooseDelegate.h"
@interface BookView : UIView
{
    id<BookChooseDelegate> myDelegate;
}
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *hasCount;
@property (weak, nonatomic) IBOutlet UILabel *canLentCount;
@property (weak, nonatomic) IBOutlet UILabel *press;
@property (weak, nonatomic) IBOutlet UILabel *auther;
@property (strong,nonatomic) Book* book;
- (void)setMyDelegate:(id<BookChooseDelegate>) delegate;
@end

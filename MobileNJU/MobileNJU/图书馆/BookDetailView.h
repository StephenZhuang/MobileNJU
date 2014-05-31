//
//  BookDetailView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertCloseDelegate.h"
#import "Book.h"
@interface BookDetailView : UIView

{
    id<AlertCloseDelegate> myDelegate;
}
- (void) setDelegate:(id<AlertCloseDelegate>)delegate;
@property (weak, nonatomic) IBOutlet UILabel *borrowId;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *barCode;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property(nonatomic,strong)Book* book;
@end

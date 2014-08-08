//
//  BookDetailView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VerticallyAlignedLabel.h"
#import "AlertCloseDelegate.h"
#import "Book.h"
@interface BookDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *borrowId;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *barCode;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet VerticallyAlignedLabel *bookName;

@property(nonatomic,strong)Book* book;
@end

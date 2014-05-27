//
//  MyBookCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
@interface MyBookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *borrowDate;

@property (weak, nonatomic) IBOutlet UILabel *returnDate;
@property(strong,nonatomic)Book* book;
@end

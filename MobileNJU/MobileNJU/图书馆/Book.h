//
//  Book.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property (nonatomic,strong)NSString* bookName;
@property (nonatomic,strong)NSString* author;
@property(nonatomic,strong)NSString* press;
@property (nonatomic,strong)NSString* hasCount;
@property(nonatomic,strong)NSString* canLentCount;
@property(nonatomic,strong)NSString* barCode;
@property(nonatomic,strong)NSString* borrowId;
@property(nonatomic,strong)NSString* location;
@property(nonatomic,strong)NSString* state;
@property (nonatomic,strong)NSString* borrowDate;
@property(nonatomic,strong)NSString* returnDate;
@end

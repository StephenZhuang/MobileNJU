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

@end

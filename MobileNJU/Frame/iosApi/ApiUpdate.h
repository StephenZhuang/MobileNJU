//
//  ApiUpdate.h
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-10.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiUpdate : NSObject
- (UpdateOne*)instanceUpdate:(UpdateOne*)updateone;
- (id)isShowLoad:(BOOL)showload;
- (id)setPage:(int)page pageCount:(int)pageCount;
@end

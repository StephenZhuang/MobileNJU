//
//  ApiUpdate.m
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-10.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "ApiUpdate.h"

@implementation ApiUpdate{
    BOOL Mshowload;
    BOOL hasPage;
    int _page;
    int _pageCount;
}



- (id)isShowLoad:(BOOL)showload
{
    Mshowload=showload;
    return self;
}

- (id)setPage:(int)page pageCount:(int)pageCount
{
    hasPage = YES;
    _page = page;
    _pageCount = pageCount;
    return self;
}

- (UpdateOne*)instanceUpdate:(UpdateOne*)updateone
{
    [updateone setShowLoading:Mshowload];
    if (hasPage) {
        [updateone addParam:@"page" value:[NSString stringWithFormat:@"%d" , _page]];
        [updateone addParam:@"limit" value:[NSString stringWithFormat:@"%d" , _pageCount]];
    }
    return updateone;
}

- (id)page:(int)page pageCount:(int)pageCount
{
    return self;
}
@end

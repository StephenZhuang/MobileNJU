//
//  RefreshCollectionViewController.h
//  MobileNJU
//
//  Created by luck-mac on 14-8-2.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
@interface RefreshCollectionViewController : BaseViewController
{
@protected
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    //    FootView *_footer;
    int page;
    NSInteger pageCount;
    BOOL hasMore;
    BOOL isLoading;
}
@property (nonatomic , weak) IBOutlet UICollectionView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;
- (void)doneWithView:(MJRefreshBaseView *)refreshView;
- (void)addHeader;
- (void)addFooter;
- (void)loadData;

@end

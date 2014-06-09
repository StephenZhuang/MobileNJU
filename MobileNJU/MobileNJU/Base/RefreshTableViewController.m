//
//  RefreshTableViewController.m
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-8.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "RefreshTableViewController.h"

NSString *const MJTableViewCellIdentifier = @"Cell";

@interface RefreshTableViewController ()

@end

@implementation RefreshTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    pageCount = 10;
    hasMore = YES;
    isLoading = YES;
    self.dataArray = [[NSMutableArray alloc] init];
    [self addHeader];
    [self addFooter];
}

- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 增加5条假数据
//        for (int i = 0; i<5; i++) {
//            int random = arc4random_uniform(1000000);
//            [self.dataArray addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
//        }
//        
//        // 模拟延迟加载数据，因此2秒后才调用）
//        // 这里的refreshView其实就是footer
//        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        page ++;
        [self loadData];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    footer.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    _footer = footer;
//    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FootView" owner:self options:nil];
//    _footer = [arr objectAtIndex:0];
//    self.tableView.tableFooterView = _footer;
}

- (void)addHeader
{
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
//        for (int i = 0; i<5; i++) {
//            int random = arc4random_uniform(1000000);
//            [self.dataArray insertObject:[NSString stringWithFormat:@"随机数据---%d", random] atIndex:0];
//        }
//        
//        // 模拟延迟加载数据，因此2秒后才调用）
//        // 这里的refreshView其实就是header
//        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        if (!hasMore) {
//            [_footer changeToLoading];
        }
        page = 1;
        hasMore = YES;
        [self loadData];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    
}

- (void)loadData
{
    isLoading = YES;
    if (page == 1) {
        [self.dataArray removeAllObjects];
//        [self.tableView reloadData];
    }
    
    for (int i = 0; i < pageCount; i++) {
        int random = arc4random_uniform(1000000);
        [self.dataArray addObject:[NSString stringWithFormat:@"随机数据---%d", random]];
    }
    [self performSelector:@selector(getData) withObject:nil afterDelay:2];
    
}

- (void)getData
{
    isLoading = NO;
    if (page == 1) {
        [self performSelector:@selector(doneWithView:) withObject:_header afterDelay:2.0];
    } else {
        
        [self performSelector:@selector(doneWithView:) withObject:_footer afterDelay:2.0];
        if (page == 5) {
            hasMore = NO;
            if (!hasMore) {
//                [_footer changeToNoMore]; 
            }
        }
//        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier];
    
    if (indexPath.row < self.dataArray.count) {
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) {
//        if (hasMore && !isLoading) {
//            page++;
//            [self loadData];
//        }
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

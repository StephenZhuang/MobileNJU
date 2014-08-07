//
//  RSSListVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RSSListVC.h"
#import "NewsCell.h"
#import "ZsndNews.pb.h"
#import "NewsDetailVC.h"
#import "ApiMRssNews.h"
@interface RSSListVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray* rssNews;
@property(nonatomic,strong)MNews* currentNew;
@property(nonatomic,strong)UIImage* currentImg;
@property(nonatomic,strong)NSString* currentUrl;
@end

@implementation RSSListVC

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
    self.rssNews = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear: (BOOL)inAnimated {
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected)
    {
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
    }
    
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData
{
    ApiMRssNews* api = [[ApiMRssNews alloc]init];
    [[api setPage:page pageCount:10] load:self selecter:@selector(disposMessage:) rssid:self.rssId];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MRssNews"]) {
            MMyRss_Builder* ret = (MMyRss_Builder*)[son getBuild];
            if (page==1) {
                [self.rssNews removeAllObjects];
                [self.rssNews addObjectsFromArray:ret.newsList];
                
            } else {
                [self.rssNews addObjectsFromArray:ret.newsList];
                [self doneWithView:_footer];
                
            }
        }
    } else {
        [super disposMessage:son];
    }

    [self doneWithView:_header];
}


#pragma -mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rssNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
    MNews* new = [self.rssNews objectAtIndex:indexPath.row];
    cell.title = new.title;
    cell.type = new.source;
    cell.detail = new.content;
    cell.date = new.time;
    [cell.newsImage setImageWithURL:[ToolUtils getImageUrlWtihString:new.img width:178 height:134] placeholderImage:[UIImage imageNamed:@"news_loading"]];
    
//    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView = backView;
//    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNews* news = [self.rssNews objectAtIndex:indexPath.row];
    self.currentUrl = news.url;
    self.currentNew = news;
    NewsCell* cell  = (NewsCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    self.currentImg = cell.newsImage.image;
    [self performSegueWithIdentifier:@"detail" sender:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"detail"]) {
        NewsDetailVC* destinationVC = (NewsDetailVC*)segue.destinationViewController;
        NSURL* url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://114.215.196.179/%@",self.currentUrl]];
        NSLog(@"设置的网址%@",self.currentUrl);
        [destinationVC setMyTitle:@"订阅详情"];
        [destinationVC setUrl:url];
        
        [destinationVC setCurrentNew:self.currentNew];
        [destinationVC setImg:self.currentImg];
    }
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

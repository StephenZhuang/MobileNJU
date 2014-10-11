//
//  RSSVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RSSVC.h"
#import "subscribeCell_n.h"
#import "ZsndNews.pb.h"
#import "RSSListVC.h"
#import "ZsndSystem.pb.h"
#import "NewsDetailVC.h"
#import "APService.h"
@interface RSSVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray* myRss;
@end

@implementation RSSVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backToMain
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)gotoAll
{
    [self performSegueWithIdentifier:@"all" sender:nil];
}
- (void)addFooter
{
    
}
- (void) viewWillAppear: (BOOL)inAnimated {
    [super viewWillAppear:inAnimated];

    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected)
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"兴趣"];
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    NSString *iconname=@"10-1跳蚤市场-添加";
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",iconname]] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",iconname]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(gotoAll) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
    [self.navigationItem setRightBarButtonItem:myAddButton];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{   
    [self loadData];
    
    if ([ToolUtils showRss]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        NewsDetailVC* detail = (NewsDetailVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"NewsDetail"]; //test2为viewcontroller的StoryboardId
        MNews_Builder* focus = [[MNews_Builder alloc]init];
        NSDictionary* pushNews = [ToolUtils showRss];
        focus.title = [pushNews objectForKey:@"title"];
        focus.source = [pushNews objectForKey:@"source"];
        focus.img = [pushNews objectForKey:@"img"];
        focus.url = [pushNews objectForKey:@"url"];
        [detail setMyTitle:@"兴趣详情"];
        NSURL* url;
        if (![focus.url hasPrefix:@"http"]) {
            url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://s1.smartjiangsu.com:89/%@",focus.url]];
        } else {
            url = [[NSURL alloc]initWithString:focus.url];
        }
        detail.url = url;
        detail.currentNew = focus.build;

        [self.navigationController pushViewController:detail animated:YES];
        [ToolUtils setShowRss:nil];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [[ApisFactory getApiMMyRss]load:self selecter:@selector(disposMessage:)];
//    [self disposMessage:nil];
}

- (void)disposMessage:(Son *)son
{
    
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MMyRss"]) {
            MRssList_Builder* ret = (MRssList_Builder*)[son getBuild];
            self.myRss = ret.listList;
            NSMutableArray* idList = [[NSMutableArray alloc]init];
            for (MRss* news in self.myRss) {
                NSString* tag =[ news.id stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
                [idList addObject:[NSString stringWithFormat:@"%@rss",tag]];
                NSLog(@"%@",news.id);
            }
            [ToolUtils setTagList:idList];
            UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
            if(types!= UIRemoteNotificationTypeNone)
            {
                [APService setTags:[[NSSet alloc]initWithArray:idList] alias:[[ToolUtils getVerify] stringByReplacingOccurrencesOfString:@"-" withString:@"_"] callbackSelector:nil target:nil];
            }
        }
    } else {
        [super disposMessage:son];
    }

    [self doneWithView:_header];

}


#pragma mark -tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    subscribeCell_n *cell = [tableView dequeueReusableCellWithIdentifier:@"Rss" forIndexPath:indexPath];
    MRss* rss = [self.myRss objectAtIndex:indexPath.row];
    [cell.rssTitle setText:rss.title];
    [cell.rssDetail setText:rss.content];
    if (rss.count==0) {
        [cell.unReadButton setHidden:YES];
    } else {
        [cell.unReadButton setTitle:[NSString stringWithFormat:@"%d",rss.count] forState:UIControlStateNormal];
    }
    [cell.rssImg setImageWithURL:[ToolUtils getImageUrlWtihString:rss.img width:90 height:92] placeholderImage:[UIImage imageNamed:@"90乘92"]];
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myRss.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MRss* rss = [self.myRss objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"list" sender:rss];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"list"]) {
        RSSListVC* controller = (RSSListVC*)[segue destinationViewController];
        [controller setTitle:((MRss*)sender).title];
        [controller setRssId :((MRss*)sender).id];
        
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

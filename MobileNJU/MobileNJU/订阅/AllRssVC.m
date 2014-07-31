//
//  AllRssVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AllRssVC.h"
#import "MySubscribeCell.h"
#import "ZsndNews.pb.h"

@interface AllRssVC ()<UITableViewDelegate,UITableViewDataSource,RssDelegate>
@property (nonatomic,strong)NSArray* allRss;
@end

@implementation AllRssVC

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
    [self setTitle:@"全部订阅"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning  todo
- (void)loadData
{
    [[ApisFactory getApiMAllRss]load:self selecter:@selector(disposMessage:)];
}
- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MAllRss"]) {
            MRssList_Builder* builder = (MRssList_Builder*)[son getBuild];
            self.allRss = builder.listList;
            
        }
    }
    [self doneWithView:_header];
}

#pragma -mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allRss.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allRss" forIndexPath:indexPath];
    MRss* rss = [self.allRss objectAtIndex:indexPath.row];
    [cell.typeTitle setText:rss.title ];
    [cell.typeDetail setText:rss.content];
    [cell.myImageView setImageWithURL:[ToolUtils getImageUrlWtihString:rss.img width:45 height:45] placeholderImage:[UIImage imageNamed:@"news_loading"]];
    [cell.subscribeSwitch setOn:rss.state==1];
    cell.id = rss.id;
    cell.delegate = self;
    return cell;
}

- (void)changeState:(NSString *)id
{
    for (MRss* rss in self.allRss)
    {
        if ([rss.id isEqualToString:id])
        {
            if (rss.state==1)
            {
               [[ApisFactory getApiMRss]load:self selecter:@selector(disposMessage:) rssid:id];
            } else {
                
            }
            
        }
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

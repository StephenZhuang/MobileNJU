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
@property (nonatomic,strong)NSMutableArray* allRss;

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
    self.allRss = [[NSMutableArray alloc]init];
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
    [[[ApisFactory getApiMAllRss] setPage:page pageCount:10] load:self selecter:@selector(disposMessage:)];
}


- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MAllRss"]) {
            MRssList_Builder* builder = (MRssList_Builder*)[son getBuild];
            if (page==1) {
                [self.allRss removeAllObjects];
                [self.allRss  addObjectsFromArray:builder.listList];
                [self doneWithView:_header];
            } else {
                [self.allRss  addObjectsFromArray:builder.listList];
                [self doneWithView:_footer];
            }
        } else if ([[son getMethod]isEqualToString:@"MRss"]||[[son getMethod]isEqualToString:@"MRssCancel"])
        {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
//            [ToolUtils showMessage:ret.msg];
//            [_header beginRefreshing];
        }
    } else {
        [super disposMessage:son];
    }
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
    [cell.myImageView setImageWithURL:[ToolUtils getImageUrlWtihString:rss.img width:90 height:90] placeholderImage:[UIImage imageNamed:@"90乘92"]];
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
            if (rss.state==0)
            {
               [[[ApisFactory getApiMRss]load:self selecter:@selector(disposMessage:) rssid:id] setShowLoading:NO];
            } else {
                [self load:self selecter:@selector(disposMessage:) rssid:id];
            }
            
        }
    }
}


-(UpdateOne*)load:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"rssid=%@",rssid==nil?@"":rssid]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MRssCancel" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
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

//
//  SubscribeVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SubscribeVC.h"
#import "SegmentView.h"
#import "SubscribeCell.h"
#import "MySubscribeCell.h"
#import "ZsndNews.pb.h"
#import "ZsndSystem.pb.h"
@interface SubscribeVC ()<UITableViewDataSource,UITableViewDelegate,RssDelegate>
@property (weak, nonatomic) IBOutlet SegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *mySubscribeTable;
@property (weak, nonatomic) IBOutlet UITableView *allSubscribeTable;
@property (strong,nonatomic)NSArray* segmentContents;
@property (strong,nonatomic)NSArray* mySubscribes;
@property (strong,nonatomic)NSArray* allSubscribes;

@end

@implementation SubscribeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"订阅"];
    [self setSubTitle:@"重要信息我都有"];
    self.segmentContents = [[NSArray alloc]initWithObjects:@"全部",@"我的订阅", nil];
    [self.segmentView setBackgroundColor:[UIColor clearColor]];
    [[ApisFactory getApiMMyRss]load:self selecter:@selector(disposMessage:)];
    [self waiting];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {

        if ([[son getMethod] isEqualToString:@"MMyRss"]) {
            //获得返回类
            MMyRssList_Builder *RssList = (MMyRssList_Builder *)[son getBuild];
            self.mySubscribes = RssList.listList;
            if (self.mySubscribes.count==0)
            {
                [self.segmentView setSelectedIndex:0];
                [[ApisFactory getApiMAllRss] load:self
                                         selecter:@selector(disposMessage:)];
            } else {
                [self.loginIndicator removeFromSuperview];
                [self.mySubscribeTable reloadData];
            }
        } else if ([[son getMethod] isEqualToString:@"MAllRss"]){
            [self.loginIndicator removeFromSuperview];
            MRssList_Builder *allRssList = (MRssList_Builder*)[son getBuild];
            self.allSubscribes = allRssList.listList;
            [self.allSubscribeTable reloadData];
            
        } else if ([[son getMethod]isEqualToString:@"MRss"]){
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            NSLog(@"code:%d msg%@",ret.code,ret.msg);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
{
    if (self.mySubscribeTable.isHidden){
        return self.allSubscribes.count;
    } else {
        return self.mySubscribes.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.mySubscribeTable) {
        SubscribeCell* cell = (SubscribeCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return 38+cell.newsView.frame.size.height;
    } else
        return 70;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.mySubscribeTable) {
        SubscribeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"subscribe"];
        
//        NSArray* news = [[NSArray alloc]initWithObjects:[[NSDictionary alloc]init],  [[NSDictionary alloc]init],[[NSDictionary alloc]init],nil];
        MMyRss* rss = [self.mySubscribes objectAtIndex:indexPath.row];
        [cell.typeLabel setText:rss.title];
        [cell addNews:rss.newsList];
        return cell;
    } else {
        MySubscribeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"mySubscribeCell"];
        MRss* rss = [self.allSubscribes objectAtIndex:indexPath.row];
        [cell.typeTitle setText:rss.title ];
        [cell.typeDetail setText:rss.content];
        [cell.imageView setImageWithURL:[ToolUtils getImageUrlWtihString:rss.img width:60 height:60]];
        [cell.subscribeSwitch setOn:rss.state==1];
        cell.id = rss.id;
        return cell;
    }
}


#pragma mark - segment delegate
- (NSInteger)numOfSegments
{
    return self.segmentContents.count;
}

- (NSInteger)defaultSelectedSegment
{
    return 1;
}

- (UIColor *)colorForLine
{
    return [UIColor colorWithRed:139 / 255.0 green:63 / 255.0 blue:138 / 255.0 alpha:1.0];
}

- (UIColor *)colorForTint
{
    return [UIColor whiteColor];
}

- (NSString *)segmentView:(SegmentView *)segmentView nameForSegment:(NSInteger)index
{
    return [self.segmentContents objectAtIndex:index];
}

- (void)selectSegmentAtIndex:(NSInteger)index
{
    if (index==1) {
        [self.mySubscribeTable setHidden:NO];
        [self.allSubscribeTable setHidden:YES];
//        [self.mySubscribeTable reloadData];
        [[ApisFactory getApiMMyRss]load:self selecter:@selector(disposMessage:)];
        [self waiting];
    } else {
        [self.mySubscribeTable setHidden:YES];
        [self.allSubscribeTable setHidden:NO];
        [[ApisFactory getApiMAllRss] load:self
                                 selecter:@selector(disposMessage:)];
//        [self.allSubscribeTable reloadData];
        
    }
}

#pragma mark -RssDelegate
- (void)changeState:(NSString *)id
{
    [[ApisFactory getApiMRss]load:self selecter:@selector(disposMessage:) rssid:id];
//    [[ApisFactory getApiMAllRss]load:self selecter:@selector(disposMessage:)];
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

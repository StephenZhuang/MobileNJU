//
//  ActivityVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityCell.h"
#import "ZsndNews.pb.h"
#import "ActivityDetailVC.h"
@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate,ActivityCellDelegate>
@property (nonatomic,strong)NSMutableArray* activityList;
@end

@implementation ActivityVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"活动"];
    [self setSubTitle:@"好吃好玩的福利"];
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)activityList
{
    if (!_activityList) {
        _activityList  = [[ NSMutableArray alloc]init];
    }
    
    return _activityList;
}

- (void)loadData
{
    [[[ApisFactory getApiMActivity] setPage:page pageCount:5]load:self selecter:@selector(disposMessage:)];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MActivity"]) {
            MNewsList_Builder* activities = (MNewsList_Builder*)[son getBuild];
            for (MNews* news in activities.newsList) {
                BOOL has = NO;
                for (MNews* currentNews in self.activityList) {
                    if ([news.id isEqualToString:currentNews.id]) {
//                        [self.activityList replaceObjectAtIndex:[self.activityList indexOfObject:news] withObject:currentNews];
                        has=YES;
                        break;
                    }
                }
                if (!has) {
                    [self.activityList addObject:news];
                }
            }
            if (page==1) {
                [self doneWithView:_header];
            } else {
                [self doneWithView:_footer];
            }

        }
    }
}

- (void)showAll:(NSURL *)url
{
    [self performSegueWithIdentifier:@"detail" sender:url];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail"]) {
        ActivityDetailVC* nextVC = (ActivityDetailVC*)segue.destinationViewController;
        nextVC.url = sender;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.activityList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell* cell = (ActivityCell*)[tableView dequeueReusableCellWithIdentifier:@"activity"];
    [cell setActivity:[[NSDictionary alloc]init]];
    cell.delegate = self;
    MNews* news  = [self.activityList objectAtIndex:indexPath.row];
    [cell.titleLabel setText:news.title];
    [cell.timeLabel setText:news.time];
    [cell.contentLabel setText:news.content];
    cell.url = [NSURL URLWithString:news.url];
    
    return cell;
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

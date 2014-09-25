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
#import "UtilMethods.h"
@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate,ActivityCellDelegate>
@property (nonatomic,strong)NSMutableArray* activityList;
@property (nonatomic,strong)MNews* currentNew;
@property(nonatomic,strong)UIImage* currentImg;
@end

@implementation ActivityVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"活动"];
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)activityList
{
    if (!_activityList) {
        _activityList  = [[ NSMutableArray alloc]init];
    }
    return _activityList;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([ToolUtils showActivity]) {
        MNews_Builder* focus = [[MNews_Builder alloc]init];
        NSDictionary* pushNews = [ToolUtils showActivity];
        focus.title = [pushNews objectForKey:@"title"];
        focus.source = [pushNews objectForKey:@"source"];
        focus.img = [pushNews objectForKey:@"img"];
        focus.url = [pushNews objectForKey:@"url"];
        [self performSegueWithIdentifier:@"detail" sender:focus.build];
        [ToolUtils setShowActivity:nil];
    }
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
    } else {
        [super disposMessage:son];
    }
}
- (void) viewWillAppear: (BOOL)inAnimated {
    [super viewWillAppear:inAnimated];
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected)
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
}

- (void)showAll:(MNews *)news img:(UIImage *)img
{
    self.currentImg = img;
    [self performSegueWithIdentifier:@"detail" sender:news];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail"]) {
        ActivityDetailVC* nextVC = (ActivityDetailVC*)segue.destinationViewController;
        nextVC.currentNew = sender;
        MNews* new = (MNews*)sender;
        nextVC.img = self.currentImg;
        nextVC.url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://s1.smartjiangsu.com:89/%@",new.url]];
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
//    [cell.imageView setImageWithURL:[UtilMethods getImageUrlWtihString:news.img width:267 height:140]];
    [cell setImageName:news.img];
    cell.currentNew = news;
    NSLog(@"%f   %f",cell.imageView.center.x,cell.center.x);
    CGPoint center = cell.imageView.center;
    center.x = cell.center.x;
    cell.imageView.center = center;
    cell.url =     [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://s1.smartjiangsu.com:89/%@",news.url]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell* cell = (ActivityCell*) [self.tableView cellForRowAtIndexPath:indexPath];
    self.currentImg = cell.imgView.image;
    [self performSegueWithIdentifier:@"detail" sender:cell.currentNew];
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

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
@interface SubscribeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet SegmentView *segmentView;
@property (strong,nonatomic)NSArray* segmentContents;
@end

@implementation SubscribeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"订阅"];
    [self setSubTitle:@"重要信息我都有"];
    self.segmentContents = [[NSArray alloc]initWithObjects:@"全部",@"我的订阅", nil];
    [self.segmentView setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeCell* cell = (SubscribeCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return 36+cell.newsView.frame.size.height;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"subscribe"];
    NSArray* news = [[NSArray alloc]initWithObjects:[[NSDictionary alloc]init],  [[NSDictionary alloc]init],[[NSDictionary alloc]init],nil];
    [cell addNews:news];
    return cell;
}


#pragma mark - segment delegate
- (NSInteger)numOfSegments
{
    return self.segmentContents.count;
}

- (NSInteger)defaultSelectedSegment
{
    return 0;
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

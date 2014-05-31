//
//  ActivityVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ActivityVC.h"
#import "ActivityCell.h"
@interface ActivityVC ()<UITableViewDataSource,UITableViewDelegate,ActivityCellDelegate>

@end

@implementation ActivityVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"活动"];
    [self setSubTitle:@"好吃好玩的福利"];
    // Do any additional setup after loading the view.
}

- (void)showAll:(NSURL *)url
{
    [self performSegueWithIdentifier:@"detail" sender:nil];
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
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell* cell = (ActivityCell*)[tableView dequeueReusableCellWithIdentifier:@"activity"];
    [cell setActivity:[[NSDictionary alloc]init]];
    cell.delegate = self;
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

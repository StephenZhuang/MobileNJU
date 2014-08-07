//
//  TopicListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-8-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TopicListViewController.h"
#import "TreeHoleListViewController.h"

@interface TopicListViewController ()

@end

@implementation TopicListViewController

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
    self.title = @"话题";
    self.dataArray = [ToolUtils sharedToolUtils].tagArray;
}

- (void)addHeader{}
- (void)addFooter{}
- (void)loadData{}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return 2;
    }
    if (_selectTagBlock) {
        return self.dataArray.count + 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        return 0.01;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        if (indexPath.row == 0) {
            [cell.imageView setImage:[UIImage imageNamed:@"ic_treehole_recommend"]];
            [cell.textLabel setText:@"推荐"];
        } else {
            [cell.imageView setImage:[UIImage imageNamed:@"ic_treehole_hot"]];
            [cell.textLabel setText:@"热门"];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (_selectTagBlock) {
            if (indexPath.row == 0) {
                [cell.textLabel setText:@"无话题"];
                [cell.textLabel setTextColor:RGB(168, 16, 166)];
            } else {
                MTag *tag = [self.dataArray objectAtIndex:indexPath.row - 1];
                [cell.textLabel setText:[NSString stringWithFormat:@"#%@",tag.title]];
                [cell.textLabel setTextColor:RGB(87, 87, 87)];
            }
        } else {
            MTag *tag = [self.dataArray objectAtIndex:indexPath.row];
            [cell.textLabel setText:[NSString stringWithFormat:@"#%@",tag.title]];
            [cell.textLabel setTextColor:RGB(87, 87, 87)];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        MTag_Builder *tag = [MTag_Builder new];
        if (indexPath.row == 0) {
            [tag setTitle:@"推荐"];
            [tag setId:@"推荐"];
        } else {
            [tag setTitle:@"热门"];
            [tag setId:@"热门"];
        }
        TreeHoleListViewController *vc = [[self storyboard] instantiateInitialViewController];
        vc.mtag = tag.build;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        if (_selectTagBlock) {
            if (indexPath.row == 0) {
                _selectTagBlock(nil);
            } else {
                _selectTagBlock(self.dataArray[indexPath.row - 1]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            MTag *tag = [[ToolUtils sharedToolUtils].tagArray objectAtIndex:indexPath.row];
            TreeHoleListViewController *vc = [[self storyboard] instantiateInitialViewController];
            vc.mtag = tag;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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

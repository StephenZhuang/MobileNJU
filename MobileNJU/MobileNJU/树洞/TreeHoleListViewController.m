//
//  TreeHoleListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleListViewController.h"
#import "TreeHoleCell.h"

@interface TreeHoleListViewController ()

@end

@implementation TreeHoleListViewController

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
    [self setSubTitle:@"吐槽您的生活"];
    if (_isMyTreeHole) {
        [self setTitle:@"我的树洞"];
        [_myTreeHoleButton setHidden:YES];
//        [_messageButton setCenter:CGPointMake(self.view.center.x, _messageButton.center.y)];
        [_messageButton setFrame:CGRectMake(100, 8, 100, 30)];
    } else {
        [self setTitle:@"树洞"];
    }
}

- (IBAction)goToMine:(id)sender
{
    UIStoryboard *storyboard = [self storyboard];
    TreeHoleListViewController *vc = [storyboard instantiateInitialViewController];
    vc.isMyTreeHole = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"http://img0.bdstatic.com/img/image/shouye/dengni36.jpg",@"http://imgt8.bdstatic.com/it/u=2,3094647973&fm=19&gp=0.jpg",@"http://imgt8.bdstatic.com/it/u=2,3096148905&fm=19&gp=0.jpg", nil];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
    [cell setImageArray:array];
    return CGRectGetMaxY(cell.zanButton.frame) + 10;
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"http://img0.bdstatic.com/img/image/shouye/dengni36.jpg",@"http://img0.bdstatic.com/img/image/shouye/mnwlmn-9569205918.jpg",@"http://img0.bdstatic.com/img/image/shouye/mvznns.jpg",@"http://img0.bdstatic.com/img/image/shouye/fsfss001.jpg", nil];
    [cell setImageArray:array];
    if (_isMyTreeHole) {
        [cell.deleteButton setHidden:NO];
    } else {
        [cell.deleteButton setHidden:YES];
    }
    return cell;
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

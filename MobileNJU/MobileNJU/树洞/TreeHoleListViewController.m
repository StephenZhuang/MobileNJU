//
//  TreeHoleListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleListViewController.h"
#import "TreeHoleCell.h"
#import "ZsndTreehole.pb.h"
#import "NSString+unicode.h"
#import "ZsndIndex.pb.h"

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
    } else {
        [self setTitle:@"树洞"];
    }
    
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 53, 28);
    button.frame = frame;
    [button addTarget:self action:@selector(goToAdd) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* releaseItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = releaseItem;
}

- (void)goToAdd
{
    [self performSegueWithIdentifier:@"add" sender:nil];
}

- (void)loadData
{
    NSString *beginStr = @"";
    if (page == 1) {
        beginStr = @"";
    } else {
        if (self.dataArray.count > 0) {
            MTopic *topic = [self.dataArray lastObject];
            beginStr = topic.createTime;
        }
        
    }
    [[ApisFactory getApiMTreeHoleList] load:self selecter:@selector(disposMessage:) type:_isMyTreeHole?1:0 begin:beginStr];
    
    if (page == 1) {
        [[ApisFactory getApiMUnreadModule] load:self selecter:@selector(disposMessage:)];
    }
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MTreeHoleList"]) {
            MTreeHole_Builder *treeHole = (MTreeHole_Builder *)[son getBuild];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:treeHole.topicsList];
        } else if ([[son getMethod] isEqualToString:@"MUnreadModule"]) {
            m
        }
    }
    if (page == 1) {
        [self doneWithView:_header];
    } else {
        [self doneWithView:_footer];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
    MTopic *topic = [self.dataArray objectAtIndex:indexPath.row];
    [cell.contentLabel setText:[topic.content replaceUnicode]];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *imgStrArr = [topic.imgs componentsSeparatedByString:@","];
    
    for (NSString *str in imgStrArr) {
        [array addObject:[ToolUtils getImageUrlWtihString:str].absoluteString];
    }
    
//    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"http://img0.bdstatic.com/img/image/shouye/dengni36.jpg",@"http://imgt8.bdstatic.com/it/u=2,3094647973&fm=19&gp=0.jpg",@"http://imgt8.bdstatic.com/it/u=2,3096148905&fm=19&gp=0.jpg", nil];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
    [cell setImageArray:array];
    return CGRectGetMaxY(cell.zanButton.frame) + 10;
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
    
    MTopic *topic = [self.dataArray objectAtIndex:indexPath.row];
    [cell.titleLabel setText:[topic.title replaceUnicode]];
    [cell.contentLabel setText:[topic.content replaceUnicode]];
    [cell.timeLabel setText:topic.time];
    [cell.zanButton setTag:indexPath.row];
    [cell.commentButton setTag:indexPath.row];
    [cell.zanButton setTitle:[NSString stringWithFormat:@"%i" , topic.praiseCnt] forState:UIControlStateNormal];
    [cell.commentButton setTitle:[NSString stringWithFormat:@"%i" , topic.commentCnt] forState:UIControlStateNormal];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *imgStrArr = [topic.imgs componentsSeparatedByString:@","];
    
    for (NSString *str in imgStrArr) {
        [array addObject:[ToolUtils getImageUrlWtihString:str].absoluteString];
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"myTreeHole"]) {
        TreeHoleListViewController *vc = [segue destinationViewController];
        vc.isMyTreeHole = YES;
    }
}


@end

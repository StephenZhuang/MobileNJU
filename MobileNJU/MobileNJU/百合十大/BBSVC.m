//
//  BBSVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BBSVC.h"
#import "BBSDetail.h"
#import "BBSCell.h"
#import "ZsndNews.pb.h"
@interface BBSVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray* colorArray;
@property (nonatomic,strong)NSArray* newsList;
@property (nonatomic)int refreshCount;
@end


@implementation BBSVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshCount = 0;
    [self setTitle:@"贴吧十大"];
    self.colorArray = [[NSArray alloc]initWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十", nil];
    
    // Do any additional setup after loading the view.
//    [self waiting];
//    [[ApisFactory getApiMBaiheNewsList] load:self selecter:@selector(disposMessage:)];
    
}

- (void) viewWillAppear: (BOOL)inAnimated {
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected)
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [[ApisFactory getApiMBaiheNewsList] load:self selecter:@selector(disposMessage:)];
}
- (void)addFooter
{
    
}
#pragma - mark api回调
- (void)disposMessage:(Son *)son
{
//    [self.loginIndicator removeFromSuperview];
    if ([son getError] == 0) {
        //判断接口名
        if ([[son getMethod] isEqualToString:@"MBaiheNewsList"]) {
            self.refreshCount ++;
            MNewsList_Builder* list = (MNewsList_Builder*)[son getBuild];
            self.newsList = list.newsList;
            [self doneWithView:_header];
        }
    } else {
        [super disposMessage:son];
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


#pragma mark -table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count==0?0:10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSCell* cell ;
    if (indexPath.row==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"first"];

    } else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"other"];
    }
       cell.Content.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.Content.layer.borderWidth=1.0;
    cell.Content.layer.cornerRadius=5.0;
    [cell.idImage setImage:[UIImage imageNamed:[self.colorArray objectAtIndex:indexPath.row]]];
    MNews* new = [self.newsList objectAtIndex:indexPath.row];
    [cell.titleLabel setText:new.title];
    [cell.commentCountLabel setText:[NSString stringWithFormat:@"%d",new.comment]];
    [cell.authorLabel setText:new.author];
    cell.url = new.url;
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.refreshCount>1) {
        return;
    } else {
        BBSCell* bbsCell = (BBSCell*)cell;
        bbsCell.Content.transform = CGAffineTransformMakeTranslation(300, 0);
        [UIView animateWithDuration:0.3 delay:indexPath.row*0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            bbsCell.Content.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];

    }
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"bbsDetail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"bbsDetail"]) {
        BBSDetail* detail = (BBSDetail*)segue.destinationViewController;
        MNews* new = [self.newsList objectAtIndex:((NSIndexPath*)sender).row];
        NSURL* url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@",new.url]];
        [detail setUrl:url];
    }
}
@end

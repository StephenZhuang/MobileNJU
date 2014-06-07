//
//  BBSVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BBSVC.h"
#import "BBSCell.h"
#import "ZsndSystem.pb.h"
@interface BBSVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray* colorArray;
@end

@implementation BBSVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"百合十大"];
    [self setSubTitle:@"显示南大每天十条新闻"];
    self.colorArray = [[NSArray alloc]initWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十", nil];
    // Do any additional setup after loading the view.
    [[ApisFactory getApiMBaiheNewsList] load:self selecter:@selector(disposMessage:)];

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma - mark api回调
- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        //判断接口名
        if ([[son getMethod] isEqualToString:@"MBaiheNewsList"]) {
            //获得返回类
            
        }
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
- (IBAction)goToDetail:(id)sender {
    [self performSegueWithIdentifier:@"bbsDetail" sender:sender];
}
#pragma mark -table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BBSCell* bbsCell = (BBSCell*)cell;
    bbsCell.Content.transform = CGAffineTransformMakeTranslation(300, 0);
    [UIView animateWithDuration:0.3 delay:indexPath.row*0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        bbsCell.Content.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];

}

@end

//
//  AllRssVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AllRssVC.h"
#import "MySubscribeCell.h"
@interface AllRssVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AllRssVC

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
    [self setTitle:@"全部订阅"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning  todo
- (void)loadData
{
    [self disposMessage:nil];
}
- (void)disposMessage:(Son *)son
{
    [self doneWithView:_header];
}

#pragma -mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allRss" forIndexPath:indexPath];
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

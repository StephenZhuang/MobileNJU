//
//  RSSVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-28.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RSSVC.h"
#import "subscribeCell_n.h"
@interface RSSVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray* myRss;
@end

@implementation RSSVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)backToMain
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)gotoAll
{
    [self performSegueWithIdentifier:@"all" sender:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"订阅"];
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    NSString *iconname=DEFAULTBACKICON;
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_n",iconname]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",iconname]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(gotoAll) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
    [self.navigationItem setRightBarButtonItem:myAddButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning 此处暂时伪造下数据
- (void)loadData
{
    [self disposMessage:nil];
}

- (void)disposMessage:(Son *)son
{
    
    
    [self doneWithView:_header];
}


#pragma mark -tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    subscribeCell_n *cell = [tableView dequeueReusableCellWithIdentifier:@"Rss" forIndexPath:indexPath];
    
    return cell;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"list" sender:@"考试宝典"];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"list"]) {
        UIViewController* controller = (UIViewController*)[segue destinationViewController];
        [controller setTitle:sender];
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

@end

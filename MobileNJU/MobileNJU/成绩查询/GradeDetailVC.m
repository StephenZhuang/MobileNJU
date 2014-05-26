//
//  GradeDetailVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GradeDetailVC.h"
#import "GradeCell.h"
#import "GPAView.h"
#import "GPAClose.h"
@interface GradeDetailVC ()<UITableViewDelegate,UITableViewDataSource,GPAClose>
@property (nonatomic,strong)GPAView* gpaView;
@end

@implementation GradeDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    self.gpaView = [[[NSBundle mainBundle] loadNibNamed:@"GPAView" owner:self options:nil] firstObject];
    [self.gpaView setFrame:CGRectMake(30, 50, 260, 200)];
    [self.view addSubview:self.gpaView];
    [self.gpaView setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)initNavigationBar
{
    [self setTitle:@"成绩查询"];
    [self setSubTitle:@"看看有没有挂科"];
    UIBarButtonItem* selfItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"self_right_barButton"] style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
    [selfItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfItem;
}

- (IBAction)calculateGpa:(id)sender {
    [self.gpaView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

- (void)closeAlert{
    [self cancelAlert:nil];
}

- (IBAction)cancelAlert:(id)sender {
    [self.gpaView setHidden:YES];
    [super cancelAlert:sender];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#warning 超过6个字符就要换行了
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"grade";
    GradeCell *cell = (GradeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell addLineForLabel];
    [cell addBorder];
    [cell.lessonNameLabel setText:@"aaaaaaaaaaaaaaaaaaa"];
    return cell;
}

@end

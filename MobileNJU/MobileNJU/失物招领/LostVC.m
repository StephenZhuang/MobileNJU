//
//  LostVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LostVC.h"
#import "SegmentView.h"
#import "LostCell.h"
@interface LostVC ()<UITableViewDelegate,UITableViewDataSource,SegmentViewDataSource,SegmentViewDelegate>
@property (nonatomic,strong)NSArray* segmentContents;
@end

@implementation LostVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    // Do any additional setup after loading the view.
}
- (void)initNavigationBar
{
    [self setTitle:@"失物招领"];
    [self setSubTitle:@"谁捡到我的手机"];
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"发布"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 53, 28);
    button.frame = frame;
    [button addTarget:self action:@selector(releaseInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* releaseItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = releaseItem;
    self.segmentContents = [[NSArray alloc]initWithObjects:@"捡到",@"丢失", nil];
}
- (void) releaseInfo
{
    [self performSegueWithIdentifier:@"release" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LostCell* cell = [tableView dequeueReusableCellWithIdentifier:@"lost"];
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

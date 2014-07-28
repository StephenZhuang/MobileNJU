//
//  ProcedureVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ProcedureVC.h"

@interface ProcedureVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ProcedureVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"办理流程"];
    [self loadContent];
    // Do any additional setup after loading the view.
}

-(void)loadContent
{
    self.procedureContents = [[NSArray alloc]initWithObjects:@"注销成绩",@"临时居住证明",@"申请寒暑假宿舍", nil];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.procedureContents.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"procedure"];
    [cell.textLabel setText:[self.procedureContents objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detail" sender:nil];
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

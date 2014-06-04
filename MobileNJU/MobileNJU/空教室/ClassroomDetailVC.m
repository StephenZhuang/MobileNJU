//
//  ClassroomDetailVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ClassroomDetailVC.h"
#import "ClassroomCell.h"
@interface ClassroomDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ClassroomDetailVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"空闲教师"];
    [self setSubTitle:@"为您找到地方自习，不受打扰"];
    
    [self loadData];
}

-(void)loadData
{
    self.floors = [[NSArray alloc]initWithObjects:@"1楼教室列表",@"2楼教室列表",@"3楼教室列表",@"4楼教室列表", nil];
    NSMutableArray* classrooms = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 4 ; i++){
        NSArray* c  = [[NSArray alloc]initWithObjects:@"201",@"201",@"201",@"201",@"201",@"201",@"201", nil];
        [classrooms addObject:c];
    }
    self.classrooms = [[NSDictionary alloc]initWithObjects:classrooms forKeys:self.floors];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classrooms.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassroomCell* cell = [tableView dequeueReusableCellWithIdentifier:@"floor"];
    
    [cell.floorLabel setText:[self.floors objectAtIndex:indexPath.row]];
    [cell addClassrooms:[self.classrooms objectForKey:[self.floors objectAtIndex:indexPath.row]]];
    return cell  ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger line = [[self.classrooms objectForKey:[self.floors objectAtIndex:indexPath.row]] count]/5+1;
    return 50.0+line*25.0;
;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
 
    // Configure the cell...
    
    return cell;
}
*/

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

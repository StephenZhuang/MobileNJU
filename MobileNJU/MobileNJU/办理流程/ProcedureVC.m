//
//  ProcedureVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ProcedureVC.h"
#import "ProcedureDetailVC.h"
#import "ZsndSystem.pb.h"
@interface ProcedureVC ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation ProcedureVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"办理流程"];
//    [self loadContent];
    
    // Do any additional setup after loading the view.
}
- (void) viewWillAppear: (BOOL)inAnimated {
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if(selected)
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
}

- (void)loadData
{
    [[[ApisFactory getApiMHelp] setPage:page pageCount:10] load:self selecter:@selector(disposMessage:)];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        NSLog(@"%@",[son getBuild].description);
    
        MContacts_Builder* ret = (MContacts_Builder*)[son getBuild];
        self.procedureContents = ret.contactList;
        NSLog(@"%d",ret.contactList.count);
        [self doneWithView:_header];
    }else {
        [super disposMessage:son];
    }

}

///**
// *  办理流程(分页) /mobile?methodno=MHelp&debug=1&deviceid=1&userid=&verify=&page=&limit=
// * @param delegate 回调类
// * @param select  回调函数
// * @callback MContacts_Builder
// */
//-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
//    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
//    [array addObject:[NSString stringWithFormat:@"page=%d",page]];
//    [array addObject:[NSString stringWithFormat:@"limit=10"]];
//    UpdateOne *updateone=[[UpdateOne alloc] init:@"MHelp" params:array  delegate:delegate selecter:select];
//    
//    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
//    return updateone;
//}


- (void)addFooter
{
    
}
//-(void)loadContent
//{
//    self.procedureContents = [[NSArray alloc]initWithObjects:@"注销成绩",@"临时居住证明",@"申请寒暑假宿舍", nil];
//
//}
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
    MContact* contact = [self.procedureContents objectAtIndex:indexPath.row];
    [cell.textLabel setText:contact.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ProcedureDetailVC* nextVC = (ProcedureDetailVC*)[segue destinationViewController];
    MContact* contact = [self.procedureContents objectAtIndex:((NSIndexPath*)sender).row];
    nextVC.title = contact.name;
    nextVC.url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://114.215.196.179/%@",contact.desc]];
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

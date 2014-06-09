//
//  TelephoneInfoVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-21.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "TelephoneInfoVC.h"
#import "DepartmentCell.h"
#import "PhoneNumCell.h"
#import "ZsndSystem.pb.h"
@interface TelephoneInfoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* dataArray;

}
@property (assign) BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@end

@implementation TelephoneInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 0;
    self.isOpen = NO;
    
    
    [self setTitle:@"部门电话"];
    [self setSubTitle:@"各个部门电话"];
    
}


/*
 从主页到新闻界面使用的model push 此处是直接回到主页
 sender = backbutton
 */
- (IBAction)returnToMain:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
- (void) loadData
{
    [[ApisFactory getApiMContacts]load:self selecter:@selector(disposMessage:)];
//    NSArray* keys = [[NSArray alloc]initWithObjects:@"name" ,@"list" ,nil];
//    for (int i = 0 ; i < 5 ; i ++){
//        NSMutableArray* list = [[NSMutableArray alloc]init];
//        for (int j = 0 ; j < 5; j++){
//            [list addObject:@"123456" ];
//        }
//        NSArray* value = [[NSArray alloc]initWithObjects:@"团委",list, nil];
//        NSDictionary* dic = [[NSDictionary alloc]initWithObjects:value forKeys:keys];
//        [dataArray addObject:dic];
//    }
}
- (void)addFooter
{
    
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
            if ([[son getMethod] isEqualToString:@"MContacts"]) {
                //获得返回类
                MContactList_Builder *contacts = (MContactList_Builder *)[son getBuild];
                NSLog(@"%@",contacts.name);
                NSLog(@"%d",contacts.contactList.count);
                
//                NSArray* keys = [[NSArray alloc]initWithObjects:@"name" ,@"list" ,nil];
//                for (MContactList* list in contacts.contactList) {
//                    NSArray* value = [[NSArray alloc]initWithObjects:list.name,list.contactList ,nil];
//                    NSDictionary* dic = [[NSDictionary alloc]initWithObjects:value forKeys:keys];
//                    [dataArray addObject:dic];
//                }
                [self doneWithView:_header];
            }
        }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source
/*
 section = 各个部门
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}


/*
 判断状态，开启or关闭 若关闭返回1 否则返回该section里的个数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[[dataArray objectAtIndex:section] objectForKey:@"list"] count]+1;;
        }
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        return 70;
    }else
    {
        return 48;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        static NSString *CellIdentifier = @"phone";
        PhoneNumCell *cell = (PhoneNumCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSArray *list = [[dataArray objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
        MContact* contact = [list objectAtIndex:indexPath.row-1];
        
        cell.locationLabel.text = contact.desc;
        cell.departmentLabel.text = contact.name;
        NSMutableString* str = [[NSMutableString alloc]init];
        for (NSString* each_phone in contact.phoneList) {
            [str appendString:each_phone];
            [str appendString:@" "];
        }
        cell.phoneLabel.text = str;
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"department";
        DepartmentCell *cell = (DepartmentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       
        NSString *name = [[dataArray objectAtIndex:indexPath.section] objectForKey:@"name"];
        cell.departmentLabel.text = name;
        [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
        return cell;
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }else
        {
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else
    {
       
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    DepartmentCell *cell = (DepartmentCell *)[self.tableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.tableView beginUpdates];
    
    NSInteger section = self.selectIndex.section;
    NSInteger contentCount = [[[dataArray objectAtIndex:section] objectForKey:@"list"] count];
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	
	[self.tableView endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
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

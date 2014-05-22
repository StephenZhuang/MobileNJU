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
@interface TelephoneInfoVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray* dataArray;

}
@property (weak, nonatomic) IBOutlet UITableView *phoneTableView;
@property (assign) BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@end

@implementation TelephoneInfoVC



- (IBAction)returnToMain:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    self.phoneTableView.sectionFooterHeight = 0;
    self.phoneTableView.sectionHeaderHeight = 0;
    self.isOpen = NO;
    
    
    [self setTitle:@"部门电话"];
    [self setSubTitle:@"各个部门电话"];
    [self loadData];
    
}
- (void) loadData
{
    NSArray* keys = [[NSArray alloc]initWithObjects:@"name" ,@"list" ,nil];
    for (int i = 0 ; i < 5 ; i ++){
        NSMutableArray* list = [[NSMutableArray alloc]init];
        for (int j = 0 ; j < 5; j++){
            [list addObject:@"123456" ];
        }
        NSArray* value = [[NSArray alloc]initWithObjects:@"团委",list, nil];
        NSDictionary* dic = [[NSDictionary alloc]initWithObjects:value forKeys:keys];
        [dataArray addObject:dic];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[[dataArray objectAtIndex:section] objectForKey:@"list"] count]+1;;
        }
    }
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
        cell.phoneLabel.text = [list objectAtIndex:indexPath.row-1];
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
    
    DepartmentCell *cell = (DepartmentCell *)[self.phoneTableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.phoneTableView beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = [[[dataArray objectAtIndex:section] objectForKey:@"list"] count];
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [self.phoneTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.phoneTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	
	[self.phoneTableView endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.phoneTableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.phoneTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
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

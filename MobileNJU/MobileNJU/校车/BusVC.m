//
//  BusVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BusVC.h"
#import "BusCell.h"
#import "SegmentView.h"
#import "ZsndSystem.pb.h"
@interface BusVC ()<UITableViewDelegate,UITableViewDataSource,SegmentViewDataSource,SegmentViewDelegate>
@property (weak, nonatomic) IBOutlet SegmentView *segmentView;
@property(strong,nonatomic) NSArray *segmentArray;
@property(strong,nonatomic)NSArray* busList;
@end

@implementation BusVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray *)busList
{
    if (!_busList) {
        _busList = [[NSArray alloc]init];
    }
    return _busList;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"校车"];
    [self setSubTitle:@"方便您的来回"];
    self.segmentArray = [[NSArray alloc]initWithObjects:@"仙林",@"鼓楼", nil];
    [self.segmentView setBackgroundColor:[UIColor clearColor]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [[[ApisFactory getApiMBusSearch]setPage:page pageCount:20]load:self selecter:@selector(disposMessage:) type:self.segmentView.selectedIndex?1:2];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MBusSearch"]) {
            MBusList_Builder* busList = (MBusList_Builder*)[son getBuild];
            if (page==1) {
                self.busList = busList.busList;
                [self doneWithView:_header];
            } else {
                NSMutableArray* array = [[NSMutableArray alloc]init];
                [array addObjectsFromArray:self.busList];
                [array addObjectsFromArray:busList.busList];
                self.busList = array;
                [self doneWithView:_footer];
            }
        }
    } else {
        [self doneWithView:page==1?_header:_footer];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // set header view colour
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 30)];
    UIImage* background = [UIImage imageNamed:@"bus_table_head"];
    UIImageView* backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 29)];
    [backgroundImage setImage:background];
    [headerView addSubview:backgroundImage];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.busList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bus";
    BusCell *cell = (BusCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MBus* bus = [self.busList objectAtIndex:indexPath.row];
    [cell.destinationLabel setText:bus.name];
    [cell.passLabel setText:bus.process];
    [cell.numbersLabel setText:[NSString stringWithFormat:@"%d",bus.count]];
    [cell.otherLabel setText:bus.info];
    [cell.startTimeLabel setText:bus.begin];
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}




#pragma mark - segment delegate
- (NSInteger)numOfSegments
{
    return self.segmentArray.count;
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
    return [self.segmentArray objectAtIndex:index];
}

- (void)selectSegmentAtIndex:(NSInteger)index
{
    page=1;
    [_header beginRefreshing];
//    [[[ApisFactory getApiMBusSearch]setPage:page pageCount:20]load:self selecter:@selector(disposMessage:) type:index==0?2:1];
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

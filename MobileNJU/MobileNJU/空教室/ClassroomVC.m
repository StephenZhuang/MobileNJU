//
//  ClassroomVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ClassroomVC.h"
#import "SegmentView.h"
#import "ClassroomChooseCell.h"
#import "ZsndSystem.pb.h"
#import "ClassroomDetailVC.h"
#define CHOOSEDAY 1
#define CHOOSESTART 2
#define CHOOSEEND 3
@interface ClassroomVC ()<SegmentViewDataSource,SegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet SegmentView *segmentView;
@property (strong,nonatomic)NSArray* segmentContents;
@property (weak, nonatomic) IBOutlet UITextField *dayField;
@property (weak, nonatomic) IBOutlet UITextField *startField;
@property (weak, nonatomic) IBOutlet UITextField *endField;
@property (nonatomic)NSInteger selectTag;
@property (weak, nonatomic) IBOutlet UITableView *chooseDayTable;
@property (weak, nonatomic) IBOutlet UITableView *chooseStartTable;
@property (weak, nonatomic) IBOutlet UITableView *chooseEndTable;
@property (strong,nonatomic)NSArray* day;
@property (strong,nonatomic)NSArray* classCount;

@end

@implementation ClassroomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"空闲教室"];
    [self setSubTitle:@"为您找到地方自习，不受打扰"];
    self.segmentContents = [[NSArray alloc]initWithObjects:@"仙1",@"仙2",@"逸夫楼",nil];
    self.day = [[NSArray alloc]initWithObjects:@"星期一", @"星期二",@"星期三",@"星期四",@"星期五", nil];
    self.classCount = [[NSArray alloc]initWithObjects:@"第一节", @"第二节", @"第三节", @"第四节", @"第五节", @"第六节", @"第七节", @"第八节", @"第九节", @"第十节", nil];
    [self initFieldBorder];
    // Do any additional setup after loading the view.
}
//- (double)searchStringInArray:(NSString*)str inArray:(NSArray*)array
//{
//    for (NSString* each_str in array) {
//        if ([each_str isEqualToString:str]) {
//            return [array indexOfObject:each_str];
//        }
//    }
//    
//    return -1;
//}
- (IBAction)search:(id)sender {
    [self waiting:@"正在搜素"];
    [[ApisFactory getApiMRoomSearch]load:self selecter:@selector(disposMessage:) type:self.segmentView.selectedIndex+1 day:[self.day indexOfObject:[self.dayField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]+1
                                   begin:[self.classCount indexOfObject:[self.startField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]+1
                                     end:[self.classCount indexOfObject:[self.endField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]+1];
//    [self performSegueWithIdentifier:@"search" sender:nil];
}
-(void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MRoomSearch"]) {
            MRoomList_Builder* roomList = (MRoomList_Builder*)[son getBuild];
            [self performSegueWithIdentifier:@"search" sender:roomList.roomList];
            
        }
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"search"]) {
        ClassroomDetailVC* nextVC = (ClassroomDetailVC*)segue.destinationViewController;
        nextVC.roomList = sender;
    }
    
}
- (IBAction)showDay:(id)sender {
    if (self.chooseDayTable.isHidden==NO) {
        [self.chooseDayTable setHidden:YES];
        return;
    }
    self.selectTag = CHOOSEDAY;

    [self.chooseDayTable reloadData];
    [self.chooseDayTable setHidden:NO];
    [self.chooseEndTable setHidden:YES];
    [self.chooseStartTable setHidden:YES];
    
}
- (IBAction)showStart:(id)sender {
    if (self.chooseStartTable.isHidden==NO) {
        [self.chooseStartTable setHidden:YES];
        return;
    }
    self.selectTag = CHOOSESTART;

    [self.chooseStartTable reloadData];
    [self.chooseDayTable setHidden:YES];
    [self.chooseEndTable setHidden:YES];
    [self.chooseStartTable setHidden:NO];
    
}
- (IBAction)showEnd:(id)sender {
    if (self.chooseEndTable.isHidden==NO) {
        [self.chooseEndTable setHidden:YES];
        return;
    }
    self.selectTag = CHOOSEEND;
    [self.chooseEndTable reloadData];
    [self.chooseDayTable setHidden:YES];
    [self.chooseEndTable setHidden:NO];
    [self.chooseStartTable setHidden:YES];
}
- (IBAction)hideAll:(id)sender {
    [self.chooseDayTable setHidden:YES];
    [self.chooseEndTable setHidden:YES];
    [self.chooseStartTable setHidden:YES];
}

- (void)initFieldBorder
{
    UIColor* color = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    self.dayField.layer.borderWidth=1;
    self.startField.layer.borderWidth=1;
    self.endField.layer.borderWidth=1;
    self.dayField.layer.borderColor = color.CGColor;
    self.startField.layer.borderColor = color.CGColor;
    self.endField.layer.borderColor = color.CGColor;
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.selectTag) {
        case CHOOSEDAY:
            return [self.day count];
        case CHOOSESTART:
            return [self.classCount count];
        case CHOOSEEND:
            
            for (int i = 0 ; i < self.classCount.count; i++){
                if ([[self.classCount objectAtIndex:i] isEqualToString:[self.startField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                    return self.classCount.count-i;
                }
            }
            return [self.classCount count];
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassroomChooseCell* cell = [tableView dequeueReusableCellWithIdentifier:@"day"];
    switch (self.selectTag) {
        case CHOOSEDAY:
            [cell.mainLabel setText:[self.day objectAtIndex:indexPath.row]];
            break;
        case CHOOSESTART:
            [cell.mainLabel setText:[self.classCount objectAtIndex:indexPath.row]];
            break;
        case CHOOSEEND:
            for (int i = 0 ; i < self.classCount.count; i++){
                if ([[self.classCount objectAtIndex:i] isEqualToString:[self.startField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                    [cell.mainLabel setText:[self.classCount objectAtIndex:indexPath.row+i]];
                    return cell;
                }
            }
            [cell.mainLabel setText:[self.classCount objectAtIndex:indexPath.row]];
            break;
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideAll:nil];
    switch (self.selectTag) {
        case CHOOSEDAY:
            [self.dayField setText:[NSString stringWithFormat:@"  %@",[self.day objectAtIndex:indexPath.row]]];
            break;
        case CHOOSESTART:
            [self.startField setText:[NSString stringWithFormat:@"  %@",[self.classCount objectAtIndex:indexPath.row]]];
            for (int i = 0; i<indexPath.row; i++) {
                if ([[self.classCount objectAtIndex:i] isEqualToString:[self.endField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                    [self.endField setText:self.startField.text];
                    break;
                }
            }
            break;
        case CHOOSEEND:
            for (int i = 0 ; i < self.classCount.count; i++){
                if ([[self.classCount objectAtIndex:i] isEqualToString:[self.startField.text stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                    [self.endField setText:[NSString stringWithFormat:@"  %@",[self.classCount objectAtIndex:indexPath.row+i]]];
                    return;
                }
            }
            [self.endField setText:[NSString stringWithFormat:@"  %@",[self.classCount objectAtIndex:indexPath.row]]];
            break;
        default:
            break;
    }

}
@end

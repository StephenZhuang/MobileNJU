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
#import "ZsndLost.pb.h"
#import "ToolUtils.h"
@interface LostVC ()<UITableViewDelegate,UITableViewDataSource,SegmentViewDataSource,SegmentViewDelegate>
@property (nonatomic,strong)NSArray* segmentContents;
@property (weak, nonatomic) IBOutlet SegmentView *segmentView;
@property (nonatomic,strong)NSMutableArray* lostList;
@property (nonatomic,strong)NSMutableArray* foundList;
@end

@implementation LostVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    self.lostList = [[NSMutableArray alloc]init];
    self.foundList = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
- (void) viewWillAppear:(BOOL)animated
{
    [_header beginRefreshing];
}
- (void)initNavigationBar
{
    [self setTitle:@"失物招领"];
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

- (void)loadData
{
    
    [[[ApisFactory getApiMLostAndFound]setPage:page pageCount:20]load:self selecter:@selector(disposMessage:)  type:self.segmentView.selectedIndex+1];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MLostAndFound"]) {
            MLostAndFoundList_Builder* list = (MLostAndFoundList_Builder*)[son getBuild];
            if (self.segmentView.selectedIndex==0) {
                for (MLostAndFound* new in list.lfList) {
                    BOOL has=NO;
                    for (MLostAndFound* each in self.foundList) {
                        if ([each.address isEqualToString:new.address]&&[each.time isEqualToString:new.time]&&[each.desc isEqualToString:new.desc]) {
                            has=YES;
                            break;
                        }
                    }
                    if (!has) {
                        [self.foundList addObject:new];
                    }
                }
                
                
            } else{
                for (MLostAndFound* new in list.lfList) {
                    BOOL has=NO;
                    for (MLostAndFound* each in self.lostList) {
                        if ([each.address isEqualToString:new.address]&&[each.time isEqualToString:new.time]&&[each.desc isEqualToString:new.desc]) {
                            has=YES;
                            break;
                        }
                    }
                    if (!has) {
                        [self.lostList addObject:new];
                    }
                }
            }
            if (page==1) {
                [self doneWithView:_header];
            } else {
                [self doneWithView:_footer];
            }
            
        }
    }
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
    [_header beginRefreshing];
}


#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentView.selectedIndex==0) {
        return self.foundList.count;
    } else {
        return self.lostList.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LostCell* cell = [tableView dequeueReusableCellWithIdentifier:@"lost"];
    MLostAndFound* each;
    if (self.segmentView.selectedIndex==0) {
       each = [self.foundList objectAtIndex:indexPath.row];
    } else {
        each = [self.lostList objectAtIndex:indexPath.row];
    }
    [cell.locationLabel setText:each.address];
    [cell.titleLabel setText:each.desc];
    [cell.contactAndDateLabel setText:[NSString stringWithFormat:@"/%@/%@",each.contact,each.time]];
    NSArray* imageList = each.imgList;
    if (imageList.count>0) {
        [cell.firstImage setImageWithURL:[ToolUtils getImageUrlWtihString:[imageList firstObject] width:60 height:60]];
    }
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

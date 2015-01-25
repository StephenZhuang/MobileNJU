//
//  NearUserVCViewController.m
//  MobileNJU
//
//  Created by luck-mac on 14/11/7.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NearUserVCViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface NearUserVCViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *man;
@property (nonatomic) double altitude;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic,strong)NSMutableArray* userList;
@property (nonatomic) BOOL hasLoad;
@end

@implementation NearUserVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _latitude = 0;
    _hasLoad = NO;
    _man = [[CLLocationManager alloc] init];
    if([_man locationServicesEnabled]){
        // 接收事件的实例
        _man.delegate = self;
        // 发生事件的的最小距离间隔（缺省是不指定）
        _man.distanceFilter = kCLDistanceFilterNone;
        // 精度 (缺省是Best)
        _man.desiredAccuracy = kCLLocationAccuracyBest;
        // 开始测量
        [_man startUpdatingLocation];
    }
    // Do any additional setup after loading the view.
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{

    // 取得经纬度
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    // 取得精度
    CLLocationAccuracy horizontal = newLocation.horizontalAccuracy;
    CLLocationAccuracy vertical = newLocation.verticalAccuracy;
    // 取得高度
    CLLocationDistance altitude = newLocation.altitude;
    // 取得时刻
    _latitude = latitude;
    _altitude = _altitude;
    _longitude = _longitude;
    if (!_hasLoad) {
        [self load:self selecter:@selector(disposMessage:) altitude:altitude longitude:longitude range:100 latitude:latitude page:page limit:pageCount];
        _hasLoad = YES;
    }
    // 以下面的格式输出 format: <latitude>, <longitude>> +/- <accuracy>m @ <date-time>
}

- (void)loadData
{
    if (_latitude) {
        [self load:self selecter:@selector(disposMessage:) altitude:_altitude longitude:_longitude range:100 latitude:_latitude page:page limit:pageCount];
    } else {
        [_header endRefreshing];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [_man stopUpdatingLocation];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        MCourseList_Builder* userList = (MCourseList_Builder*)[son getBuild];
        _userList = [[NSMutableArray alloc]initWithArray:userList.courseList];
        [self.tableView reloadData];
        if (page==1) {
            [_header endRefreshing];

        } else {
            [_footer endRefreshing];
        }
    }
}
/**
 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
 * @param delegate 回调类
 * @param select  回调函数
 * @param targetid * 聊天对象id
 * @param topicid * 树洞id
 * @callback MView_Builder
 */
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  altitude:(double) altitude longitude:(double)longitude range:(NSInteger) range latitude:(double) latitude page:(NSInteger)page limit:(NSInteger)limit{
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"altitude=%f",altitude]];
    [array addObject:[NSString stringWithFormat:@"longitude=%f",longitude]];
    [array addObject:[NSString stringWithFormat:@"range=%d",range]];
    [array addObject:[NSString stringWithFormat:@"latitude=%f",latitude]];
    [array addObject:[NSString stringWithFormat:@"page=%d",page]];
    [array addObject:[NSString stringWithFormat:@"limit=%d",limit]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MNearUser" params:array  delegate:delegate selecter:select];
    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:delegate];
    return updateone;
}

/**
 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
 * @param delegate 回调类
 * @param select  回调函数
 * @param targetid * 聊天对象id
 * @param topicid * 树洞id
 * @callback MView_Builder
 */



// 如果GPS测量失败了，下面的函数被调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
    MCourse* course = [_userList objectAtIndex:indexPath.row];
    [cell.textLabel setText:course.name];
    [cell.detailTextLabel setText:course.point];
    return  cell;
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

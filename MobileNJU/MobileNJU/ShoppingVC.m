//
//  ShoppingVC.m
//  CreateLesson
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import "ShoppingVC.h"
#import "ShoppingCell.h"
#import "ShoppingDetailVC.h"
#import "ZsndMarket.pb.h"
@interface ShoppingVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray* marketList;
@end

@implementation ShoppingVC

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
    self.marketList = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

-(void)startRefresh
{
    [self waiting:@"正在加载"];
    [self loadData];
//    [_header beginRefreshing];
}
- (void)addHeader
{
    
}
- (void)loadData
{
    [(ApiMMarketList*)[[ApisFactory getApiMMarketList] setPage:page pageCount:10]
     load:self selecter:@selector(disposMessage:) type:self.type];
//    [self load:self selecter:@selector(disposMessage:) type:self.type];
}

- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MMarketList"]) {
            MMarketList_Builder* list = (MMarketList_Builder*)[son getBuild];
            
            for (MMarket* market in list.marketList) {
                BOOL has = NO;
                for (MMarket* currentMarket in self.marketList) {
                    if ([currentMarket.id isEqualToString:market.id]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self.marketList addObject:market];
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
/**
// *
// * @param delegate 回调类
// * @param select  回调函数
// * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
// * @param sold * 0:全部列表    1：未售列表   2：已售列表
// * @callback MMarketList_Builder
// */
//-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(NSString*)type {
//    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
//    [array addObject:[NSString stringWithFormat:@"type=%@",type]];
//    [array addObject:[NSString stringWithFormat:@"page=%d",page]];
//    [array addObject:@"limit=10"];
//    UpdateOne *updateone=[[UpdateOne alloc] init:@"MMarketList" params:array  delegate:delegate selecter:select];
//    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
//    return updateone;
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.marketList.count;
}
#warning initConfig此处接口出现错误
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    MMarket* market = [self.marketList objectAtIndex:indexPath.row];
    UIImage* loading = [UIImage imageNamed:@"news_loading"];
    NSString* img = [[market.imgs componentsSeparatedByString:@","] firstObject];
    [cell.img setImageWithURL:[ToolUtils getImageUrlWtihString:img width:140 height:140] placeholderImage:loading];
    [cell.name setText:market.name==nil?@"":market.name];
    [cell.price setText:market.price==nil?@"":market.price];
    NSString* state = market.isSold==1?@"（已售）":@"";
    [cell.state setText:state];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"shop" bundle:nil];
    ShoppingDetailVC* vc = (ShoppingDetailVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"detail"]; //test2为viewcontroller的StoryboardId
    [self.myDelegate moveToDetail:vc];
}

@end

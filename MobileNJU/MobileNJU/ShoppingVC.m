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
#import "VerifyVC.h"
@interface ShoppingVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray* marketList;
@property(nonatomic,strong)MMarket* selectedMarket;
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

- (void)viewWillAppear:(BOOL)animated
{
    [self startRefresh];
}

-(void)startRefresh
{
    page=1;
    [self waiting:@"正在加载"];
    [self loadData];
//    [_header beginRefreshing];
}
- (void)addHeader
{
    
}
- (void)loadData
{
#warning API 更改
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
            if (page==1) {
                [self.marketList removeAllObjects];
                [self.marketList addObjectsFromArray:list.marketList];
                [self.tableView reloadData];
            } else {
                [self.marketList addObjectsFromArray:list.marketList];
                [self doneWithView:_footer];
            }
        }
    } 
    
        else {
        [super disposMessage:son];
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
    UIImage* loading = [UIImage imageNamed:@"280乘280"];
    NSString* img = [[market.imgs componentsSeparatedByString:@","] firstObject];
    [cell.img setImageWithURL:[ToolUtils getImageUrlWtihString:img width:280 height:280] placeholderImage:loading];
    [cell.name setText:market.name==nil?@"":market.name];
    [cell.price setText:[NSString stringWithFormat:@"%@元",market.price==nil?@"":market.price]];
    NSString* state = market.isSold==1?@"（已售）":@"";
    [cell.state setText:state];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([ToolUtils getIsVeryfy]==0) {
        [ToolUtils showMessage:@"请先验证身份"];
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
        VerifyVC* vc = (VerifyVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"verify"]; //test2为viewcontroller的StoryboardId
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:vc action:@selector(cancelVerify)];
        [item setTintColor:[UIColor whiteColor]];
        vc.navigationItem.rightBarButtonItem = item;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.myDelegate showView:nav];
//        [self presentViewController:nav animated:YES completion:nil];
    } else {
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"shop" bundle:nil];
        ShoppingDetailVC* vc = (ShoppingDetailVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"detail"]; //test2为viewcontroller的StoryboardId
        vc.market = [self.marketList objectAtIndex:indexPath.row];
        self.selectedMarket = [self.marketList objectAtIndex:indexPath.row];
        [self.myDelegate moveToDetail:vc];

    }
}

@end

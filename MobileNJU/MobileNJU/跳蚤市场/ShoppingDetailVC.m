//
//  ShoppingDetailVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ShoppingDetailVC.h"
#import "MarketDetailCell.h"
@interface ShoppingDetailVC ()<UIScrollViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (strong,nonatomic)UILabel* detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *downShelfBt;
@property (weak, nonatomic) IBOutlet UIButton *isSoldBt;
@property (strong,nonatomic)UIImageView* locationImg;
@property (weak, nonatomic) IBOutlet UIView *btView;
@end

@implementation ShoppingDetailVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"详情"];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled=YES;
    [self.pageControl addTarget:self action:@selector(pageChange:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self addDetail:self.market.description];
    if (![self.market.userid isEqualToString:[ToolUtils getLoginId]]) {
        [self addButton:@"联系买家"];
    } else {
        [self addButton:nil];
    }
    
    [self addLocation:self.market.address];
    [self loadNews];

}
-(void)addButton:(NSString*)state
{
    if (state==nil) {
        [self.btView setHidden:NO];
        if (self.market.isSold==1) {
            [self.isSoldBt setEnabled:NO];
        } 
    } else {
        CGRect frame = CGRectMake(10,self.detailLabel.frame.origin.y+self.detailLabel.frame.size.height+15+15+22 , 300, 40);
        UIButton* button = [[UIButton alloc]initWithFrame:frame];
        [button setBackgroundImage:[UIImage imageNamed:@"purpleButton"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"purpleButtonhighlighted"] forState:UIControlStateHighlighted];
        [self.footView addSubview:button];
        [button setTitle:state forState:UIControlStateNormal];
        [button addTarget:self action:@selector(contact) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    UIView* emptyView = [[UIView alloc]initWithFrame:CGRectMake(10,self.detailLabel.frame.origin.y+self.detailLabel.frame.size.height+15+15+22+40, 300, 40)];
    [self.footView addSubview:emptyView];
    
}

- (void)disposeMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0 ) {
        if ([[son getMethod]isEqualToString:@"MSoldMarket"]) {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            if (ret.code==1) {
                [ToolUtils showMessage:ret.msg];
                [self.isSoldBt setEnabled:NO];
            }
        } else if ([[son getMethod]isEqualToString:@"MDelMarket"])
        {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            if (ret.code==1) {
                [ToolUtils showMessage:ret.msg];
                [self.downShelfBt setEnabled:NO];
            }
        }
    }
}
    
    
- (void)contact
{
    
    UIActionSheet *sheet;
    // 判断是否支持相机
    sheet  = [[UIActionSheet alloc] initWithTitle:@"联系买家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:self.market.phone
              , [NSString stringWithFormat:@"QQ:%@",self.market.qq], nil];
    sheet.tag = 255;
    [sheet setDelegate:self];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSString* str = [NSString stringWithFormat:@"tel://%@",self.market.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    } else if (buttonIndex==1){
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.market.qq;
        [ToolUtils showMessage:@"已复制到您到剪切板"];
    }
}

- (void)addLocation:(NSString*)location
{
    CGRect frame = CGRectMake(30, self.locationImg.frame.origin.y, 200, 21);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:location];
    [self.footView addSubview:label];

}
- (void)addDetail:(NSString*)detail
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 21)];
    if (label) {
        // 设置文本内容
        label.text = detail;
        // 0代表不限制行数
        [label setNumberOfLines:0];
        // 因为行数不限制，所以这里在宽度不变的基础上(实际宽度会略为缩小)，高度会自动扩充
        [label sizeToFit];
        [self.footView addSubview:label];
    }
    [label setTextColor:[UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:1]];
    self.detailLabel = label;
    CGRect frame = label.frame;
    frame.origin.y = frame.origin.y+frame.size.height+15;
    frame.size = CGSizeMake(17, 22);
    UIImageView* locationImg  = [[UIImageView alloc]initWithFrame:frame];
    [locationImg setImage:[UIImage imageNamed:@"10跳蚤市场-详情-location"]];
    [self.footView addSubview:locationImg];
    self.locationImg = locationImg;
    
}

- (void)loadNews
{
    NSArray* photoList = [self.market.imgs componentsSeparatedByString:@","];
    NSInteger pageCount = [photoList count];
    [self.scrollView setPagingEnabled:YES];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    CGSize pageScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pageScrollViewSize.width * photoList.count, pageScrollViewSize.height);
    for (NSInteger i = 0; i<pageCount; i++)
    {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        UIImageView *pageView = [[UIImageView alloc]initWithFrame:frame];
        [pageView setImageWithURL:[ToolUtils getImageUrlWtihString:[photoList objectAtIndex:i] width:320 height:320] placeholderImage:[UIImage imageNamed:@"news_loading"]];
        pageView.contentMode = UIViewContentModeScaleAspectFit;
        [pageView setClipsToBounds:YES];
        [self.scrollView addSubview:pageView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.scrollView) {
        int index=scrollView.contentOffset.x/scrollView.frame.size.width;
        self.pageControl.currentPage=index;
    }
}




-(void)pageChange:(UIPageControl *)sender{
    CGFloat offset= self.pageControl.currentPage*320;
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"market" forIndexPath:indexPath];
    
    [cell.nameLabel setText:self.market.name];
    [cell.priceLabel setText:[NSString stringWithFormat:@"%@元",self.market.price]];
    [cell.originPriceLabel setText:[NSString stringWithFormat:@"%@元",self.market.priceOriginal]];
    
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)downShelf:(id)sender {
    [self loadShelf:self selecter:@selector(disposeMessage:) rssid:self.market.id];
}
- (IBAction)setIsSold:(id)sender {
    [self loadSold:self selecter:@selector(disposeMessage:) rssid:self.market.id];
}

-(UpdateOne*)loadShelf:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid {
    [self waiting:@"正在处理"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"id=%@",rssid==nil?@"":rssid]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MDelMarket" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}

-(UpdateOne*)loadSold:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid {
    [self waiting:@"正在处理"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"id=%@",rssid==nil?@"":rssid]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MSoldMarket" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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

//
//  NewsListTVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "NewsListTVC.h"
#import "NewsDetailVC.h"
#import "NewsCell.h"
#import "ZsndNews.pb.h"
@interface NewsListTVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray* newsList;
@end

@implementation NewsListTVC
#pragma viewController

- (IBAction)backToMain:(UIBarButtonItem *)sender {
    if (self.jump) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    [self setTitle:@"新 闻"];
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    NSString *iconname=DEFAULTBACKICON;
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_n",iconname]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",iconname]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
//    self.currentUrl = self.navigationController.title;
    if (self.jump) {
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }
    
}
- (NSMutableArray *)newsList
{
    if (!_newsList) {
        _newsList = [[NSMutableArray alloc]init];
    }
    return _newsList;
}
- (void)loadData
{
    [[[ApisFactory getApiMNewsList]setPage:page pageCount:10]load:self selecter:@selector(disposMessage:)];
}
- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MNewsList"]) {
            //获得返回类
            MNewsList_Builder *newsList = (MNewsList_Builder *)[son getBuild];
            for (MNews* news in newsList.newsList) {
                BOOL has = NO;
                for (MNews* currentNews in self.newsList) {
                    if ([news.id isEqualToString:currentNews.id]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self.newsList addObject:news];
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

//       // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail"]) {
        NewsDetailVC* destinationVC = (NewsDetailVC*)segue.destinationViewController;
        NSURL* url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://114.215.196.179/%@",self.currentUrl]];
        NSLog(@"设置的网址%@",self.currentUrl);
        [destinationVC setUrl:url];
        [destinationVC setImg:self.currentImg];
        [destinationVC setCurrentNew:self.currentNew];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return [self.newsList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MNews* new = [self.newsList objectAtIndex:indexPath.row];
    self.currentUrl = new.url;
    self.currentNew = new;
    NewsCell* cell  =(NewsCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    self.currentImg=cell.newsImage.image;
    [self performSegueWithIdentifier:@"detail" sender:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news" forIndexPath:indexPath];
    MNews* new = [self.newsList objectAtIndex:indexPath.row];
    cell.title = new.title;
    cell.type = new.source;
    cell.detail = new.content;
    cell.date = new.time;
    cell.imageName = new.img;
    NSLog(@"imageName%@",new.img);
    return cell;
}





#pragma mark - Navigation


@end

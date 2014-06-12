//
//  SelfInfoVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SelfInfoVC.h"
#import "SelfCell.h"
#import "ToolUtils.h"
#import "ZsndUser.pb.h"

@interface SelfInfoVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;
@end

@implementation SelfInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
    [self.infoTable reloadData];
    [[ApisFactory getApiMGetUserInfo]load:self selecter:@selector(disposMessage:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [ToolUtils setIsLogin:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        //判断接口名
        if ([[son getMethod] isEqualToString:@"MGetUserInfo"]) {
            //获得返回类
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            [ToolUtils setBelong:user.belong==nil?@"":user.belong];
            [ToolUtils setBirthday:user.birthday==nil?@"":user.birthday];
            [ToolUtils setNickname:user.nickname==nil?@"":user.nickname];
            switch (user.sex) {
                case 0:
                    [ToolUtils setSex:@"女"];
                    break;
                case 1:
                    [ToolUtils setSex:@"男"];
                    break;
                case 2:
                    [ToolUtils setSex:@"未知"];
                    break;
                default:
                    break;
            }
            self.flowerCount = user.flower;
            NSMutableString* tagsString = [[NSMutableString alloc]init];
            for (int i = 0 ; i < user.tagsList.count-1; i++)
            {
                [tagsString appendString:[user.tagsList objectAtIndex:i]];
                [tagsString appendString:@";"];
            }
            [tagsString appendString:[user.tagsList lastObject]];
            [ToolUtils setTags:tagsString];
            [self loadData];
            [self.infoTable reloadData];
            [ToolUtils setFlowerCount:user.flower];
            [self.flowerLabel setText:[NSString stringWithFormat:@"%d",self.flowerCount]];
        }
    }

}

- (IBAction)backToMain:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




#pragma toDo
- (void)loadData
{
    [self.flowerLabel setText:[NSString stringWithFormat:@"%d",[ToolUtils getFlowerCount]]];
    NSArray* keys = [[NSArray alloc]initWithObjects:@"image", @"content",nil];
    NSArray* images = [[NSArray alloc]initWithObjects:@"institute",@"sex",@"birth",@"hobby", nil];
    NSArray* content = [[NSArray alloc]initWithObjects:
                        [ToolUtils getBelong]==nil?@"":[ToolUtils getBelong],
                        [ToolUtils getSex]==nil?@"":[ToolUtils getSex],
                        [ToolUtils getBirthday]==nil?@"":[ToolUtils getBirthday],
                        [ToolUtils getTags]==nil?@"":[ToolUtils getTags], nil];
    NSMutableArray* mutableArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < images.count; i++)
    {
        NSArray* rows = [[NSArray alloc]initWithObjects:[images objectAtIndex:i],[content objectAtIndex:i], nil];
        NSDictionary* dic = [[NSDictionary alloc]initWithObjects:rows forKeys:keys];
        [mutableArray addObject:dic];
    }
    self.infos = [[NSArray alloc]initWithArray:mutableArray];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infos count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"self";
    SelfCell *cell = (SelfCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *imageName = [[self.infos objectAtIndex:indexPath.row] objectForKey:@"image"];
    [cell setImageName:imageName];
    NSString* content = [[self.infos objectAtIndex:indexPath.row]objectForKey:@"content"];
    [cell setContent:content];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

@end

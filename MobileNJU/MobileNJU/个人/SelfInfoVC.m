//
//  SelfInfoVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SelfInfoVC.h"
#import "SelfCell.h"
@interface SelfInfoVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;
@end

@implementation SelfInfoVC
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
    
    NSArray* keys = [[NSArray alloc]initWithObjects:@"image", @"content",nil];
    NSArray* images = [[NSArray alloc]initWithObjects:@"institute",@"sex",@"birth",@"hobby", nil];
    NSArray* contents = [[NSArray alloc]initWithObjects:@"南京大学－中文系",@"男",@"1986-08-05",@"绘画、书法", nil];
    NSMutableArray* mutableArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 4 ; i ++){
        NSArray* values = [[NSArray alloc]initWithObjects:[images objectAtIndex:i],[contents objectAtIndex:i], nil];
        NSDictionary* dic = [[NSDictionary alloc]initWithObjects:values forKeys:keys];
        [mutableArray addObject:dic];
    }
    self.infos = [[NSArray alloc]initWithArray:mutableArray];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

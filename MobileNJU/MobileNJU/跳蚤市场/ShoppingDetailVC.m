//
//  ShoppingDetailVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ShoppingDetailVC.h"

@interface ShoppingDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (strong,nonatomic)UILabel* detailLabel;
@property (strong,nonatomic)UIImageView* locationImg;
@end

@implementation ShoppingDetailVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"详情"];
    [self addDetail:@"我真的很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长"];
    
    [self addButton:@"联系买家"];
    [self addLocation:@"仙林校区"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)addButton:(NSString*)state
{
    CGRect frame = self.detailLabel.frame;
    frame.origin.y = frame.origin.y + frame.size.height + 15+15+22;
    frame.size.height = 40;
    UIButton* button = [[UIButton alloc]initWithFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:@"purpleButton"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"purpleButtonhighlighted"] forState:UIControlStateHighlighted];

    [self.footView addSubview:button];
    
    [button setTitle:state forState:UIControlStateNormal];
    [button addTarget:self action:@selector(contact) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)contact
{
    NSLog(@"contact");
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9, 30, 280, 21)];
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

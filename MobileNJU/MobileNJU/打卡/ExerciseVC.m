//
//  ExerciseVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ExerciseVC.h"
#import "ExerciseCell.h"
@interface ExerciseVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *schIDText;
@property (weak, nonatomic) IBOutlet UISwitch *autoSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@end

@implementation ExerciseVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.alertView setHidden:YES];
    [self.maskView setHidden:YES];
    [self.schIDText setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextViewDelegate

#pragma mark 关于自定义的alertView
- (IBAction)closeAlertView:(id)sender {
    [self.alertView setHidden:YES];
    [self.maskView setHidden:YES];
    [self.schIDText resignFirstResponder];
}
- (IBAction)searchResult:(id)sender {
}

- (IBAction)showAlertView:(id)sender {
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
}

- (IBAction)backToMain:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // set header view colour
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 40)];
    UIImage* background = [UIImage imageNamed:@"tableHead"];
    UIImageView* backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 40)];
    [backgroundImage setImage:background];
    [headerView addSubview:backgroundImage];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exercise";
    ExerciseCell *cell = (ExerciseCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


@end

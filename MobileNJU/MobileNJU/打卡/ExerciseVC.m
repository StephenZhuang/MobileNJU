//
//  ExerciseVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ExerciseVC.h"
#import "ExerciseCell.h"
#import "ToolUtils.h"
#import "ZsndSystem.pb.h"
@interface ExerciseVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *schIdLabel;

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *schIDText;
@property (weak, nonatomic) IBOutlet UISwitch *autoSearch;

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (strong,nonatomic) NSArray* infoList;
@end

@implementation ExerciseVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.alertView setHidden:YES];
    [self.maskView setHidden:YES];
    [self.schIDText setDelegate:self];
    [self.schIDText setText:[ToolUtils getSchId]==nil?@"":[ToolUtils getSchId]];
    [self.schIdLabel setText:[ToolUtils getSchId]==nil?@"":[ToolUtils getSchId]];
    [self.nameLabel setText:[ToolUtils getUserName]==nil?@"":[ToolUtils getUserName]];
    [self.timeLabel setText:@"0"];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)search:(id)sender {
    if (self.schIDText.text.length!=9) {
        [self showAlert:@"请输入正确的9位学号"];
        return;
    }
    
   
    [_header beginRefreshing];
    
    
}
- (void)addFooter
{
    
}

- (void)loadData
{
   
    if ([self.schIDText.text isEqualToString:@""]) {
        [self doneWithView:_header];
    } else {
        [self waiting:@"正在查询"];
        [self closeAlertView:nil];
        [[ApisFactory getApiMSignInInfo]load:self selecter:@selector(disposMessage:) account:self.schIDText.text password:self.schIDText.text];
        [[ApisFactory getApiMSignInInDetail]load:self selecter:@selector(disposMessage:
                                                                         ) account:self.schIDText.text password:self.schIDText.text];
    }
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MSignInInfo"]) {
            self.OK=YES;
            [self.loginIndicator removeFromSuperview];
            MSignInList_Builder* list = (MSignInList_Builder*)[son getBuild];
            [self.timeLabel setText:[NSString stringWithFormat:@"%d",list.count]];
            [self.nameLabel setText:list.name];
            [self.schIdLabel setText:self.schIDText.text];
            if (self.autoSearch.isOn) {
                [ToolUtils setSchId:self.schIDText.text];
                [ToolUtils setUserName:list.name];
            } else {
                [ToolUtils setSchId:@""];
            }
        } else if ([[son getMethod]isEqualToString:@"MSignInInDetail"])
        {
            MSignInList_Builder* list = (MSignInList_Builder*)[son getBuild];
            self.infoList = list.busList;
            
            [self doneWithView:_header];
        }
        
    } else {
        [self doneWithView:_header];
        self.OK=YES;
        [self.loginIndicator removeFromSuperview];
    }
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
    return self.infoList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exercise";
    ExerciseCell *cell = (ExerciseCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MSignIn* record = [self.infoList objectAtIndex:indexPath.row];
    [cell.recordId setText:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    [cell.startTime setText:record.begin];
    [cell.endTime setText:record.end];
    [cell.date setText:record.time];
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

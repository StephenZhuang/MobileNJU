//
//  EcardVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "EcardVC.h"
#import "EcardCell.h"
@interface EcardVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *schIDText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeText;
@property (weak, nonatomic) IBOutlet UISwitch *autoSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIImageView *confirmCode;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property(strong,nonatomic)UIButton* selectedButton;
@end

@implementation EcardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)chooseDate:(id)sender {
    [self.pickerView setHidden:YES];
    [self.maskView setHidden:YES];
    NSDate *selected = [self.dataPicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    [self.selectedButton setTitle:destDateString forState:UIControlStateNormal];
    
}
- (IBAction)showDataPicker:(UIButton *)sender {
    self.selectedButton = sender;
    [self.pickerView setHidden:NO];
    [self.maskView setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.maskView setHidden:YES];
    
    [self.alertView setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 关于自定义的alertView
- (IBAction)closeAlertView:(id)sender {
    [self.passwordText resignFirstResponder];
    [self.schIDText resignFirstResponder];
    [self.confirmCode resignFirstResponder];
    [self.pickerView setHidden:YES];
    [self.alertView setHidden:YES];
    [self.maskView setHidden:YES];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ecard";
    EcardCell *cell = (EcardCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}


#pragma mark - Table view delegate

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

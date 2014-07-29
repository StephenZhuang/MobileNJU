//
//  EcardVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "EcardVC.h"
#import "EcardCell.h"
#import "ZsndSystem.pb.h"
#import "IQActionSheetPickerView.h"
@interface EcardVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,IQActionSheetPickerViewDelegate>
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
@property (weak, nonatomic) IBOutlet UILabel *ecardTitle;
@property (weak, nonatomic) IBOutlet UILabel *ecardDesc;
@property(strong,nonatomic)UIButton* selectedButton;
@property(strong,nonatomic)NSArray* detaiList;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.maskView setHidden:YES];
    
    [self.alertView setHidden:!([ToolUtils getEcardId]==nil)];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToMain:)];
    [self.ecardDesc addGestureRecognizer:singleTap];
    [self.ecardTitle addGestureRecognizer:singleTap];
    [self.schIDText setText:[ToolUtils getEcardId]==nil?@"":[ToolUtils getEcardId]];
    [self.passwordText setText:[ToolUtils getEcardPassword]==nil?@"":[ToolUtils getPassword]];
    [self getCode];
    // Do any additional setup after loading the view.
}

- (void)getCode
{
    [self load:self selecter:@selector(disposMessage:) code:nil account:@"1" password:@"1"];
}


-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    if (code!=nil) {
        [array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
    }
    [array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardInfo" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}

#warning  waiting for new Api
- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MCardInfo"]) {
       }
    }
}



- (IBAction)showDataPicker:(UIButton *)sender {
    self.selectedButton = sender;
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"请选择生日" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:6];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker showInView:self.view];
    [picker setDate:[NSDate date]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (self.view.window.frame.size.height==480) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -50);
            //    self.logoImage.center = CGPointMake(self.logoImage.center.x, 100);
        } completion:^(BOOL finished) {
        }];
    }

}

#pragma mark 关于自定义的alertView
- (IBAction)closeAlertView:(id)sender {
    [self.passwordText resignFirstResponder];
    [self.schIDText resignFirstResponder];
    [self.confirmCode resignFirstResponder];
    [self.pickerView setHidden:YES];
    [self.alertView setHidden:YES];
    [self.maskView setHidden:YES];
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
}
- (IBAction)searchResult:(id)sender {
    if ([self.schIDText.text isEqualToString:@""]) {
        [ToolUtils showMessage:@"请输入您的学号"];
    } else if ([self.passwordText.text isEqualToString:@""])
    {
        [ToolUtils showMessage:@"密码不得为空"];
    } else
    {
    }
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



#pragma mark IQActionSheetDelegate
- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:pickerView.date];
    [self.selectedButton setTitle:destDateString forState:UIControlStateNormal];

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

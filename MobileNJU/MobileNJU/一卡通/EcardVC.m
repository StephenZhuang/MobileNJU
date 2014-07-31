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
@property (weak, nonatomic) IBOutlet UILabel *ecardTitle;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;

@property(strong,nonatomic)UIButton* selectedButton;
@property(strong,nonatomic)NSArray* detaiList;
@property(nonatomic)int isV;
@property(nonatomic)int isRe;
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
    self.isRe=0;
    self.isV=0;
    [self.maskView setHidden:YES];
    
    [self.alertView setHidden:!([ToolUtils getEcardId]==nil)];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToMain:)];
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
    [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
    [array addObject:[NSString stringWithFormat:@"isV=%d",self.isV]];
    
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
            MCardList_Builder* cardList = (MCardList_Builder*)[son getBuild];
            if (cardList.cardList.count>0) {
                self.isRe=1;
                self.detaiList = cardList.cardList;
                [self.tableView reloadData];
            } else {
                [self.confirmCode setImage:[UIImage imageWithData:cardList.img]];
                self.isV=1;
            }

       } else if ([[son getMethod]isEqualToString:@"MCardHistory"])
       {
           
           MCardList_Builder* ret = (MCardList_Builder*)[son getBuild];
           NSMutableArray* tmp = [[NSMutableArray alloc]initWithArray:self.detaiList];
           for (MCard* newCard in ret.cardList) {
               int flag=0;
               for (MCard* card in tmp) {
                   if ([card.time isEqualToString:newCard.time]) {
                       flag=1;
                       break;
                   }
               }
               if (!flag) {
                   [tmp addObjectsFromArray:ret.cardList];
                   break;
               }
           }
           self.detaiList  = tmp;
           
           [self doneWithView:_footer];
       }
    }
}


- (void)loadData
{
    [self searchDetail:nil];
}

- (void)addHeader
{
    
}
- (IBAction)searchDetail:(id)sender {
    if (sender!=nil) {
        page=0;
    }
    NSString* startDate = self.startButton.titleLabel.text;
    NSString* endDate = self.endButton.titleLabel.text;
    [self load:self selecter:@selector(disposMessage:) begin:startDate end:endDate];
}
     
     /**
      *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
      * @param delegate 回调类
      * @param select  回调函数
      * @param begin * 起始
      * @param end * 结束
      * @callback MCardList_Builder
      */
     -(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end {
         NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
         [array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
         [array addObject:[NSString stringWithFormat:@"end=%@",end==nil?@"":end]];
         [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
         [array addObject:[NSString stringWithFormat:@"isV=%d",self.isV]];

         UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardHistory" params:array  delegate:delegate selecter:select];         [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
         return updateone;
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
        [self load:self selecter:@selector(disposMessage:) code:self.confirmCodeText.text account:self.schIDText.text password:self.passwordText.text];
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
    return self.detaiList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ecard";
    EcardCell *cell = (EcardCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MCard* card = [self.detaiList objectAtIndex:indexPath.row];
    [cell.locationLabel setText:card.name];
    [cell.timeLabel setText:card.time];
    [cell.remainLabel setText:card.total];
    [cell.spendLabel setText:card.cost];
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

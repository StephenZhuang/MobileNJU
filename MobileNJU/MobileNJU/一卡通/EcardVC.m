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
#import "AlertViewWithCode.h"
@interface EcardVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,IQActionSheetPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (strong, nonatomic)  UITextField *schIDText;
@property (strong, nonatomic)  UITextField *passwordText;
@property (strong, nonatomic)  UITextField *confirmCodeText;
@property (strong, nonatomic)  UISwitch *autoSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AlertViewWithCode *alertView;
@property (strong, nonatomic) UIImageView *confirmCode;
@property (weak, nonatomic) IBOutlet UILabel *ecardTitle;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (strong,nonatomic) NSString* startDate;
@property (strong,nonatomic) NSString* endDate;
@property(strong,nonatomic)UIButton* selectedButton;
@property(strong,nonatomic)NSArray* detaiList;
@property(nonatomic)int isRe;
@property (nonatomic)CGRect frame;
@end

@implementation EcardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAlert];
    self.isRe=0;
    page=0;
    [self.maskView setHidden:YES];
    [self.alertView setHidden:!([ToolUtils getEcardId]==nil)];
    [self.maskView setHidden:!([ToolUtils getEcardId]==nil)];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToMain:)];
    [self.ecardTitle addGestureRecognizer:singleTap];
    [self.schIDText setText:[ToolUtils getEcardId]==nil?@"":[ToolUtils getEcardId]];
    [self.passwordText setText:[ToolUtils getEcardPassword]==nil?@"":[ToolUtils getEcardPassword]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    [self.endButton setTitle:destDateString forState:UIControlStateNormal];
    NSDate *newDate = [[NSDate alloc] initWithTimeInterval:-60*60*24*7 sinceDate:[NSDate date]];
    destDateString = [dateFormatter stringFromDate:newDate];
    [self.startButton setTitle:destDateString forState:UIControlStateNormal];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *searchDateFormat = [dateFormatter stringFromDate:[NSDate date]];
    self.endDate = searchDateFormat;
    NSString* searchStartDate = [dateFormatter stringFromDate:newDate];
    self.startDate = searchStartDate;
    if (self.alertView.isHidden) {
        [self waiting:@"正在读取"];
        [[ApisFactory getApiMCardInfo]load:self selecter:@selector(disposeMessage:) code:nil account:self.schIDText.text password:self.passwordText.text isV:[ToolUtils getIsVeryfy] isReInput:self.isRe];

    } else {
        [self getCode];
    }
    // Do any additional setup after loading the view.
}





- (void)initAlert
{
    self.alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertViewCode" owner:self options:nil] objectAtIndex:0];
    CGRect frame = CGRectMake((self.view.bounds.size.width-281)/2.0, (self.view.bounds.size.height-320)/2.0, 261, 281);
    self.alertView.frame = frame;
    self.frame = frame;
    [self.view addSubview:self.alertView];
    [self.alertView setHidden:YES];
    self.schIDText =self.alertView.schIdField;
    self.schIDText.delegate = self;
    self.autoSearch = self.alertView.autoSwitch;
    self.passwordText = self.alertView.passwordField;
    self.passwordText.delegate = self;
    self.passwordText.delegate = self;
    self.confirmCode = self.alertView.codeView;
    self.confirmCodeText = self.alertView.codeField;
    self.confirmCodeText.delegate = self;
    [self.alertView.searchBt addTarget:self action:@selector(searchResult:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView.closeBt addTarget:self action:@selector(closeAlertView:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)getCode
{
    [self.confirmCode setImage:[UIImage imageNamed:@"news_loading"]];
    [[ApisFactory getApiMCardInfo]load:self selecter:@selector(disposeMessage:) code:nil account:@"111" password:@"111" isV:0 isReInput:self.isRe];
//    [self load:self selecter:@selector(disposeMessage:) code:nil account:@"1" password:@"1"];
}



//-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password {
//    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
//    if (code!=nil) {
//        [array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
//    }
//    [array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
//    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
//    [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
//    [array addObject:[NSString stringWithFormat:@"isV=%d",[ToolUtils getIsVeryfy]]];
//    UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardInfo" params:array  delegate:delegate selecter:select];
//    [updateone setShowLoading:NO];
//    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
//    return updateone;
//}
- (UIImage *)useImage:(UIImage *)image {
    //    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Create a graphics image context
    CGSize newSize = CGSizeMake(80,40);
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    
    //    [pool release];
    return newImage;
}

- (void)disposeMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MCardInfo"]) {
            MCardList_Builder* cardList = (MCardList_Builder*)[son getBuild];
            if (cardList.cardList.count>0) {
                self.detaiList = [[NSArray alloc]init];
                [self closeAlertView:nil];
                [self.tableView reloadData];
                self.isRe=1;
                MCard* card = [cardList.cardList firstObject];
                [self.nameLabel setText:card.name];
                [self.remainLabel setText:card.total];
                [self.unitLabel setHidden:NO];
                [self.remainNameLabel setHidden:NO];
                [self.tableView reloadData];
                if (self.autoSearch.isOn)
                {
                    [ToolUtils setEcardId:self.schIDText.text];
                    [ToolUtils setEcardPassword:self.passwordText.text];
                }
                [ToolUtils setIsVeryfy:1];
                [self searchDetail:nil];
            } else {
                [self.confirmCode setImage:[self useImage:[UIImage imageWithData:cardList.img]]];
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
           if (page>=1) {
               [self doneWithView:_footer];
           } else {
               [self.tableView reloadData];
           }
       }
    } else if ([son getError]==10021){
        [self getCode];
    } else {
        [super disposMessage:son];
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
    
    
    if (self.schIDText.text.length==0) {
        [ToolUtils showMessage:@"请输入您的学号"];
        [self showAlertView:nil];
    } else if (self.passwordText.text.length==0)
    {
        [ToolUtils showMessage:@"请输入您的密码"];
        [self showAlertView:nil];
    } else {
        if (sender!=nil) {
            page=0;
            self.detaiList = [[NSArray alloc]init];
        }
        [self waiting:@"正在查询"];
        [[[[ApisFactory getApiMCardHistory]setPage:page pageCount:10] load:self selecter:@selector(disposeMessage:) begin:self.startDate end:self.endDate account:self.schIDText.text password:self.passwordText.text]setShowLoading:NO];
//        [self load:self selecter:@selector(disposeMessage:) begin:self.startDate end:self.endDate];
 
    }
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
         [array addObject:[NSString stringWithFormat:@"account=%@",self.schIDText.text]];
         [array addObject:[NSString stringWithFormat:@"password=%@",self.passwordText.text]];
         [array addObject:[NSString stringWithFormat:@"begin=%@",self.startDate]];
         [array addObject:[NSString stringWithFormat:@"end=%@",self.endDate]];
         [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
         [array addObject:[NSString stringWithFormat:@"isV=%d",[ToolUtils getIsVeryfy]]];
         [array addObject:[NSString stringWithFormat:@"page=%d",page]];
         [array addObject:[NSString stringWithFormat:@"limit=%d",20]];
         UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardHistory" params:array  delegate:delegate selecter:select];         [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
         [updateone setShowLoading:NO];
         [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
         return updateone;
     }


- (IBAction)showDataPicker:(UIButton *)sender {
    self.selectedButton = sender;
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"请选择日期" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
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
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGFloat offset= self.frame.origin.y+self.frame.size.height-(self.view.bounds.size.height-216);
        self.alertView.transform = CGAffineTransformMakeTranslation(0, -offset);
        
        } completion:^(BOOL finished) {
        }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
        //    self.logoImage.center = CGPointMake(self.logoImage.center.x, 100);
    } completion:^(BOOL finished) {
    }];

    return YES;
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
        if (self.autoSearch.isOn) {
            [ToolUtils setEcardId:self.schIDText.text];
            [ToolUtils setEcardPassword:self.passwordText.text];
        }
        [self waiting:@"正在查询"];
        [self.passwordText resignFirstResponder];
        [self.confirmCodeText resignFirstResponder];
        [self.schIDText resignFirstResponder];
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
        [[ApisFactory getApiMCardInfo]load:self selecter:@selector(disposeMessage:) code:self.confirmCodeText.text account:self.schIDText.text password:self.passwordText.text isV:[ToolUtils getIsVeryfy] isReInput:self.isRe];

    }
}

- (IBAction)showAlertView:(id)sender {
    [self.schIDText resignFirstResponder];
    [self.passwordText resignFirstResponder];
    [self.confirmCodeText resignFirstResponder];
    if (sender!=nil) {
        [self getCode];
    }
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
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
    NSDateFormatter *dateFormatterwithoutYear = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatterwithoutYear setDateFormat:@"MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatterwithoutYear stringFromDate:pickerView.date];
    [self.selectedButton setTitle:destDateString forState:UIControlStateNormal];
  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    if (self.selectedButton==self.startButton) {
        self.startDate = [dateFormatter stringFromDate:pickerView.date];
        NSDate *end = [dateFormatter dateFromString:self.endDate];
        NSDate *start = [dateFormatter dateFromString:self.startDate];
        
        NSTimeInterval timeBetweenNow = [start timeIntervalSinceNow];
        if (timeBetweenNow>0) {
            start = [NSDate date];
            [self.startButton setTitle:[dateFormatterwithoutYear stringFromDate:start] forState:UIControlStateNormal];
        }
        if(timeBetweenNow<-60*60*24*60)
        {
            NSDate *newDate = [[NSDate alloc] initWithTimeInterval:-60*60*24*59 sinceDate:[NSDate date]];
            start = newDate;
            [self.startButton setTitle:[dateFormatterwithoutYear stringFromDate:start] forState:UIControlStateNormal];
            self.startDate = [dateFormatter stringFromDate:newDate];
            [ToolUtils showMessage:@"只能查询2个月之内的消费记录"];
        }
        NSTimeInterval timeBetween = [end timeIntervalSinceDate:start];
        if (timeBetween<0) {
            self.endDate  = self.startDate;
            [self.endButton setTitle:self.startButton.titleLabel.text forState:UIControlStateNormal];
        }
    } else {
        self.endDate = [dateFormatter stringFromDate:pickerView.date];
        NSDate *end = [dateFormatter dateFromString:self.endDate];
        NSDate *start = [dateFormatter dateFromString:self.startDate];
        
        NSTimeInterval timeBetweenNow = [end timeIntervalSinceNow];
        if (timeBetweenNow>0) {
            end = [NSDate date];
            [self.endButton setTitle:[dateFormatterwithoutYear stringFromDate:end] forState:UIControlStateNormal];
            self.endDate = [dateFormatter stringFromDate:end];
        }
        NSTimeInterval timeBetween = [end timeIntervalSinceDate:start];
        if (timeBetween<0) {
            self.startDate  = self.endDate;
            [self.startButton setTitle:self.endButton.titleLabel.text forState:UIControlStateNormal];
            
        }
    }
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

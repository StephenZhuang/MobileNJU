//
//  LostReleaseVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LostReleaseVC.h"
#import "UtilMethods.h"
#import "ZsndLost.pb.h"
#import "ZsndSystem.pb.h"
#import "CheckBox.h"
@interface LostReleaseVC ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *describeField;
@property (weak, nonatomic) IBOutlet UITextField *contactField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet CheckBox *loss;
@property (weak, nonatomic) IBOutlet CheckBox *pickUp;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (nonatomic)NSInteger releaseType;
@end

@implementation LostReleaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self initField];
    self.releaseType = 2;
    // Do any additional setup after loading the view.
}
- (IBAction)changeType:(id)sender {
    if (sender==self.loss) {
        [self.loss setChoose:YES];
        [self.pickUp setChoose:NO];
        self.releaseType = 2;
    } else {
        [self.loss setChoose:NO];
        [self.pickUp setChoose:YES];
        self.releaseType = 1;
    }
}

- (IBAction)chooseDate:(id)sender {
    [self.pickerView setHidden:YES];
    [self.maskView setHidden:YES];
    NSDate *selected = [self.datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    [self.timeField setText:destDateString];
    
}

- (IBAction)showDataPicker:(UIButton *)sender {
    [self.pickerView setHidden:NO];
}


-(void)initField
{
    self.describeField.layer.borderWidth=1;
    self.describeField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.timeField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.timeField.layer.borderWidth=1;
    [self.timeField setEnabled:NO];
    
    self.locationField.layer.borderWidth=1;
    self.locationField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    self.contactField.layer.borderWidth=1;
    self.contactField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
}
-(void)initNavigationBar
{
    [self setTitle:@"失物招领发布"];
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"提交"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 53, 28);
    button.frame = frame;
    [button addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* releaseItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = releaseItem;

}

-(void)submitInfo
{
//    NSLog(@"捡到是1 丢失是2 现在是 %d",self.loss.choose?2:1);
    NSString *desc = [self.describeField text];
    NSString *contact = [self.contactField text];
    NSString* time = [self.timeField text];
    NSString* location = [self.locationField text];
    if (desc.length == 0) {
        [ProgressHUD showError:@"描述不能为空"];
        return;
    } else if (desc.length > 100) {
        [ProgressHUD showError:@"描述不能超过100字"];
        return;
    }
    
    if (contact.length == 0) {
        [ProgressHUD showError:@"联系方式不能为空"];
        return;
    }
    if (time.length==0){
        [ProgressHUD showError:@"时间不能为空"];
        return;
    }
    if (location.length==0){
        [ProgressHUD showError:@"地点不能为空"];
        return;
    }
    [self waiting:@"正在提交"];
    MAddLostOrFound_Builder* builder =[MAddLostOrFound_Builder new];
    builder.type = self.releaseType;
    builder.contact = self.contactField.text;
    builder.desc = self.describeField.text;
    builder.time = self.timeField.text;
    builder.address = self.locationField.text;
    NSLog(@"%@ time",time);
    if (self.photoArray.count>0) {
        builder.img1 =  UIImageJPEGRepresentation([self.photoArray firstObject], 1.0);
    }
    if (self.photoArray.count>1) {
        builder.img2 =  UIImageJPEGRepresentation([self.photoArray objectAtIndex:1], 1.0);
    }
    if (self.photoArray.count>2) {
        builder.img3 =  UIImageJPEGRepresentation([self.photoArray objectAtIndex:2], 1.0);
    }
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddLostAndFound" params:builder  delegate:self selecter:@selector(disposMessage:)];
    [updateone setShowLoading:NO];
    
    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:self];
}

- (void)disposMessage:(Son *)son
{
    self.OK  = YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MAddLostAndFound"]) {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            NSLog(@"return %@",ret.msg);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end

//
//  EditInfoVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "EditInfoVC.h"
#import "AYHCustomComboBox.h"
#import "CheckBox.h"
#import "TagView.h"
#import "ToolUtils.h"
#import "ZsndUser.pb.h"
@interface EditInfoVC ()<UITextFieldDelegate>
@property(nonatomic,strong)AYHCustomComboBox* instituteBox;
@property (weak, nonatomic) IBOutlet UITextField *instituteField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet TagView *tagView;
@property (weak, nonatomic) IBOutlet UITextField *birthField;
@property (weak, nonatomic) IBOutlet CheckBox *maleCheckBox;
@property (weak, nonatomic) IBOutlet CheckBox *femaleCheckBox;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@end

@implementation EditInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"完善资料"];
    [self setSubTitle:@"完善个人信息"];
    [self addComboBox];
    [self.nickNameField setDelegate:self];
    [self.tagView initialTags];
    [self initField];
    // Do any additional setup after loading the view.
}

- (void)initField
{

    [self.nickNameField setText:[ToolUtils getNickName]==nil?@"":[ToolUtils getNickName]];
    [self.instituteField setText:[ToolUtils getBelong]==nil?@"":[ToolUtils getBelong]
];
    NSString* sex =     [ToolUtils getSex]==nil?@"":[ToolUtils getSex];
    if ([sex isEqualToString:@"男"]) {
        [self.maleCheckBox setChoose:YES];
        [self.femaleCheckBox setChoose:NO];
    } else if ([sex isEqualToString:@"女"])
    {
        [self.maleCheckBox setChoose:NO];
        [self.femaleCheckBox setChoose:YES];
    }
    [self.birthField setText:[ToolUtils getBirthday]==nil?@"":[ToolUtils getBirthday]];
    
    NSString* hobbies =[ToolUtils getTags]==nil?@"":[ToolUtils getTags];
    NSArray* hobbiesArray = [hobbies componentsSeparatedByString:@";"];
    [self.tagView setHobbies:hobbiesArray];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#warning 保存在哪儿还未确定
- (IBAction)save:(id)sender {
    [self waiting:@"正在保存"];
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
//    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    NSArray* keys = [data objectForKey:@"infoKeys"];
//    NSArray* infos = [[NSArray alloc]initWithObjects:
//        self.nickNameField.text,
//        self.instituteField.text,
//        (self.maleCheckBox.choose)?@"男":@"女",
//        self.birthField.text,
//                      [self.tagView getHobbies],nil];
//    NSDictionary* dic = [[NSDictionary alloc]initWithObjects:infos forKeys:keys];
//    [ToolUtils setUserInfo:dic];
//    [self.navigationController popViewControllerAnimated:YES];
//    [ToolUtils setNickname:self.nickNameField.text];
//    [ToolUtils setBelong:self.instituteField.text];
//    [ToolUtils setBirthday:self.birthField.text];
//    [ToolUtils setSex:(self.maleCheckBox.choose)?@"男":@"女"];
//    [ToolUtils setTags:[self.tagView getHobbies]];
    [[ApisFactory getApiMUpdateUserInfo]load:self selecter:@selector(disposMessage:) nickname:self.nickNameField.text belong:self.instituteField.text sex:(self.maleCheckBox.choose)?1:2 birthday:self.birthField.text tags:[[self.tagView getHobbies]stringByReplacingOccurrencesOfString:@";" withString:@","]];
}

- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([[son getMethod] isEqualToString:@"MUpdateUserInfo"])
    {
        MUser_Builder *user = (MUser_Builder *)[son getBuild];
        [ToolUtils setBelong:user.belong];
        [ToolUtils setBirthday:user.birthday];
        [ToolUtils setNickname:user.nickname];
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
        NSMutableString* tagsString = [[NSMutableString alloc]init];
        for (int i = 0 ; i < user.tagsList.count-1; i++)
        {
            [tagsString appendString:[user.tagsList objectAtIndex:i]];
            [tagsString appendString:@";"];
        }
        [tagsString appendString:[user.tagsList lastObject]];
        [ToolUtils setTags:tagsString];
        [self.navigationController popViewControllerAnimated:YES];

    }
}


/*Return返回*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)addComboBox
{
    self.instituteBox = [[AYHCustomComboBox alloc] initWithFrame:CGRectMake(81, 100, 219, 200) DataCount:3 NotificationName:@"AYHComboBoxInstituteChanged"];
    [self.instituteBox setTag:200];
    [self.instituteBox setDelegate:self];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray* items = [data objectForKey:@"NJU"];
    [self.instituteBox addItemsData:items];
    [self.instituteBox flushData];

}
- (IBAction)showComboBox:(id)sender {
    [self.view addSubview:self.instituteBox];
}

/*
 选择性别的监听
 */
- (IBAction)checkSex:(id)sender {
    if (sender==self.maleCheckBox) {
        [self.maleCheckBox setChoose:YES];
        [self.femaleCheckBox setChoose:NO];
    } else {
        [self.maleCheckBox setChoose:NO];
        [self.femaleCheckBox setChoose:YES];
    }
}
- (IBAction)showDataPicker:(id)sender {
    
    [UIView animateWithDuration:0.2
            animations:^{
                CGFloat height = self.view.window.bounds.size.height;
                [self.dateView setCenter:CGPointMake(self.dateView.center.x, height-self.dateView.bounds.size.height/2-60)];
        
    } completion:^(BOOL finished) {
    }];

}
- (IBAction)selectData:(id)sender {
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGFloat height = self.view.window.bounds.size.height;
                         [self.dateView setCenter:CGPointMake(self.dateView.center.x, height+self.dateView.bounds.size.height/2+60)];
                         
                     } completion:^(BOOL finished) {
                     }];
    
    NSDate *selected = [self.datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    [self.birthField setText:destDateString];
}

- (void) CustomComboBoxChanged:(id) sender SelectedItem:(NSString *)selectedItem
{
    AYHCustomComboBox* ccb = (AYHCustomComboBox*) sender;
    if ([ccb tag]==200)
    {
        [self.instituteField setText:selectedItem];
        [self.instituteBox removeFromSuperview];
    }
  
}
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

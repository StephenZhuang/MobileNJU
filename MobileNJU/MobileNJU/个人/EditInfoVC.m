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
#import "IQActionSheetPickerView.h"
@interface EditInfoVC ()<UITextFieldDelegate,IQActionSheetPickerViewDelegate>
@property(nonatomic,strong)AYHCustomComboBox* instituteBox;
@property (weak, nonatomic) IBOutlet UITextField *instituteField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;

@property (weak, nonatomic) IBOutlet UITextField *birthField;
@property (weak, nonatomic) IBOutlet CheckBox *maleCheckBox;
@property (weak, nonatomic) IBOutlet CheckBox *femaleCheckBox;

@end

@implementation EditInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"完善资料"];
    [self addComboBox];
    [self.nickNameField setDelegate:self];
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
    } else {
        [self.maleCheckBox setChoose:YES];
        [self.femaleCheckBox setChoose:NO];
    }
    [self.birthField setText:[ToolUtils getBirthday]==nil?@"":[ToolUtils getBirthday]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning 这里重新写
- (IBAction)save:(id)sender {
    [self waiting:@"正在保存"];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.instituteBox removeFromSuperview];
    return YES;

}


#pragma -mark 选择院系
- (void)addComboBox
{
    [self.nickNameField resignFirstResponder];
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
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"请选择生日" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:6];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker showInView:self.view];

}




#pragma -mark 院系选择操作
- (void) CustomComboBoxChanged:(id) sender SelectedItem:(NSString *)selectedItem
{
    AYHCustomComboBox* ccb = (AYHCustomComboBox*) sender;
    if ([ccb tag]==200)
    {
        [self.instituteField setText:selectedItem];
        [self.instituteBox removeFromSuperview];
    }
    
}


- (IBAction)closeIns:(id)sender {
    [self.nickNameField resignFirstResponder];
    [self.instituteBox removeFromSuperview ];
}


#pragma -mark IQActionSheetPickerViewDelegate
- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:pickerView.date];
    [self.birthField setText:destDateString];
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

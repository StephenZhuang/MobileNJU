//
//  EditInfoVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "EditInfoVC.h"
#import "CheckBox.h"
#import "TagView.h"
#import "ToolUtils.h"
#import "ZsndUser.pb.h"
#import "IQActionSheetPickerView.h"
@interface EditInfoVC ()<UITextFieldDelegate,IQActionSheetPickerViewDelegate>
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
    [self.nickNameField setDelegate:self];
    [self.instituteField setDelegate:self];
    [self.birthField setDelegate:self];
    [self initField];
    // Do any additional setup after loading the view.
}


- (void)initField
{
    [self.nickNameField setText:[ToolUtils getNickName]==nil?@"":[ToolUtils getNickName]];
    [self.instituteField setText:[ToolUtils getBelong]==nil?@"":[ToolUtils getBelong]];
    
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

- (IBAction)save:(id)sender {
    if (self.nickNameField.text.length==0) {
        [ToolUtils showMessage:@"请填写昵称"];
        return;
    }
    [self waiting:@"正在保存"];
    int gender = self.maleCheckBox.choose?1:0;
    [[ApisFactory getApiMUpdateUserInfo]load:self selecter:@selector(disposMessage:) nickname:self.nickNameField.text belong:self.instituteField.text sex:gender birthday:self.birthField.text tags:@""];
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
        [self cancelVC];
    } else {
        [super disposMessage:son];
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
    if (textField==self.instituteField||textField==self.birthField) {
        return NO;
    }
    return YES;
}


#pragma -mark 选择院系
- (IBAction)showComboBox:(id)sender {
    [self.nickNameField resignFirstResponder];
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
//    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray* items = [NSArray arrayWithObjects:@"药学院",@"中药学院",@"国际医药商学院",@"生命科学与技术学院",@"理学院",@"成教院",@"体育部",@"社科部",@"外语系",@"高职学院",@"其他",nil];
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc]initWithTitle:@"请选择院系" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:1];
    [picker setTitlesForComponenets:[NSArray arrayWithObjects:
                                     items,
                                     nil]];

    [picker showInView:self.view];
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


- (IBAction)closeIns:(id)sender {
    [self.nickNameField resignFirstResponder];
}


#pragma -mark IQActionSheetPickerViewDelegate
- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    if (pickerView.tag==1) {
        [self.instituteField setText:[titles firstObject]];
    } else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // 为日期格式器设置格式字符串
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        // 使用日期格式器格式化日期、时间
        NSString *destDateString = [dateFormatter stringFromDate:pickerView.date];
        [self.birthField setText:destDateString];
     
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.nickNameField) {
        if (range.location >=16)
            return NO; // return NO to not change text
        return YES;
    }
    return YES;
}

-(void)cancelVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

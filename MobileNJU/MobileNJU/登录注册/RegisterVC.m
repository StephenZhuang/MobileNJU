//
//  RegisterVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RegisterVC.h"
#import "ZsndSystem.pb.h"
#import "ZsndUser.pb.h"
#import "mMD5.h"
@interface RegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *confirmField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation RegisterVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.myTitle];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    if (self.myDelegate!=nil) {
        self.passwordField.placeholder = @"设置密码";
        self.confirmField.placeholder = @"确认密码";
    } else {
        [self.phoneNumField setEnabled:NO];
        [self.phoneNumField setText:[ToolUtils getAccount]];
    }
}

//- (void)setMyDelegate:(id<loginDelegate>)myDelegate
//{
//   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)complete:(id)sender {
    if (self.phoneNumField.text.length==0) {
        [ToolUtils showMessage:@"用户名不得为空"];
        return;
    } else if (self.passwordField.text.length==0)
    {
        if (self.myDelegate!=nil) {
            [ToolUtils showMessage:@"密码不能为空"];
        } else {
            [ToolUtils showMessage:@"请输入旧密码"];
        }
        return;
    } else if (self.confirmField.text.length==0)
    {
        if (self.myDelegate!=nil) {
            [ToolUtils showMessage:@"请输入确认密码"];
        } else {
            [ToolUtils showMessage:@"请输入新密码"];
        }
        return;
    }
    
    if (self.myDelegate!=nil) {
        if (![self.passwordField.text isEqualToString:self.confirmField.text]) {
            [ToolUtils showMessage:@"两次密码输入不一致"];
            return;
        }
    } else {
        if (![self.passwordField.text isEqualToString:[ToolUtils getPassword]]) {
            [ToolUtils showMessage:@"请输入正确的原密码"];
            return;
        }
    }
    
    if (self.phoneNumField.text.length>16) {
        [ToolUtils showMessage:@"用户名不能超过16位"];
        return;
    }
    if (self.passwordField.text.length>16||self.confirmField.text.length>16) {
        [ToolUtils showMessage:@"密码不能超过16位"];
        return;
    }
    NSString* password = [mMD5 md5s:self.confirmField.text];
    if (self.myDelegate!=nil) {
        [self waiting:@"注册中..."];
        [[ApisFactory getApiMRegist]load:self selecter:@selector(disposMessage:) phone:self.phoneNumField.text password:password nickname:@"" code:@"" device:@"IOS"];
    } else {
//        [self waiting:@"处理中..."];
        [self load:self selecter:@selector(disposMessage:) newPassword:password];

    }
    
}

/**
 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=&device=
 * @param delegate 回调类
 * @param select  回调函数
 * @param phone * 手机号
 * @param password * 密码(需要加密)
 * @param nickname * 昵称
 * @param code * 短信验证码
 * @param device * 设备类型  android或ios
 * @callback MUser_Builder
 */
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  newPassword:(NSString*)password {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
    UpdateOne *update=[[UpdateOne alloc] init:@"MChangePasswd" params:array  delegate:delegate selecter:select];
    [DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
    return update;
}


- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MRegist"]||[[son getMethod] isEqualToString:@"MChangePasswd"])
        {
            MUser_Builder* user = (MUser_Builder*)[son getBuild];
            if (user.headImg.length>0) {
                [ToolUtils setHeadImg:user.headImg];
            }
            [ToolUtils setAccount:user.account];
            [ToolUtils setNickname:user.nickname];
            [ToolUtils setVerify:user.verify];
            [ToolUtils setPassword:self.confirmField.text];
            if ([[son getMethod]isEqualToString:@"MChangePasswd"]) {
                [ToolUtils showMessage:@"修改成功"];
            }
            [self login];
        } else
        if ([[son getMethod] isEqualToString:@"MLogin"])
        {
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            NSLog(@"account%@  nickname%@ verify  %@ ",user.account,user.nickname,user.verify);
            [ToolUtils setVerify:user.verify];
            [ToolUtils setLoginId:user.id];
            if (user.headImg.length>0) {
                [ToolUtils setHeadImg:user.headImg];
            }
            NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"appid=%@",[[Frame INITCONFIG] getAppid]],[NSString stringWithFormat:@"deviceid=%@",[ToolUtils getDeviceid]],[NSString stringWithFormat:@"verify=%@",[ToolUtils getVerify]],[NSString stringWithFormat:@"userid=%@",[ToolUtils getLoginId]],@"device=IOS",nil];
            [Frame setAutoAddParams:array];
            [ToolUtils setIsLogin:YES];
            [ToolUtils setAccount:self.phoneNumField.text];
            [ToolUtils setPassword:self.confirmField.text];
            [ToolUtils setIsVeryfy:user.isV];

            
            [self.myDelegate login];
            [self.navigationController popViewControllerAnimated:NO];
            
        }
    } else {
        [super disposMessage:son];
    }

}
- (IBAction)resignAll:(id)sender {
    [self.phoneNumField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.confirmField resignFirstResponder];
}

#pragma -mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)login
{
    [[ApisFactory getApiMLogin]load:self selecter:@selector(disposMessage:) phone:self.phoneNumField.text password:
     [mMD5 md5s:self.confirmField.text] device:@"ios"];
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

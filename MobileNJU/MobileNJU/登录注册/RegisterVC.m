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
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *veryfyBt;
@property (strong,nonatomic)NSString* phoneNum;
@property (nonatomic)NSInteger remainTime;
@end

@implementation RegisterVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.myTitle];
    if (self.myDelegate==nil) {
        [self.phoneNumField setText:[ToolUtils getAccount]];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getCode:(id)sender {
    if ([ToolUtils checkTel:self.phoneNumField.text]) {
        [self waiting:@"正在发送.."];
        [[ApisFactory getApiMGetMobileVerify]load:self selecter:@selector(disposMessage:) phone:self.phoneNumField.text];
        
    }
}
- (IBAction)complete:(id)sender {
//    
//#warning just for test
//    [self login];
//    return;
//
    
    if (self.passwordField.text.length==0) {
        [self showAlert:@"密码不得为空"];
        return;
    } else if (self.codeField.text.length==0)
    {
        [self showAlert:@"验证码不得为空"];
        return;
    } else if (self.phoneNum==nil)
    {
        [self showAlert:@"请先验证"];
        return;
    }
    [self waiting:@"注册中..."];
    NSString* password = [mMD5 md5s:self.passwordField.text];
    
   [[ApisFactory getApiMRegist]load:self selecter:@selector(disposMessage:) phone:self.phoneNum password:password nickname:@"" code:self.codeField.text pushid:[ToolUtils getPushid] device:@"IOS"];
  
}
- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MGetMobileVerify"]) {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            [ToolUtils showMessage:ret.msg];
            [self.veryfyBt setEnabled:NO];
             [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timer) userInfo:nil repeats:YES];
            self.remainTime = 60;
            self.phoneNum = self.phoneNumField.text;
        } else if ([[son getMethod]isEqualToString:@"MRegist"])
        {
            MUser_Builder* user = (MUser_Builder*)[son getBuild];
            if (user.headImg.length>0) {
                [ToolUtils setHeadImg:user.headImg];
            }
            [ToolUtils setAccount:user.account];
            [ToolUtils setNickname:user.nickname];
            [ToolUtils setVerify:user.verify];
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
            [ToolUtils setAccount:self.phoneNum];
            [ToolUtils setPassword:self.passwordField.text];
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
    [self.codeField resignFirstResponder];
}

- (void) timer
{
    self.remainTime--;
    if (self.remainTime==0) {
        [self.veryfyBt setTitle:@"验证" forState:UIControlStateNormal];
        [self.veryfyBt setEnabled:YES];
    }
}

#pragma -mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)login
{
    [[ApisFactory getApiMLogin]load:self selecter:@selector(disposMessage:) phone:self.phoneNum password:
     [mMD5 md5s:self.passwordField.text]
                             pushid:[[NSUserDefaults standardUserDefaults] objectForKey:@"pushId"] device:@"ios"];

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

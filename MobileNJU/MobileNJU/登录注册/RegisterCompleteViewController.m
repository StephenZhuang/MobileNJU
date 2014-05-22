//
//  RegisterCompleteViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "RegisterCompleteViewController.h"

@interface RegisterCompleteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameField;

@end

@implementation RegisterCompleteViewController

#pragma mark set
/*初始化文本框*/
- (void) initTextField
{
    [self.phoneNumField setEnabled:NO];
    [self.phoneNumField setText:[NSString stringWithFormat:@"%@ (账户)",super.phoneNum]];
    [self.passwordField becomeFirstResponder];
    [self setDelegate];
}
/*设置文本框代理*/
- (void)setDelegate
{
    self.passwordField.delegate = self;
    self.nicknameField.delegate = self;
}
/*号码*/
- (void)setPhoneNum:(NSString *)phoneNum
{
    [super setPhoneNum:phoneNum];
    [self.phoneNumField setText:[NSString stringWithFormat:@"%@ (账户)",self.phoneNum]];
}


#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.passwordField) {
        if ([self.passwordField.text length]!=0){
            [textField resignFirstResponder];
            [self.nicknameField becomeFirstResponder];
        } else {
            [self showAlert:@"密码不能为空"];
            return NO;
        }
    } else {
        if ([textField.text length]==0){
            [self showAlert:@"昵称不能为空"];
        } else{
        [self performSegueWithIdentifier:@"completeRegister" sender:nil];
        }
        
    }
    return YES;
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([self.passwordField.text length]==0) {
        [self showAlert:@"请设置密码"];
        return NO;
    } else if ([self.nicknameField.text length]==0){
        [self showAlert:@"请输入昵称"];
        return NO;
    }
    return YES;
}

- (IBAction)resignAllResponder:(UIButton *)sender {
    [self.passwordField resignFirstResponder];
    [self.nicknameField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextField];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  RegisterViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetCodeViewController.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation RegisterViewController

/*返回上一级*/
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:true];
}

/*设置下一级Controller的phoneNum*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"nextStep"]) {
        GetCodeViewController* nextController = (GetCodeViewController*)segue.destinationViewController;
        nextController.phoneNum = self.phoneTextField.text;
    }
}

/*判断输入框是否为空，若空，给出提示*/

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"nextStep"]) {
        if ([self.phoneTextField.text length]==11 ) {
            return YES;
        } else
        {
            [self showAlert:@"请输入正确的手机手机号码"];
            return NO;
        }
    }
    return YES;
}

/*Show Alert*/
- (void) showAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] ;
    [alert show];
}

#pragma mark -UITextFieldDelegate

/*Return返回*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phoneTextField.delegate = self;
    [self.phoneTextField becomeFirstResponder];
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

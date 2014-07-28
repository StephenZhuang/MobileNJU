//
//  RegisterVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation RegisterVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"注册"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getCode:(id)sender {
    if ([ToolUtils checkTel:self.phoneNumField.text]) {
        
    }else
    {
        [self showAlert:@"请填写正确的手机号"];
    }
}
- (IBAction)complete:(id)sender {
    
}


#pragma -mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

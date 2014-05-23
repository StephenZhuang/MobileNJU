//
//  GetCodeViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "GetCodeViewController.h"
#import "RegisterCompleteViewController.h"
@interface GetCodeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeField;
@end

@implementation GetCodeViewController


#pragma viewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phoneNumLabel.text = [NSString stringWithFormat:
                               @"掌上南大已把验证码发送至：%@",self.phoneNum];
    [self.confirmCodeField becomeFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set
/*设置phoneNum同时设置上方Label*/
- (void)setPhoneNum:(NSString *)phoneNum
{
    _phoneNum = phoneNum;
    self.phoneNumLabel.text = [NSString stringWithFormat:
    @"掌上南大已把验证码发送至：%@",phoneNum];
}


#pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"completeCode"]) {
        RegisterCompleteViewController* nextController = (RegisterCompleteViewController*) segue.destinationViewController;
        [nextController setPhoneNum:self.phoneNum];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"completeCode"]) {
        if ([self.confirmCodeField.text length]==0) {
            [self showAlert:@"请输入验证码"];
            return NO;
        }
    }
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

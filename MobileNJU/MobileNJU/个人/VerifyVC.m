//
//  VerifyVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-8-4.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "VerifyVC.h"
#import "ZsndSystem.pb.h"
@interface VerifyVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *brasPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *brasNameField;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIImageView *codeView;

@property (weak, nonatomic) IBOutlet UIView *veryfyCode;
@end

@implementation VerifyVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"身份认证"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resignAll:(id)sender {
    [self.brasNameField resignFirstResponder];
    [self.brasPasswordField resignFirstResponder];
    [self.codeText resignFirstResponder];
}

- (IBAction)verify:(id)sender {
    if (self.brasNameField.text.length==0) {
        [ToolUtils showMessage:@"请输入账号"];
        return;
    } else if (self.brasPasswordField.text.length==0)
    {
        [ToolUtils showMessage:@"请输入密码"];
        return;
    } else if (self.veryfyCode.isHidden==NO&&self.codeText.text.length==0)
    {
        [ToolUtils showMessage:@"请输入验证码"];
        return;
    }
    [self waiting:@"正在验证"];
    [[ApisFactory getApiMVerifyUser]load:self selecter:@selector(disposMessage:) num:self.brasNameField.text pwd:self.brasPasswordField.text code:self.codeText.text];
}
- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MVerifyUser"]) {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            if (ret.img.length>0) {
                [self.veryfyCode setHidden:NO];
                [self.codeView setImage:[UIImage imageWithData:ret.img]];
            } else if (ret.code==1) {
                [ToolUtils showMessage:ret.msg];
                [ToolUtils setIsVeryfy:1];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    } else {
        [self.veryfyCode setHidden:YES];
        [super disposMessage:son];
    }

}
#pragma mark textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField==self.brasNameField) {
        [self.brasPasswordField becomeFirstResponder];
    }
    return  YES;
}

- (void)cancelVerify
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

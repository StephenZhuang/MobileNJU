//
//  FeedBackVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-9-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "FeedBackVC.h"

@implementation FeedBackVC 

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"用户反馈"];
    self.textArea.layer.borderColor = [UIColor colorWithRed:0/255.0 green:147/255.0 blue:242/255.0 alpha:1].CGColor;

//    self.textArea.layer.borderColor = [UIColor colorWithRed:169/255.0 green:16/255.0 blue:166/255.0 alpha:1].CGColor;
//    self.textArea.layer.borderColor = [UIColor colorWithRed:18/255.0 green:191/255.0 blue:125/255.0 alpha:1].CGColor;

    self.textArea.layer.borderWidth = 1;
    self.textArea.layer.cornerRadius = 10;
    self.submitBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [self.submitBt setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBt addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.submitBt];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.textArea.delegate = self;

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.textArea.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            self.placeholder.hidden=NO;//隐藏文字
        }else{
            self.placeholder.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.textArea.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                self.placeholder.hidden=NO;
            }else{//不是删除
                self.placeholder.hidden=YES;
            }
        }else{//长度不为1时候
            self.placeholder.hidden=YES;
        }
    }
    return YES;
}

- (IBAction)submit:(id)sender {
    
    [self.textArea resignFirstResponder];
    if (self.textArea.text.length==0) {
        [ToolUtils showMessage:@"反馈内容不得为空"];
    } else {
        [self.submitBt setEnabled:NO];
        [self load:self selecter:@selector(disposMessage:) content:self.textArea.text];
        [self waiting:@"正在提交"];
    }
   
}

- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    [self.submitBt setEnabled:YES];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MFeedback"]) {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            if (ret.code==1) {
                [ToolUtils showMessage:@"提交成功！\n 感谢您的反馈"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [ToolUtils showMessage:@"网络错误，请重试"];

            }
        }
    } else {
        [super disposMessage:son];
    }
}


-(UpdateOne*)load:(id)delegate selecter:(SEL)select  content:(NSString*) content  {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"content=%@",content==nil?@"":content]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MFeedback" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];

    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];

    return updateone;
}
- (IBAction)resign:(id)sender {
    [self.textArea resignFirstResponder];
}


@end

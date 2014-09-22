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
    self.textArea.layer.borderColor = [UIColor colorWithRed:18/255.0 green:191/255.0 blue:125/255.0 alpha:1].CGColor;
    self.textArea.layer.borderWidth = 1;
    self.textArea.layer.cornerRadius = 10;
    self.submitBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [self.submitBt setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBt addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.submitBt];
    self.navigationItem.rightBarButtonItem = rightButton;
    

}

- (IBAction)submit:(id)sender {
    [self.textArea resignFirstResponder];
    [self.submitBt setEnabled:NO];
    [self load:self selecter:@selector(disposMessage:) content:self.textArea.text];
    [self waiting:@"正在提交"];
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
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];

    [updateone setShowLoading:NO];
    return updateone;
}
- (IBAction)resign:(id)sender {
    [self.textArea resignFirstResponder];
}


@end

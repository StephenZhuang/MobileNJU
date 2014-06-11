//
//  ChatViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ChatViewController.h"
#import "ZsndUser.pb.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

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
    // Do any additional setup after loading the view.
    [self setTitle:@"南呱"];
    [self setSubTitle:@"和水果聊天"];
    
    if (_isFromGua) {
        [_connentView startConnecting];
        [[ApisFactory getApiMGetUserInfo] load:self selecter:@selector(disposMessage:)];
        [[ApisFactory getApiMChatMatch] load:self selecter:@selector(disposMessage:)];
    } else {
        [self addCall];
        [_connentView setFrame:CGRectMake(0, 0, 320, 0.1)];
    }
}

- (void)addCall
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 45, 30)];
    [button setTitle:@"呼叫" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)callAction:(id)sender
{
    
}

- (void)addChangge
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 45, 30)];
    [button setTitle:@"换人" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)changeAction:(id)sender
{
    
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MGetUserInfo"]) {
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            [_connentView.logoImage setImageWithURL:[ToolUtils getImageUrlWtihString:user.headImg] placeholderImage:[UIImage imageNamed:@""]];
            [_connentView.nameLabel setText:user.nickname];
            [_connentView.flowerLabel setText:[NSString stringWithFormat:@"鲜花数：%i",user.flower]];
            
        } else if ([[son getMethod] isEqualToString:@"MChatMatch"]) {
            MMatch_Builder *match = (MMatch_Builder *)[son getBuild];
            [_connentView.fruitImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i" , match.headImg]]];
            [_connentView.cardView setMatch:match];
            
            
        }
    }
}

- (IBAction)buttonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"取消"]) {
        [self closeSelf];
    } else {
        [_connentView startConnecting];
    }
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

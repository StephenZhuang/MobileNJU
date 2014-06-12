//
//  ConnectViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-12.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ConnectViewController.h"
#import "ZsndUser.pb.h"
#import "ZsndChat.pb.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController

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
    [_connentView startConnecting];
    [[ApisFactory getApiMGetUserInfo] load:self selecter:@selector(disposMessage:)];
    [[ApisFactory getApiMChatMatch] load:self selecter:@selector(disposMessage:)];
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
            
            [_connentView stopAnimation];
            [_connentView.tipLabel setHidden:YES];
            [_connentView.cancelButton setHidden:YES];
            [_connentView.collectionView setHidden:YES];
        }
    }
}

- (IBAction)buttonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"取消"]) {
        [self.parentViewController.navigationController popViewControllerAnimated:YES];
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

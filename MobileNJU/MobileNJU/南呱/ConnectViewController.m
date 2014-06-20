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
    
    _headImg = @"";
    [_connentView setIsCall:_isCall];
    [[ApisFactory getApiMGetUserInfo] load:self selecter:@selector(disposMessage:)];
    
    if (_isCall) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedCall:) name:@"receivedCall" object:nil];
        [_connentView.fruitImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i",_targetHead]]];
        [_connentView.collectionView setHidden:YES];
    } else {
        [[ApisFactory getApiMChatMatch] load:self selecter:@selector(disposMessage:)];
    }
    [_connentView startConnecting];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MGetUserInfo"]) {
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            [_connentView.logoImage setImageWithURL:[ToolUtils getImageUrlWtihString:user.headImg] placeholderImage:[UIImage imageNamed:@""]];
            _headImg = user.headImg;
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
            
            if (_matchSuccessBlock) {
                _matchSuccessBlock(match.userid , match.headImg , _headImg);
            }
            
            [self performSelector:@selector(doAnimation) withObject:nil afterDelay:2];
        }
    }
}

- (void)doAnimation
{
    [UIView transitionFromView:self.view
                        toView:self.view
                      duration:1
                       options: UIViewAnimationOptionTransitionCurlUp
                    completion:^(BOOL finished) {
                        if (finished) {
                            
                        }
                    }];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

- (IBAction)buttonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"取消"]) {
        [self.parentViewController.navigationController popViewControllerAnimated:YES];
    } else {
        [[ApisFactory getApiMChatMatch] load:self selecter:@selector(disposMessage:)];
        [_connentView startConnecting];
    }
}

- (void)closeSelf
{
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}

- (void)receivedCall:(NSNotification *)notification
{
    [_connentView stopAnimation];
    NSDictionary *userInfo = notification.userInfo;
    if ([[userInfo objectForKey:@"state"] isEqualToString:@"0"]) {
//        [ProgressHUD showError:@"呱友拒绝了你的呼叫"];
        [_connentView.fruitImage setImage:[UIImage imageNamed:@"nangua_connect_timedout@2x"]];
        [_connentView.tipLabel setText:@"对方拒绝了你的请求"];
    } else {
//        [ProgressHUD showSuccess:@"呱友接受了你的呼叫"];
        [_connentView.tipLabel setText:@"对方接受了你的请求"];
        [_connentView.fruitImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i",_targetHead]]];
        [self performSelector:@selector(doAnimation) withObject:nil afterDelay:2];
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

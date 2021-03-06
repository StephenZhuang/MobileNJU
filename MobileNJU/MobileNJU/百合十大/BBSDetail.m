//
//  BBSDetail.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BBSDetail.h"

@interface BBSDetail ()<UIWebViewDelegate>

@end

@implementation BBSDetail

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
//    [self setUrl:[NSURL URLWithString:@"http://114.215.196.179/nju/vote/1407220561836.html?userid=1c947179-eb40-11e3-b696-ac853d9d52b1&verify=1"]];
    [self setTitle:@"详情"];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.webView setDelegate:self];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView setDelegate:nil];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loginIndicator removeFromSuperview];
    self.OK = YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self waiting:@"加载中"];
}

@end

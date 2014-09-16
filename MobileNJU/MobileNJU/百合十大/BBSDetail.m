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
    [self setTitle:@"详情"];
    [self.webView setDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(timer) userInfo:nil repeats:NO];

    // Do any additional setup after loading the view.
}


- (void)timer
{
    [self.loginIndicator removeFromSuperview];
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

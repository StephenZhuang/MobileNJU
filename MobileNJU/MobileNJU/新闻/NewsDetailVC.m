//
//  NewsDetailVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "NewsDetailVC.h"

@interface NewsDetailVC ()
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@end

@implementation NewsDetailVC
# pragma viewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"新闻详情"];
    [self setSubTitle:@"官方新闻"];
    NSLog(@"%@",self.url);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showShare:(id)sender {
    [self.shareView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

- (IBAction)cancelShare:(id)sender {
    [self.shareView setHidden:YES];
    [self.maskView setHidden:YES];
    [self removeMask];
}

@end

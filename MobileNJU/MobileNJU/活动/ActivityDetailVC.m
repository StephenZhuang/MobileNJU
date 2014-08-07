//
//  ActivityDetailVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ActivityDetailVC.h"

@interface ActivityDetailVC ()


@end

@implementation ActivityDetailVC

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
    [self setTitle:@"活动详情"];
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 32)];
    NSString *iconname=@"分享";
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",iconname]] forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",iconname]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    //    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
    [self.navigationItem setRightBarButtonItem:myAddButton];
    
    
    
    // Do any additional setup after loading the view.

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

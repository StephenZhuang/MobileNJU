//
//  NanguaBaseViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-9.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NanguaBaseViewController.h"

@interface NanguaBaseViewController ()

@end

@implementation NanguaBaseViewController

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg_clear"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.titleView.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleView.subtitleLabel setTextColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nangua_bg"]]];
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];

    [button setImage:[UIImage imageNamed:@"nangua_back"] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
    self.navigationItem.leftBarButtonItems = myButtonArray;
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

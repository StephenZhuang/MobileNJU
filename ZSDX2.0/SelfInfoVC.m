//
//  SelfInfoVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-15.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "SelfInfoVC.h"

@interface SelfInfoVC ()

@end

@implementation SelfInfoVC
- (IBAction)click:(id)sender {
    NSLog(@"click");
}

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

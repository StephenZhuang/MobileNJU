//
//  TelephoneInfoVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-21.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "TelephoneInfoVC.h"

@interface TelephoneInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *phoneTableView;
@property (assign) BOOL isOpen;
@end

@implementation TelephoneInfoVC



- (IBAction)returnToMain:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phoneTableView.sectionFooterHeight = 0;
    self.phoneTableView.sectionHeaderHeight = 0;
    self.isOpen = NO;

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

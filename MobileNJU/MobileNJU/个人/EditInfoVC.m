//
//  EditInfoVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "EditInfoVC.h"
#import "AYHCustomComboBox.h"
@interface EditInfoVC ()
@property(nonatomic,strong)AYHCustomComboBox* instituteBox;
@property (weak, nonatomic) IBOutlet UITextField *instituteField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickNameField;

@end

@implementation EditInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"完善资料"];
    [self setSubTitle:@"完善个人信息"];
    [self addComboBox];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addComboBox
{
    self.instituteBox = [[AYHCustomComboBox alloc] initWithFrame:CGRectMake(81, 123, 219, 200) DataCount:3 NotificationName:@"AYHComboBoxInstituteChanged"];
    [self.instituteBox setTag:200];
    [self.instituteBox setDelegate:self];
    NSArray* items = [[NSArray alloc] initWithObjects:@"不限",@"男",@"女",nil];
    [self.instituteBox addItemsData:items];
    [self.instituteBox flushData];

}
- (IBAction)showComboBox:(id)sender {
    [self.view addSubview:self.instituteBox];
}

- (void) CustomComboBoxChanged:(id) sender SelectedItem:(NSString *)selectedItem
{
    AYHCustomComboBox* ccb = (AYHCustomComboBox*) sender;
    if ([ccb tag]==200)
    {
        [self.instituteField setText:selectedItem];
        [self.instituteBox removeFromSuperview];
    }
  
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

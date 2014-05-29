//
//  ScheduleVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ScheduleVC.h"
#import "AlertCloseDelegate.h"
#import "ScheduleView.h"
@interface ScheduleVC ()<AlertCloseDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@end

@implementation ScheduleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self loadSchedule];
      // Do any additional setup after loading the view.
}
- (void)loadSchedule
{
    ScheduleView* schedule = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleView" owner:self options:nil] firstObject];
    CGRect frame = CGRectMake(0, 0, 320, 568);
    schedule.frame = frame;
    self.scrollView.contentSize = CGSizeMake(320, 568);
    [self.scrollView addSubview:schedule];
    
    
    ScheduleLesson* lesson1 = [[ScheduleLesson alloc]init];
    lesson1.start=1;
    lesson1.length=2;
    lesson1.day=1;
    lesson1.name = @"微积分@仙一202";
    self.lessons = [[NSArray alloc]initWithObjects:lesson1,nil];
    
    
    ScheduleLesson* lesson2 = [[ScheduleLesson alloc]init];
    lesson2.start=5;
    lesson2.length=3;
    lesson2.day=1;
    lesson2.name = @"英语文体风格鉴赏@仙一202";
    
    
    ScheduleLesson* lesson3 = [[ScheduleLesson alloc]init];
    lesson3.start=2;
    lesson3.length=2;
    lesson3.day=2;
    lesson3.name = @"大学生心理健康学@仙一202";

    
    ScheduleLesson* lesson4 = [[ScheduleLesson alloc]init];
    lesson4.start=1;
    lesson4.length=2;
    lesson4.day=5;
    lesson4.name = @"大学生心理健康学@仙一202";
    
    self.lessons = [[NSArray alloc]initWithObjects:lesson1,lesson2,lesson3,lesson4,nil];

    [schedule addLessons:self.lessons];
}


- (void)initNavigationBar
{
    [self setTitle:@"课程表"];
    [self setSubTitle:@"一二三四五六七"];

        UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"self_right_barButton"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 40, 36);
    button.frame = frame;
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* selfItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    //    [selfItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfItem;
}

- (void)showAlert
{
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

#pragma mark delegate_AlertChoose
- (void)closeAlert{
    [self cancelAlert:nil];
}

- (IBAction)cancelAlert:(id)sender {
    [self.maskView setHidden:YES];
    [self.alertView setHidden:YES];
    [super removeMask];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detail" sender:nil];
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

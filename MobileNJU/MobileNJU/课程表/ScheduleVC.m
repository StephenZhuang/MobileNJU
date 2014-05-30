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
#import "LessonDetailView.h"
#import "AlertCloseDelegate.h"
@interface ScheduleVC ()<AlertCloseDelegate,ScheduleViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (strong,nonatomic)LessonDetailView* lessonDetail;
@end

@implementation ScheduleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self loadSchedule];
    [self initLessonDetail];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDate* date = [[NSDate alloc]init];
    NSDateComponents* compos =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                        fromDate:date];
//    NSInteger week = [compos week]; // 今年的第几周
    NSInteger weekday = [compos weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    for (UIView* view in self.dayView.subviews) {
        UILabel* label = (UILabel*)view;
        NSLog(@"%@",label.text);
        [label setBackgroundColor:[UIColor colorWithRed:235/255.0 green:234/255.0 blue:231/255.0 alpha:1]];
         [label setTextColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1]];
    }
    UILabel* currentDay = [self.dayView.subviews objectAtIndex:(weekday-2)];
    [currentDay setTextColor:[UIColor whiteColor]];
    [currentDay setBackgroundColor:[UIColor blackColor]];
      // Do any additional setup after loading the view.
}


- (void) initLessonDetail
{
    self.lessonDetail = [[[NSBundle mainBundle] loadNibNamed:@"LessonDetailView" owner:self options:nil] firstObject];
    [self.lessonDetail setFrame:CGRectMake(30, 100,260,200)];
    [self.lessonDetail setHidden:YES];
    [self.lessonDetail setMydelegate:self];
    [self.view addSubview:self.lessonDetail];
    
}

- (void)showSchedule:(ScheduleLesson *)lesson
{
    [self.lessonDetail setLesson:lesson];
    [self.lessonDetail setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
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
    lesson1.time = @"周一1-2节";
    lesson1.teacher = @"肖源明";
    lesson1.location = @"仙1 211";
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

    [schedule addLessons:self.lessons delegate:self];
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
    [self.lessonDetail setHidden:YES];
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

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
#import "ZsndSystem.pb.h"
@interface ScheduleVC ()<AlertCloseDelegate,ScheduleViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *weekNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (strong,nonatomic)LessonDetailView* lessonDetail;
@property (strong,nonatomic)UITextField* codeView;
@property (strong,nonatomic)NSArray* lessonList;
@property (strong,nonatomic)NSString* code;
@end
@implementation ScheduleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
//    [self loadSchedule];
    [self initLessonDetail];
    self.code=nil;
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDate* date = [[NSDate alloc]init];
    NSDateComponents* compos =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                        fromDate:date];
//    NSInteger week = [compos week]; // 今年的第几周
    NSInteger weekday = [compos weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    for (UIView* view in self.dayView.subviews) {
        UILabel* label = (UILabel*)view;
        [label setBackgroundColor:[UIColor colorWithRed:235/255.0 green:234/255.0 blue:231/255.0 alpha:1]];
         [label setTextColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1]];
    }
    if (weekday<=6&&weekday>1) {
        UILabel* currentDay = [self.dayView.subviews objectAtIndex:(weekday-2)];
        [currentDay setTextColor:[UIColor whiteColor]];
        [currentDay setBackgroundColor:[UIColor blackColor]];
    }
    
    self.schIdField.text=[ToolUtils getJWID];
    self.passwordField.text = [ToolUtils getJWPassword];
    [self loadSavedLesson];
    if (![self.schIdField.text isEqualToString:@""]&&![self.passwordField.text isEqualToString:@""]) {
        [self search:nil];
    }
    
    
  //    if (self.lessonList!=nil) {
//        [self loadSchedule];
//    }
        // Do any additional setup after loading the view.
}
- (void)loadSavedLesson
{
    NSArray* lessons = [ToolUtils getMySchedule];
    if (lessons.count>0) {
        NSMutableArray* lessonList = [[NSMutableArray alloc]init];
        for (NSDictionary* dic in lessons) {
            ScheduleLesson* each_lesson = [[ScheduleLesson alloc]init];
            [each_lesson loadDic:dic];
            [lessonList addObject:each_lesson];
        }
        self.lessons=lessonList;
        ScheduleView* schedule = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleView" owner:self options:nil] firstObject];
        CGRect frame = CGRectMake(0, 0, 320, 568);
        schedule.frame = frame;
        self.scrollView.contentSize = CGSizeMake(320, 568);
        [self.scrollView addSubview:schedule];
        [schedule addLessons:self.lessons delegate:self];
    }
    [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",  [ToolUtils getCurrentWeek]]];

}
- (IBAction)search:(id)sender {
    
    [self.codeView resignFirstResponder];
    [self.schIdField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    if (self.schIdField.text.length==0) {
        [self showAlert:@"学号不能为空"];
        return ;
    }
    if (self.passwordField.text.length==0) {
        [self showAlert:@"密码不能为空"];
        return;
    }
    if (sender!=nil) {
        [self waiting:@"正在查询"];
    }
    [[ApisFactory getApiMSchedule]load:self selecter:@selector(disposMessage:) code:self.codeView.text account:self.schIdField.text password:self.passwordField.text];
}

- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MSchedule"]) {
            
            MClassList_Builder* classList = (MClassList_Builder*)[son getBuild];
            if (classList.week!=0) {
                [self closeAlert];
                if (self.autoSwitch.isOn) {
                    [ToolUtils setJWPassword:self.passwordField.text];
                    [ToolUtils setJWId:self.schIdField.text];
                } else{
                    [ToolUtils setJWPassword:@""];
                    [ToolUtils setJWId:@""];
                }
                [ToolUtils setCurrentWeek:classList.week];
//                [ToolUtils setMySchedule:classList.classList];
                [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",classList.week]];
                
                self.lessonList = classList.classList;
                [self loadSchedule];
            } else {
                [self addCode:classList.img];
           }
            
        }
    }
}

- (void)addCode:(NSData*)img
{
    
//    CGRect frame =  self.alertView.frame;
//    frame.size.height = frame.size.height+80;
    
//    [self.alertView removeFromSuperview];
//    self.alertView.frame = frame;
//    [self.view addSubview:self.alertView];
    self.searchButton.transform = CGAffineTransformMakeTranslation(0, 60);

    self.codeView = [[UITextField alloc]init];
    self.codeView.delegate = self;
    self.codeView.borderStyle = self.schIdField.borderStyle;
    self.codeView.placeholder = @"请输入验证码";
    CGRect codeFrame = self.passwordField.frame;
    codeFrame.size.width = codeFrame.size.width/2;
    codeFrame.origin.y = codeFrame.origin.y+codeFrame.origin.y-self.schIdField.frame.origin.y+self.autoSwitch.frame.size.height;
    self.codeView.frame = codeFrame;
    [self.alertView addSubview:self.codeView];
    
    
    codeFrame.origin.x = codeFrame.size.width+20;
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:codeFrame];
    [imgView setImage:[UIImage imageWithData:img]];
    [self.alertView addSubview:imgView];
    
    
}
#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [self.alertView removeFromSuperview];
//    [self.view addSubview:self.alertView];
//    CGPoint center  = self.alertView.center;
//    CGPoint newCenter = CGPointMake(center.x, center.y-50);
    [UIView animateWithDuration:0.3f animations:^{
//        self.alertView.center = newCenter;
    }];
    [UIView animateWithDuration:0.3f animations:^{
        [self.view bringSubviewToFront:self.alertView];
        self.alertView.transform = CGAffineTransformMakeTranslation(0, -50);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.alertView];
    }];
//    [textField becomeFirstResponder];
   
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
    
    NSMutableArray* schedules = [[NSMutableArray alloc]init];
    NSMutableArray* canSaveLessons = [[NSMutableArray alloc]init];

    for (MClass* each_class in self.lessonList) {
        ScheduleLesson* lesson = [[ScheduleLesson alloc]init];
        lesson.name = each_class.name;
        lesson.teacher = each_class.teacher;
        lesson.location = each_class.address;
        lesson.week = each_class.week;
        lesson.day = each_class.day;
        lesson.start = each_class.begin;
        lesson.length = each_class.end-each_class.begin+1;
        lesson.time = each_class.time;
        [schedules addObject:lesson];
        [canSaveLessons addObject:[lesson getDic]];
    }
    self.lessons= schedules;
    [ToolUtils setMySchedule:canSaveLessons];
//    
//    ScheduleLesson* lesson1 = [[ScheduleLesson alloc]init];
//    lesson1.start=1;
//    lesson1.length=2;
//    lesson1.day=1;
//    lesson1.name = @"微积分@仙一202";
//    lesson1.time = @"周一1-2节";
//    lesson1.teacher = @"肖源明";
//    lesson1.location = @"仙1 211";
//    self.lessons = [[NSArray alloc]initWithObjects:lesson1,nil];
//    
//    
//    ScheduleLesson* lesson2 = [[ScheduleLesson alloc]init];
//    lesson2.start=5;
//    lesson2.length=3;
//    lesson2.day=1;
//    lesson2.name = @"英语文体风格鉴赏@仙一202";
//    
//    
//    ScheduleLesson* lesson3 = [[ScheduleLesson alloc]init];
//    lesson3.start=2;
//    lesson3.length=2;
//    lesson3.day=2;
//    lesson3.name = @"大学生心理健康学@仙一202";
//
//    
//    ScheduleLesson* lesson4 = [[ScheduleLesson alloc]init];
//    lesson4.start=1;
//    lesson4.length=2;
//    lesson4.day=5;
//    lesson4.name = @"大学生心理健康学@仙一202";
//    
//    self.lessons = [[NSArray alloc]initWithObjects:lesson1,lesson2,lesson3,lesson4,nil];

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
    
    
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    [self.codeView resignFirstResponder];
    [self.schIdField resignFirstResponder];
    [self.passwordField resignFirstResponder];
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

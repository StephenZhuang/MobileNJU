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
#import "ApiMScheduleAuto.h"
@interface ScheduleVC ()<AlertCloseDelegate,ScheduleViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic)  UILabel *weekNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (strong,nonatomic)LessonDetailView* lessonDetail;
@property (strong,nonatomic)UITextField* codeView;
@property (strong,nonatomic)NSArray* lessonList;
@property (strong,nonatomic)NSString* code;
@property (nonatomic)int isRe;
@property (nonatomic)int isV;
@property (nonatomic,strong)ScheduleView* scheduleView;
@end
@implementation ScheduleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self initLessonDetail];
    self.code=nil;
    self.schIdField.text=[ToolUtils getJWID];
    self.passwordField.text = [ToolUtils getJWPassword];
    [self loadSavedLesson];

    [self loadLast];
    self.isRe=0;
    self.isV=0;
    [self addTitleView];
}

- (void)addTitleView
{
    self.titleView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:self options:nil] firstObject];
    [self.navigationItem setTitleView:self.titleView];
    self.weekNumLabel = self.titleView.subtitleLabel;

}
- (void)loadLast
{
    ApiMScheduleAuto* scheduleAuto = [[ApiMScheduleAuto alloc]init];
    [scheduleAuto load:self selecter:@selector(disposMessage:) account:[ToolUtils getJWID]];
    
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
        [schedule initDate];
        CGRect frame = CGRectMake(0, 0, 320, 568);
        schedule.frame = frame;
        self.scrollView.contentSize = CGSizeMake(320, 568);
        [self.scrollView addSubview:schedule];
        [schedule addLessons:self.lessons delegate:self];
        self.scheduleView = schedule;
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
    self.isRe=1;
    [self load:self selecter:@selector(disposMessage:) code:self.codeView.text account:self.schIdField.text password:self.passwordField.text] ;
    
}

/**
 *  课程表 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
 * @param delegate 回调类
 * @param select  回调函数
 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
 * @param account * account
 * @param password * password
 * @callback MClassList_Builder
 */
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    if (code!=nil) {
        [array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
    }
    [array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
    [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
    [array addObject:[NSString stringWithFormat:@"isV=%d",self.isV]];
    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MSchedule" params:array  delegate:delegate selecter:select];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}
- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MSchedule"]) {
            
            MClassList_Builder* classList = (MClassList_Builder*)[son getBuild];
            if (classList.week!=0) {
                self.isRe=1;
                [self closeAlert];
                if (self.autoSwitch.isOn) {
                    [ToolUtils setJWPassword:self.passwordField.text];
                    [ToolUtils setJWId:self.schIdField.text];
                } else{
                    [ToolUtils setJWPassword:@""];
                    [ToolUtils setJWId:@""];
                }
                [ToolUtils setCurrentWeek:classList.week];
                [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",classList.week]];
                self.lessonList = classList.classList;
                [self loadSchedule];
            } else {
                self.isV=1;
                [self addCode:classList.img];
           }
            
        } else if ([[son getMethod]isEqualToString:@"MScheduleAuto"]){
            MClassList_Builder* classList = (MClassList_Builder*)[son getBuild];
            [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",classList.week]];
            self.lessonList = classList.classList;
            [self loadSchedule];

        }
    }
}

- (void)addCode:(NSData*)img
{
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
    if (self.view.window.frame.size.height==480) {
        [UIView animateWithDuration:0.3f animations:^{
            //        self.alertView.center = newCenter;
        }];
        [UIView animateWithDuration:0.3f animations:^{
            [self.view bringSubviewToFront:self.alertView];
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -50);
        } completion:^(BOOL finished) {
            [self.view bringSubviewToFront:self.alertView];
        }];

    }
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
    if (self.scheduleView!=nil) {
        [self.scheduleView removeFromSuperview];
    }
    ScheduleView* schedule = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleView" owner:self options:nil] firstObject];
    [schedule initDate];
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


    [schedule addLessons:self.lessons delegate:self];
    self.scheduleView = schedule;
}


- (void)initNavigationBar
{
    [self setTitle:@"课程表"];

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

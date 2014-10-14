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
#import "ZsndSystem.pb.h"
#import "ApiMDelClass.h"
#import "ViewController.h"
#import "iCarousel.h"
#import "ViewForIcaursel.h"
#import "AlertViewWithPassword.h"
//南理工版本课程表不需要验证码
@interface ScheduleVC ()<AlertCloseDelegate,ScheduleViewDelegate,UITextFieldDelegate,iCarouselDataSource,iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet AlertViewWithPassword *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic)  UILabel *weekNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (strong, nonatomic)  iCarousel *icarousel;
@property (strong,nonatomic)LessonDetailView* lessonDetail;
@property (strong,nonatomic)NSArray* lessonsForIcarousel;
@property (strong,nonatomic)UITextField* codeView;
@property (strong,nonatomic)NSArray* lessonList;
@property (strong,nonatomic)NSString* code;
@property (nonatomic)int isRe;
@property (nonatomic,strong)ScheduleView* scheduleView;
@property (nonatomic,strong)UIColor* currentColor;
@property (nonatomic,strong)UIView* lastView;
@property (nonatomic)CGRect frame;
@property (nonatomic)BOOL hasCode;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *addBack;
@property (strong,nonatomic)UIImageView* imgView;
@property (strong,nonatomic)NSString* lastUserId;

@property (strong, nonatomic)  UITextField *confirmCodeText;
//@property (strong, nonatomic) UIImageView *confirmCode;
@end


@implementation ScheduleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAlert];
    [self initNavigationBar];
    self.code=nil;
    self.hasCode=NO;
    self.schIdField.text=[ToolUtils getJWID]==nil?@"":[ToolUtils getJWID];
    self.passwordField.text = [ToolUtils getJWPassword]==nil?@"":[ToolUtils getJWPassword];
   //    [self loadLast];
    self.isRe=0;
    [self addTitleView];
    self.icarousel = [[iCarousel alloc]initWithFrame:CGRectMake(20, 120, 280, 200)];
    [self.view addSubview:self.icarousel];
    [self.icarousel setHidden:YES];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:)name:UITextFieldTextDidChangeNotification object:self.schIdField];
}
- (void)viewDidAppear:(BOOL)animated
{
    if ([ToolUtils getScheduleAuto]==NO) {
        [self.maskView setHidden:NO];
        [self addMask];
        [self.alertView setHidden:NO];
        if ([ToolUtils getJWID]==nil||[ToolUtils getJWID].length==0) {
            [self.addBack setHidden:YES];
            [self.addButton setHidden:YES];
        }
    } else {
        //        if ([[self.schIdField.text uppercaseString] hasPrefix:@"MG"]) {
        //            [self load:self selecter:@selector(disposMessage:) code:nil account:@"mg......."  password:@"....."];
        //        }
        [self loadLast];
        [self getCurrentWeek];
    }
}

- (void)getCurrentWeek
{
    if ([ToolUtils offLine]) {
        return;
    }
    [self load:self selecter:@selector(disposMessage:)];
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
-(UpdateOne*)load:(id)delegate selecter:(SEL)select   {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MWeek" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}

//
//- (void)getCode
//{
//    [self.confirmCode setImage:[UIImage imageNamed:@"news_loading"]];
//    [[ApisFactory getApiMCardInfo]load:self selecter:@selector(disposeMessage:) code:nil account:@"111" password:@"111" isV:0 isReInput:self.isRe];
//    [self load:self selecter:@selector(disposeMessage:) code:nil account:@"1" password:@"1"];
//}


- (void)initAlert
{
    self.alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertViewWithPassword" owner:self options:nil] objectAtIndex:0];
    CGRect frame = CGRectMake((self.view.bounds.size.width-261)/2.0, (self.view.bounds.size.height-320)/2.0, 261, 257);
    self.alertView.frame = frame;
    self.frame = frame;
    [self.view addSubview:self.alertView];
    [self.alertView setHidden:YES];
    self.schIdField =self.alertView.schIdField;
    self.schIdField.delegate = self;
    self.autoSwitch = self.alertView.autoSwitch;
    self.passwordField = self.alertView.passwordField;
    self.schIdField.delegate = self;
    self.passwordField.delegate = self;
    self.searchButton = self.alertView.searchBt;
    [self.alertView.searchBt addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView.closeBt addTarget:self action:@selector(cancelAlert:) forControlEvents:UIControlEventTouchUpInside];
}

//
//- (void)textFieldDidChange:(NSNotification *)note
//{
//    if ([[self.schIdField.text uppercaseString] hasPrefix:@"MG"]&&self.codeView==nil) {
//        [self load:self selecter:@selector(disposMessage:) code:nil account:@"Mg10000000" password:@"123456"];
//    } else if (![[self.schIdField.text uppercaseString] hasPrefix:@"MG"]){
//        if (self.hasCode) {
//            [self removeCode];
//        }
//    }
//}


//返回时重新加载
- (void)viewWillAppear:(BOOL)animated
{
    if ([ToolUtils getJWID].length>0) {
        [self loadLast];
    }
}

//标题栏
- (void)addTitleView
{
    self.titleView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:self options:nil] firstObject];
    [self.navigationItem setTitleView:self.titleView];
    self.weekNumLabel = self.titleView.subtitleLabel;
    [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",[ToolUtils getCurrentWeek]]];
}

//重新加载
- (void)loadLast
{
    if ([ToolUtils getJWID]==nil) {
        return;
    }
    [self loadSavedLesson];
    //    if (!self.offline) {
    //        ApiMScheduleAuto* scheduleAuto = [[ApiMScheduleAuto alloc]init];
    //        [scheduleAuto load:self selecter:@selector(disposMessage:) account:[ToolUtils getJWID]];
    //
    //    }
}




//加载缓存课表
- (void)loadSavedLesson
{
    NSArray* lessons = [ToolUtils getMySchedule];
    if (lessons) {
        NSMutableArray* lessonList = [[NSMutableArray alloc]init];
        for (NSDictionary* dic in lessons) {
            ScheduleLesson* each_lesson = [[ScheduleLesson alloc]init];
            [each_lesson loadDic:dic];
            [lessonList addObject:each_lesson];
        }
        [self.scheduleView removeFromSuperview];
        self.lessons=lessonList;
        
        ScheduleView* schedule = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleView" owner:self options:nil] firstObject];
        [schedule initDate];
        CGRect frame = CGRectMake(0, 0, 320, 750);
        schedule.frame = frame;
        self.scrollView.contentSize = CGSizeMake(320, 750);
        [self.scrollView addSubview:schedule];
        [schedule addLessons:self.lessons delegate:self];
        self.scheduleView = schedule;
    }
    [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",  [ToolUtils getCurrentWeek]]];
    
}





//从教务处读取课表
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
        [self load:self selecter:@selector(disposMessage:) code:self.codeView.text account:self.schIdField.text password:self.passwordField.text] ;
        return;
    }
    if (self.lastUserId!=nil&&![self.lastUserId isEqualToString:self.schIdField.text]) {
        self.isRe=1;
    }
    if ([[ToolUtils getJWID] isEqualToString:self.schIdField.text]) {
        ApiMScheduleAuto* scheduleAuto = [[ApiMScheduleAuto alloc]init];
        [scheduleAuto load:self selecter:@selector(disposMessage:) account:[ToolUtils getJWID]];
    } else {
        [self load:self selecter:@selector(disposMessage:) code:self.codeView.text account:self.schIdField.text password:self.passwordField.text] ;
        
    } 
    
    
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
    [array addObject:[NSString stringWithFormat:@"isV=%d",[ToolUtils getIsVeryfy]]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MSchedule" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}

//回调函数
- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MSchedule"]) {
                       MClassList_Builder* classList = (MClassList_Builder*)[son getBuild];
            if (classList.week!=0||classList.classList.count>0) {
                [self.addButton setHidden:NO];
                [self.addBack setHidden:NO];
                self.isRe=1;
                [self closeAlert];
                self.lastUserId = self.schIdField.text;
                if (self.autoSwitch.isOn) {
                    [ToolUtils setScheduleAuto:YES];
                    [ToolUtils setJWPassword:self.passwordField.text];
                    [ToolUtils setJWId:self.schIdField.text];
                } else{
                    [ToolUtils setScheduleAuto:NO];
                    [ToolUtils setJWPassword:self.passwordField.text];
                    [ToolUtils setJWId:self.schIdField.text];
                }
                [ToolUtils setCurrentWeek:classList.week];
                [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",classList.week]];
                self.lessonList = classList.classList;
                [self loadSchedule];
                [ToolUtils setIsVeryfy:1];
            }
            else if (classList.img.length>0) {
                if (self.imgView)
                {
                [ToolUtils showMessage:@"信息输入错误"];
                }
                [self removeCode];
                [self addCode:classList.img];
            } else {
                [ToolUtils showMessage:@"教务处没有该学期课表,请登录教务处网站确认或请点击+号自动添加"];
                [self cancelAlert:nil];
            }
            
        } else if ([[son getMethod]isEqualToString:@"MScheduleAuto"]){
            MClassList_Builder* classList = (MClassList_Builder*)[son getBuild];
            [self.weekNumLabel setText:[NSString stringWithFormat:@"第%d周",classList.week]];
            if (self.autoSwitch.isOn) {
//                [ToolUtils setScheduleAuto:YES];
//                [ToolUtils setJWPassword:self.passwordField.text];
//                [ToolUtils setJWId:self.schIdField.text];
            } else{
                [ToolUtils setScheduleAuto:NO];
//                [ToolUtils setJWPassword:self.passwordField.text];
//                [ToolUtils setJWId:self.schIdField.text];
            }
            self.lastUserId = [ToolUtils getJWID];
            [ToolUtils setCurrentWeek:classList.week];
            self.lessonList = classList.classList;
            [self loadSchedule];
            [self cancelAlert:nil];
        } else if ([[son getMethod]isEqualToString:@"MDelClass"]){
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            [ToolUtils showMessage:ret.msg];
            [self closeAlert];
            [self loadLast];
        }
            else if ( [[son getMethod]isEqualToString:@"MWeek"])
        {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            [ToolUtils setCurrentWeek:ret.code];
            [self loadSavedLesson];
        }

    }
//    } else if ([[son getMsg]hasPrefix:@"信息"]      &&  self.imgView!=nil )
//    {
//        [self load:self selecter:@selector(disposMessage:) code:nil account:self.schIdField.text   password:self.passwordField.text];
//
//    }
        else {
            [self removeCode];
        [super disposMessage:son];
    }

}
- (void)removeCode
{
    [self.codeView setHidden:YES];
    [self.codeView removeFromSuperview];
    self.codeView = nil;
    [self.imgView removeFromSuperview];
    [self.imgView setHidden:YES];
    self.searchButton.transform = CGAffineTransformMakeTranslation(0, 0);
    

}
//添加验证码
- (void)addCode:(NSData*)img
{
    self.hasCode = YES;
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
    self.imgView = imgView;

}


#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
        [UIView animateWithDuration:0.3f animations:^{
            
            CGFloat offset= self.frame.origin.y+self.frame.size.height-(self.view.bounds.size.height-216);
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -offset);
        }         ];


}

//课程详细初始化
- (void) initLessonDetail
{
    self.lessonDetail = [[[NSBundle mainBundle] loadNibNamed:@"LessonDetailView" owner:self options:nil] firstObject];
//    [self.lessonDetail setFrame:frame];
    [self.lessonDetail setClipsToBounds:YES];
    [self.lessonDetail setHidden:YES];
    [self.lessonDetail setMydelegate:self];
}

#pragma mark showScheduleDelegate
- (void)showSchedule:(ScheduleLesson *)lesson
{
    [self.lessonDetail removeFromSuperview];
    CGFloat initY = self.view.bounds.size.height==480?70:100;
    CGRect frame = CGRectMake(30, initY, 260, 219);
    [self.icarousel setHidden:YES];
    [self initLessonDetail];
    self.lessonDetail.frame = frame;
    [self.lessonDetail setLesson:lesson];
    [self.lessonDetail removeFromSuperview];
    self.lessonDetail.frame = self.lessonDetail.adjustFrame;
//    [self.view addSubview:self.lessonDetail];
    [self.lessonDetail setId:lesson.id];
    [self.view addSubview:self.lessonDetail];
    [self.lessonDetail setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}
- (void)showSchedules:(NSArray *)lessons color:(UIColor *)color
{
    
    ScheduleLesson* grayLesson;
    for (ScheduleLesson* lesson in lessons)
    {
        NSArray* busyweeks = [lesson.busyweeks componentsSeparatedByString:@","];
        BOOL has = NO;
        for (NSString* week in busyweeks) {
            if (week.integerValue == [ToolUtils getCurrentWeek]) {
                has = YES;
                break;
            }
        }
        if (!has)
        {
            grayLesson = lesson;
        }
    }
    NSMutableArray* arr = [[NSMutableArray alloc]initWithArray:lessons];
    if (grayLesson)
    {
        [arr removeObject:grayLesson];
        [arr addObject:grayLesson];
        
    }
    NSSet *set = [NSSet setWithArray:arr];
    self.lessonsForIcarousel = [set allObjects];;
    self.currentColor = color;
    ((iCarousel*)self.icarousel).delegate = self;
    [self.icarousel setBounces:NO];
    self.icarousel.perspective=-0.0095;
    self.icarousel.dataSource = self;
    self.icarousel.type = iCarouselTypeCoverFlow;
    [self.icarousel reloadData];
    [self.icarousel setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

//加载课程表界面
- (void)loadSchedule
{
    if (self.scheduleView!=nil) {
        [self.scheduleView removeFromSuperview];
    }
    ScheduleView* schedule = [[[NSBundle mainBundle] loadNibNamed:@"ScheduleView" owner:self options:nil] firstObject];
    [schedule initDate];
    CGRect frame = CGRectMake(0, 0, 320, 750);
    schedule.frame = frame;
    self.scrollView.contentSize = CGSizeMake(320, 750);
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
        lesson.id = each_class.id;
        lesson.busyweeks = each_class.busyweeks;
        [schedules addObject:lesson];
        [canSaveLessons addObject:[lesson getDic]];
    }
    self.lessons= schedules;
    [ToolUtils setMySchedule:canSaveLessons];


    [schedule addLessons:self.lessons delegate:self];
    self.scheduleView = schedule;
}


//初始化nav
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


//登录窗口
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
    
    [self.icarousel setHidden:YES];
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    [self.codeView resignFirstResponder];
    [self.schIdField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.maskView setHidden:YES];
    [self.alertView setHidden:YES];
    [self.lessonDetail setHidden:YES];
    [super removeMask];
    
}

//添加课程
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController* nextVC = (ViewController*)[segue destinationViewController];
    nextVC.account = self.schIdField.text;
}
- (IBAction)addLesson:(id)sender {
    [self performSegueWithIdentifier:@"addLesson" sender:nil];
}

//删除课程
- (void)deleteLesson:(NSString *)id
{
    [self cancelAlert:nil];
    //    [self waiting:@"正在删除"];
    NSDictionary* removedDic = nil;
    NSMutableArray* arr = [[NSMutableArray alloc]initWithArray:[ToolUtils getMySchedule]];
    for (NSDictionary* dic in arr)
    {
        if ([[dic objectForKey:@"id"]isEqualToString:id])
        {
            removedDic = dic;
            break;
        }
    }
    if (removedDic)
    {
        [arr removeObject:removedDic];
    }
    [ToolUtils setMySchedule:arr];
    [self loadSavedLesson];
    //    ApiMDelClass* api = [[ApiMDelClass alloc]init];
    //    [api load:self selecter:@selector(disposMessage:) id:id];
    
}



#pragma mark -icaursel
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.lessonsForIcarousel.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    ViewForIcaursel* view = [[[NSBundle mainBundle] loadNibNamed:@"ViewForIcourse" owner:self options:nil] firstObject];
    
    if (index==carousel.currentItemIndex) {
        self.lastView = view;
        [view setBackgroundColor:self.currentColor];
        [view setAlpha:0.85];
    } else {
        [view setBackgroundColor:[UIColor blackColor]];
        [view setAlpha:0.5];
    }
    
    ScheduleLesson* lesson = [self.lessonsForIcarousel objectAtIndex:index];
    NSArray* busyweeks = [lesson.busyweeks componentsSeparatedByString:@","];
    BOOL has = NO;
    for (NSString* week in busyweeks) {
        if (week.integerValue == [ToolUtils getCurrentWeek]) {
            has = YES;
        }
    }
    if (!has)
    {
        [view setBackgroundColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]];
        [view setAlpha:0.85];
        [view setTag:-1];
    } else {
        [view setTag:1];
    }
    
    
    [view.LessonNameLabel setText:lesson.name];
    view.LessonNameLabel.verticalAlignment = VerticalAlignmentMiddle;
    [view.locationLabel setText:lesson.location];
    view.frame = CGRectMake(30, 5, 134, 195);
    return view;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    [self removeMask];
    ScheduleLesson* selectedLesson = [self.lessonsForIcarousel objectAtIndex:index];
    [self showSchedule:selectedLesson];
}
- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 0;
}

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel
{
    [self.lastView setBackgroundColor:[UIColor blackColor]];
    [self.lastView setAlpha:0.5];
    if (carousel.currentItemView.tag!=-1)
    {
        [carousel.currentItemView setBackgroundColor:self.currentColor];
        [carousel.currentItemView setAlpha:0.85];
    } else {
        [carousel.currentItemView setBackgroundColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]];
        [carousel.currentItemView setAlpha:0.85];
        
    }
    self.lastView = carousel.currentItemView;
    NSLog(@"update");
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return self.lessonsForIcarousel.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 160;
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return NO;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.schIdField) {
        if (range.location ==0)
        {
            [self removeCode];
        }
    }
    return YES;
}

@end

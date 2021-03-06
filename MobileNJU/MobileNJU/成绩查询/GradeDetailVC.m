//
//  GradeDetailVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GradeDetailVC.h"
#import "GradeCell.h"
#import "GPAView.h"
#import "AlertCloseDelegate.h"
#import "GradeCellChooseDelegate.h"
#import "ZsndSystem.pb.h"
#import "AlertViewWithPassword.h"
@interface GradeDetailVC ()<UITableViewDelegate,UITableViewDataSource,AlertCloseDelegate,UITextFieldDelegate,GradeCellChooseDelegate>
@property (strong, nonatomic) UITextField *schIdTextField;
@property (nonatomic,strong)GPAView* gpaView;
@property (strong, nonatomic)  AlertViewWithPassword *alertView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (strong, nonatomic)  UISwitch *autoSwitch;
@property (strong, nonatomic)  UITextField *passwordTextField;
@property (strong,nonatomic)UITextField* codeField;
@property (strong,nonatomic)NSArray* gradeList;
@property (strong, nonatomic)UIButton *searchButton;
@property (strong,nonatomic)NSMutableDictionary* LessonChooseDic;
@property (nonatomic)CGRect frame;
@property (nonatomic)int isRe;
@property (nonatomic,strong)UIImageView* imgView;
@end

@implementation GradeDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAlert];
    [self initNavigationBar];
    [self.schIdTextField setDelegate:self];
    [self.passwordTextField setDelegate:self];
    self.gpaView = [[[NSBundle mainBundle] loadNibNamed:@"GPAView" owner:self options:nil] firstObject];
    [self.gpaView setFrame:CGRectMake(30, 50, 260, 200)];
    [self.view addSubview:self.gpaView];
    [self.gpaView setDelegate:self];
    [self.tableView setAllowsSelection:NO];
    [self loadSavedState];
    self.LessonChooseDic = [[NSMutableDictionary alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:)name:UITextFieldTextDidChangeNotification object:self.schIdTextField];

    // Do any additional setup after loading the view.
}

- (void)initAlert
{
    self.alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertViewWithPassword" owner:self options:nil] objectAtIndex:0];
    CGRect frame = CGRectMake((self.view.bounds.size.width-261)/2.0, (self.view.bounds.size.height-320)/2.0, 261, 257);
    self.alertView.frame = frame;
    self.frame = frame;
    [self.view addSubview:self.alertView];
    [self.alertView setHidden:YES];
    self.schIdTextField =self.alertView.schIdField;
    self.schIdTextField.delegate = self;
    self.autoSwitch = self.alertView.autoSwitch;
    self.passwordTextField = self.alertView.passwordField;
    self.schIdTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.alertView.searchBt addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView.closeBt addTarget:self action:@selector(cancelAlert:) forControlEvents:UIControlEventTouchUpInside];
    self.isRe = 0 ;
    self.searchButton = self.alertView.searchBt;
}


- (void)textFieldDidChange:(NSNotification *)note
{
    NSLog(@"%@",self.schIdTextField.text);
    if ([self.schIdTextField.text hasPrefix:@"Mg"]&&self.codeField==nil) {
        [self load:self selecter:@selector(disposMessage:) code:nil account:@"Mg10000000" password:@"123456"];
    } else if (![self.schIdTextField.text hasPrefix:@"Mg"]){
        [self removeCode];
    }

}

- (IBAction)search:(id)sender {
    
    
    [self.schIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.codeField resignFirstResponder];
    
    if (self.schIdTextField.text.length==0) {
        [ToolUtils showMessage:@"学号不得为空"];
        return;
    } else if (self.schIdTextField.text.length==0){
        [ToolUtils showMessage:@"密码不得为空"];
        return;
    } else if (self.codeField!=nil&&self.codeField.text.length==0)
    {
        [ToolUtils showMessage:@"验证码不得为空"];
        return;
    }
    [self waiting:@"正在加载"];
    [self load:self selecter:@selector(disposMessage:) code:self.codeField==nil?nil:self.codeField.text account:self.schIdTextField.text password:self.passwordTextField.text];
}

-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    if (code!=nil) {
        [array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
    }
    [array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
    [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
    [array addObject:[NSString stringWithFormat:@"isV=%d",[ToolUtils getIsVeryfy]]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MTermList" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}

- (void)removeCode
{
    [self.codeField setHidden:YES];
    [self.codeField removeFromSuperview];
    [self.codeField setText:@""];
    self.codeField = nil;
    [self.imgView removeFromSuperview];
    [self.imgView setHidden:YES];
    self.searchButton.transform = CGAffineTransformMakeTranslation(0, 0);
    
    
}



- (void)initNavigationBar
{
    [self setTitle:@"成绩查询"];
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"self_right_barButton"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 40, 36);
    button.frame = frame;
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* selfItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    //    [selfItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfItem;
    
}

- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        
        if ([[son getMethod]isEqualToString:@"MTermList"]) {
            MTermList_Builder* termList = (MTermList_Builder*)[son getBuild];
            if (termList.termList.count==0) {
                [self addCode:termList.img];
            } else {
                self.password  = self.passwordTextField.text;
                self.account = self.schIdTextField.text;
                if (self.autoSwitch.isOn) {
                    [ToolUtils setJWPassword:self.passwordTextField.text];
                    [ToolUtils setJWId:self.schIdTextField.text];
                } else {
                    [ToolUtils setJWPassword:@""];
                    [ToolUtils setJWId:@""];
                }
                NSMutableArray* termArray = [[NSMutableArray alloc]init];
                for (MTerm* term in termList.termList) {
                    NSArray* arr = [[NSArray alloc]initWithObjects:term.name,term.url,nil];
                    [termArray addObject:arr];
                }
                [ToolUtils setTermList:termArray];
                [self cancelAlert:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else if([[son getMethod]isEqualToString:@"MGradeSearch"])
        {
            MCourseList_Builder* courseList = (MCourseList_Builder*)[son getBuild];
            self.gradeList = courseList.courseList;
            [self.tableView reloadData];
        }
    } else {
        [super disposMessage:son];
    }
}



- (void)loadSavedState
{
    [self waiting:@"正在加载"];
    [self.passwordTextField setText:self.password];
    [self.schIdTextField setText:self.account];
#warning api更改，原有api错误，需要更正
    [self load:self selecter:@selector(disposMessage:) url:self.term account:self.account password:self.password];
//    [[ApisFactory getApiMGradeSearch] load:self selecter:@selector(disposMessage:) url:self.term];
}

-(UpdateOne*)load:(id)delegate selecter:(SEL)select  url:url account:(NSString*)account password:(NSString*)password {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"url=%@",url==nil?@"":url]];
    [array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
    [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MGradeSearch" params:array  delegate:delegate selecter:select];
    [updateone setShowLoading:NO];
    [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
    return updateone;
}


- (void)showAlert
{
    if ([self.schIdTextField.text hasPrefix:@"Mg"]) {
        [self load:self selecter:@selector(disposMessage:) code:nil account:@"Mg10000000" password:@"123456"];
    }
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}


- (IBAction)calculateGpa:(id)sender {
    NSMutableArray* selectedLessons = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < self.gradeList.count; i++) {
        GradeCell* cell = (GradeCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.isTicked) {
            [selectedLessons addObject:[self.gradeList objectAtIndex:i]];
        }
    }
    
    [self.gpaView setLessonList:selectedLessons];
    [self.gpaView setHidden:NO];
    
    [self.maskView setHidden:NO];
    [self addMask];
}

- (void)closeAlert{
    [self cancelAlert:nil];
}

- (IBAction)cancelAlert:(id)sender {
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    [self.gpaView setHidden:YES];
    [self.alertView setHidden:YES  ];
    [self.maskView setHidden:YES];
    [self removeMask];
    [self.schIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}



#pragma mark textFieldDelegate

- (void)addCode:(NSData*)img
{
    
    self.searchButton.transform = CGAffineTransformMakeTranslation(0, 60);
    
    self.codeField = [[UITextField alloc]init];
    self.codeField.delegate = self;
    self.codeField.borderStyle = self.schIdTextField.borderStyle;
    self.codeField.placeholder = @"请输入验证码";
    CGRect codeFrame = self.passwordTextField.frame;
    codeFrame.size.width = codeFrame.size.width/2;
    codeFrame.origin.y = codeFrame.origin.y+codeFrame.origin.y-self.schIdTextField.frame.origin.y+self.autoSwitch.frame.size.height;
    self.codeField.frame = codeFrame;
    [self.alertView addSubview:self.codeField];
    codeFrame.origin.x = codeFrame.size.width+20;
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:codeFrame];
    [imgView setImage:[UIImage imageWithData:img]];
    [self.alertView addSubview:imgView];
    self.imgView = imgView;
}
#pragma mark textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        [self.view bringSubviewToFront:self.alertView];
        self.alertView.transform = CGAffineTransformMakeTranslation(0, -50);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.alertView];
    }];
    //    [textField becomeFirstResponder];
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gradeList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}




#warning 超过6个字符就要换行了
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"grade";
    GradeCell *cell = (GradeCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell addLineForLabel];
    [cell addBorder];
    MCourse* course = [self.gradeList objectAtIndex:indexPath.row];
    [cell.lessonNameLabel setText:course.name ];
    switch (course.type) {
        case 1:
            cell.lessonTypeLabel.text = @"核心";
            break;
        case 2:
            cell.lessonTypeLabel.text = @"平台";
            break;
        case 3:
            cell.lessonTypeLabel.text = @"通修";
            break;
        case 0:
            cell.lessonTypeLabel.text =@"选修";
            break;
        case 4:
            cell.lessonTypeLabel.text = @"A类";
            break;
        case 5:
            cell.lessonTypeLabel.text =@"B类";
            break;
        case 6:
            cell.lessonTypeLabel.text =@"C类";
            break;
        case 7:
            cell.lessonTypeLabel.text =@"D类";
            break;
        default:
            cell.lessonTypeLabel.text =@"选修";

            
    }
    if ([self.LessonChooseDic valueForKey:cell.lessonNameLabel.text]!=nil) {
        NSLog(@"%@",[self.LessonChooseDic valueForKey:cell.lessonNameLabel.text]);
        [cell setTick:[[self.LessonChooseDic valueForKey:cell.lessonNameLabel.text] isEqualToString:@"YES"]?YES:NO];
    }
    [cell setDelegate:self];
    [cell.scoreLabel setText:course.grade];
    [cell.creditLabel setText:course.point];
    return cell;
}

#pragma mark gradeCellDelegate
- (void)chooseLesson:(NSString*)select lesson:(NSString *)lesson
{
    NSLog(@"%@  %@",lesson,select);
    [self.LessonChooseDic setValue:select forKey:lesson];
}

@end

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
@interface GradeDetailVC ()<UITableViewDelegate,UITableViewDataSource,AlertCloseDelegate,UITextFieldDelegate,GradeCellChooseDelegate>
@property (weak, nonatomic) IBOutlet UITextField *schIdTextField;
@property (nonatomic,strong)GPAView* gpaView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong,nonatomic)UITextField* codeField;
@property (strong,nonatomic)NSArray* gradeList;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (strong,nonatomic)NSMutableDictionary* LessonChooseDic;
@end

@implementation GradeDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    // Do any additional setup after loading the view.
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

- (IBAction)search:(id)sender {
    [self.schIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.codeField resignFirstResponder];
    [self waiting:@"正在加载"];
#warning api更新
//    [[ApisFactory getApiMTermList]load:self selecter:@selector(disposMessage:) code:nil account:self.schIdTextField.text password:self.passwordTextField.text];
    
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
    
    
}
#pragma mark textFieldDelegate
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
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
            [cell setTick:YES];
            break;
        case 2:
            cell.lessonTypeLabel.text = @"平台";
            [cell setTick:YES];
            break;
        case 3:
            cell.lessonTypeLabel.text = @"通修";
            [cell setTick:YES];
            break;
        default:
            cell.lessonTypeLabel.text =@"选修";
            [cell setTick:NO];
            break;
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

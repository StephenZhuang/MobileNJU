//
//  GradeVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GradeVC.h"
#import "GradeDetailVC.h"
#import "ZsndSystem.pb.h"
#import "TermCell.h"
#import "AlertViewWithPassword.h"
@interface GradeVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong,nonatomic)NSArray* greenList;
@property (strong,nonatomic)NSArray* redList;
@property (strong,nonatomic)NSArray* blueList;
@property (strong, nonatomic)  AlertViewWithPassword *alertView;
@property (strong, nonatomic)  UITextField *schIdTextField;
@property (strong, nonatomic)  UITextField *passwordTextField;
@property (strong,nonatomic)UITextField* codeField;
@property (strong, nonatomic)  UIButton *searchButton;
@property (strong, nonatomic)  UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSString* account;
@property(strong,nonatomic)NSString* password;
@property(nonatomic)int isRe;
@property (nonatomic,strong) UIImageView* imgView;
@property (nonatomic)CGRect frame;
@property (nonatomic)BOOL hasLogin;
@end

@implementation GradeVC

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
    [self initAlert];
    [self initNavigationBar];
    [self loadColor];
    self.isRe=0;
    self.hasLogin = NO;
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:)name:UITextFieldTextDidChangeNotification object:self.schIdTextField];
    if (!self.termList) {
        self.termList = [ToolUtils getTermList];
    }
    [self loadSavedState];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.termList) {
        self.termList = [ToolUtils getTermList];
    }
    [self loadSavedState];
}


- (void)loadSavedState
{
    
    [self.schIdTextField setText:[ToolUtils getJWID]==nil?@"":[ToolUtils getJWID]];
    [self.passwordTextField setText:[ToolUtils getJWPassword]==nil?@"":[ToolUtils getJWPassword]];
    if (![self.schIdTextField.text isEqualToString:@""]&&![self.passwordTextField.text isEqualToString:@""]&&!self.hasLogin&&![ToolUtils offLine]) {
        [self search:nil];
    } else if (!self.hasLogin&&![ToolUtils offLine]){
        [self showAlert];
    }
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<self.termList.count) {
        NSArray* term = [self.termList objectAtIndex:indexPath.row];
        NSString* str = [term objectAtIndex:1];
        if (str.length>0) {
            [self performSegueWithIdentifier:@"gradeDetail" sender:[term objectAtIndex:1]];
        }
    } else if (![ToolUtils offLine]){
        [self showAlert];
    }
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
    self.searchButton = self.alertView.searchBt;
}


//- (void)textFieldDidChange:(NSNotification *)note
//{
//    NSLog(@"%@",self.schIdTextField.text);
//    if ([[self.schIdTextField.text uppercaseString] hasPrefix:@"MG"]&&self.codeField==nil) {
//        [self load:self selecter:@selector(disposMessage:) code:nil account:@"Mg10000000" password:@"123456"];
//    } else if (![[self.schIdTextField.text uppercaseString] hasPrefix:@"MG"]){
//        [self removeCode];
//    }
//}
- (void)removeCode
{
    
    
    [self.codeField setHidden:YES];
    [self.codeField removeFromSuperview];
    [self.codeField setText:@""];
    self.codeField = nil;
    [self.imgView removeFromSuperview];
    [self.imgView setHidden:YES];
    self.imgView = nil;
    self.searchButton.transform = CGAffineTransformMakeTranslation(0, 0);
    
    
}


- (IBAction)search:(id)sender {
    if (sender!=nil) {
        self.isRe=1;
    } else {
        [self.maskView setHidden:NO];
        [self addMask];
    }
    [self.schIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.codeField resignFirstResponder];
    
    if (self.schIdTextField.text.length==0) {
        [ToolUtils showMessage:@"学号不得为空"];
        return;
    } else if (self.passwordTextField.text.length==0){
        [ToolUtils showMessage:@"密码不得为空"];
        return;
    } else if (self.codeField!=nil&&self.codeField.text.length==0)
    {
        [ToolUtils showMessage:@"验证码不得为空"];
        return;
    }
    if (sender!=nil) {
        [self waiting:@"正在登录"];
    }
    [self load:self selecter:@selector(disposMessage:) code:(self.codeField==nil)?nil:self.codeField.text account:self.schIdTextField.text password:self.passwordTextField.text];
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

- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MTermList"]) {
            [ToolUtils setIsVeryfy:1];
            MTermList_Builder* termList = (MTermList_Builder*)[son getBuild];
            
            if (termList.img.length>0&&termList.termList.count==0) {
                if (self.alertView.isHidden&&!self.hasLogin) {
                    [self.alertView setHidden:NO];
                }
                
                if (self.imgView)
                {
                    [ToolUtils showMessage:@"信息输入错误"];
                }
                [self removeCode];
                [self addCode:termList.img];
                
            } else if (termList.termList.count>0){
                self.hasLogin = YES;
                self.isRe=1;
                self.password  = self.passwordTextField.text;
                self.account = self.schIdTextField.text;
                    [ToolUtils setJWPassword:self.passwordTextField.text];
                    [ToolUtils setJWId:self.schIdTextField.text];
                self.hasUpdate = YES;
                [self cancelAlert:nil];
                NSMutableArray* termArray = [[NSMutableArray alloc]init];
                for (MTerm* term in termList.termList) {
                    NSArray* arr = [[NSArray alloc]initWithObjects:term.name,term.url,nil];
                    [termArray addObject:arr];
                }
                [ToolUtils setTermList:termArray];
                self.termList = termArray;
                [self.tableView reloadData];
            }
        }
    }
    else {
        [self removeCode];
        [super disposMessage:son];
    }
}
- (void)loadColor
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.redList = [data objectForKey:@"redList"];
    self.greenList = [data objectForKey:@"greenList"];
    self.blueList = [data objectForKey:@"blueList"];
    
}

- (void)initNavigationBar
{
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"self_right_barButton"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 40, 36);
    button.frame = frame;
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* selfItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    //    [selfItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfItem;
    [self setTitle:@"成绩查询"];
}

- (IBAction)cancelAlert:(id)sender {
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    [self.tableView setUserInteractionEnabled:YES];
//    [self.codeField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.schIdTextField resignFirstResponder];
    [self.alertView setHidden:YES  ];
    [self.maskView setHidden:YES];
    [self removeMask];
}




- (void)showAlert
{
    
    [self.tableView setUserInteractionEnabled:NO];
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}





#pragma mark textFieldDelegate

- (void)addCode:(NSData*)img
{
    self.isRe=0;
    if (self.imgView!=nil) {
        [self.imgView setImage:[UIImage imageWithData:img]];
    } else {
        self.alertView.searchBt.transform = CGAffineTransformMakeTranslation(0, 60);
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
    
}
#pragma mark textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        CGFloat offset= self.frame.origin.y+self.frame.size.height-(self.view.bounds.size.height-216);
        self.alertView.transform = CGAffineTransformMakeTranslation(0, -offset);

    }];
    
}




-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    } ];

    return YES;
}



#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.termList.count>0) {
        return self.greenList.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat windowHeight = self.view.window.frame.size.height;
    return windowHeight==480?50:60;
}


///*
// 进入屏幕后开启动画
// */
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performBounceUpAnimationOnView:cell duration:0.3f delay:indexPath.row*0.2f];
//
//}
//
//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TermCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"term"];
    cell.isShow = 0;
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:[[self.redList objectAtIndex:indexPath.row] intValue]/255.0
                                            green:[[self.greenList objectAtIndex:indexPath.row] intValue]/255.0
                                             blue:[[self.blueList objectAtIndex:indexPath.row] intValue]/255.0
                                            alpha:1]];
    
    if (indexPath.row<self.termList.count) {
        [cell.termLabel setText:[[self.termList objectAtIndex:indexPath.row
                                  ] firstObject]];
    } else {
        [cell.termLabel setText:@""];
    }
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:[[self.redList objectAtIndex:indexPath.row] intValue]/255.0
                                                                  green:[[self.greenList objectAtIndex:indexPath.row] intValue]/255.0
                                                                   blue:[[self.blueList objectAtIndex:indexPath.row] intValue]/255.0
                                                                  alpha:1];
    
    return cell;
}

#pragma mark 动画
- (void)performBounceUpAnimationOnView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    [view setHidden:NO];
    // Start
        view.transform = CGAffineTransformMakeTranslation(0, 600);
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            view.transform = CGAffineTransformMakeTranslation(0, 0);
 
        } completion:^(BOOL finished) {
            
        }];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.schIdTextField) {
        if (range.location ==0)
        {
            [self removeCode];
        }
    }
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self cancelAlert:nil];
    if ([[segue identifier] isEqualToString:@"gradeDetail"]) {
        GradeDetailVC* nextVC = (GradeDetailVC*)segue.destinationViewController;
        [nextVC setTerm:sender];
        [nextVC setPassword:self.password];
        [nextVC setAccount:self.account];
        [nextVC setLastVC:self];
        if (self.hasUpdate) {
            nextVC.shoudLoad = @"YES";
        }
    }
}


@end

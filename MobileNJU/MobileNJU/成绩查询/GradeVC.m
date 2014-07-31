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
@interface GradeVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong,nonatomic)NSArray* greenList;
@property (strong,nonatomic)NSArray* redList;
@property (strong,nonatomic)NSArray* blueList;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UITextField *schIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong,nonatomic)UITextField* codeField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property(nonatomic,strong)NSArray* termList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSString* account;
@property(strong,nonatomic)NSString* password;
@property(nonatomic)int isV;
@property(nonatomic)int isRe;
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
    [self initNavigationBar];
    [self loadColor];
    [self loadSavedState];
    self.isV = 0;
    self.isRe=0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:)name:UITextFieldTextDidChangeNotification object:self.schIdTextField];

    
}
- (void)textFieldDidChange:(NSNotification *)note
{
    NSLog(@"%@",self.schIdTextField.text);
    if ([self.schIdTextField.text hasPrefix:@"Mg"]&&self.isV==0) {
        [self load:self selecter:@selector(disposMessage:) code:nil account:@"Mg10000000" password:@"123456"];
    }
}
- (void)loadSavedState
{
    [self.schIdTextField setText:[ToolUtils getJWID]==nil?@"":[ToolUtils getJWID]];
    [self.passwordTextField setText:[ToolUtils getJWPassword]==nil?@"":[ToolUtils getJWPassword]];
    if (![self.schIdTextField.text isEqualToString:@""]&&![self.passwordTextField.text isEqualToString:@""]) {
        [self search:nil];
    }
//    self.termList = [ToolUtils getTermList];
  
}
- (IBAction)search:(id)sender {
    
    [self.schIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.codeField resignFirstResponder];
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
    
    [array addObject:[NSString stringWithFormat:@"isV=%d",self.isV]];
    
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
            MTermList_Builder* termList = (MTermList_Builder*)[son getBuild];
            if (termList.termList.count==0) {
                if (self.alertView.isHidden) {
                    [self.alertView setHidden:NO];
                }
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
    [self.tableView setUserInteractionEnabled:YES];
    [self.codeField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.schIdTextField resignFirstResponder];;
    [self.alertView setHidden:YES  ];
    [self.maskView setHidden:YES];
    [self removeMask];
}




- (void)showAlert
{
    [self.tableView setUserInteractionEnabled:NO];
    [self.alertView setHidden:NO];
//    [self.maskView setHidden:NO];
    [self addMask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark textFieldDelegate

- (void)addCode:(NSData*)img
{
    self.isV = 1;
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

    [UIView animateWithDuration:0.3f animations:^{
        [self.view bringSubviewToFront:self.alertView];
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self.view bringSubviewToFront:self.alertView];
    }];

    return YES;
}



#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.termList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat windowHeight = self.view.window.frame.size.height;
    return windowHeight==480?50:60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* term = [self.termList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"gradeDetail" sender:[term objectAtIndex:1]];
}
/*
 进入屏幕后开启动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

        [self performBounceUpAnimationOnView:cell duration:0.3f delay:indexPath.row*0.2f];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TermCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"term"];
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:[[self.redList objectAtIndex:indexPath.row] intValue]/255.0
                                            green:[[self.greenList objectAtIndex:indexPath.row] intValue]/255.0
                                             blue:[[self.blueList objectAtIndex:indexPath.row] intValue]/255.0
                                            alpha:1]];
    
    [cell.termLabel setText:[[self.termList objectAtIndex:indexPath.row
                             ] firstObject]];
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
    }
}


@end

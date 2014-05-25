//
//  GradeVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GradeVC.h"
#import "MyAnimationBehavior.h"
@interface GradeVC ()<UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabieView;
@property (strong,nonatomic)NSArray* greenList;
@property (strong,nonatomic)NSArray* redList;
@property (strong,nonatomic)NSArray* blueList;
@property (strong,nonatomic)UIDynamicAnimator* animator;
@property (strong,nonatomic)MyAnimationBehavior* behavior;
@property (strong,nonatomic)NSMutableArray* terms;
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


- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        _animator.delegate = self;
    }
    return _animator;
}

- (MyAnimationBehavior *)behavior
{
    if (!_behavior) {
        _behavior = [[MyAnimationBehavior alloc]init];
        [self.animator addBehavior:_behavior];
    }
    return _behavior;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self loadColor];
    self.terms = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)loadColor
{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.redList = [data objectForKey:@"redList"];
    self.greenList = [data objectForKey:@"greenList"];
    self.blueList = [data objectForKey:@"blueList"];
}

- (void)viewDidAppear:(BOOL)animated{
    for (int i = 0 ; i < 8 ; i++){
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-55, self.view.bounds.size.width, 55)];
        [view setBackgroundColor:[UIColor colorWithRed:[[self.redList objectAtIndex:i] integerValue]/255.0
                                                 green:[[self.greenList objectAtIndex:i] integerValue]/255.0
                                                  blue:[[self.blueList objectAtIndex:i] integerValue]/255.0
                                                 alpha:1]];
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(283, 13, 17, 28)];
        [button setImage:[UIImage imageNamed:@"goto"] forState:UIControlStateNormal];
        [view addSubview:button];
        [self.terms addObject:view];
        [NSTimer scheduledTimerWithTimeInterval:i/2.0f target:self selector:@selector(showRow:) userInfo:[self.terms objectAtIndex:i] repeats:NO];
    }
}
- (void)initNavigationBar
{
    UIBarButtonItem* selfButton = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"self_right_barButton"] style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
    [selfButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfButton;
    [self setTitle:@"成绩查询"];
    [self setSubTitle:@"看看有木有挂科"];
}
- (void)showAlert
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (void)showRow:(NSTimer *)timer
{
    UIView* view = (UIView*)timer.userInfo;
    [self.view addSubview:view];
    [self.behavior addItem:view];
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

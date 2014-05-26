//
//  GradeVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GradeVC.h"
#import "GradeDetailVC.h"
@interface GradeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSArray* greenList;
@property (strong,nonatomic)NSArray* redList;
@property (strong,nonatomic)NSArray* blueList;
@property (weak, nonatomic) IBOutlet UIView *alertView;

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
    UIBarButtonItem* selfButton = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"self_right_barButton"] style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
    [selfButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfButton;
    [self setTitle:@"成绩查询"];
    [self setSubTitle:@"看看有木有挂科"];
}

- (IBAction)cancelAlert:(id)sender {
    [self.alertView setHidden:YES  ];
    [self.maskView setHidden:YES];
    [self removeMask];
}



- (void)showAlert
{
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
    //此处+3 只是为下方预留空间
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat windowHeight = self.view.window.frame.size.height;
    return windowHeight==480?50:60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"gradeDetail" sender:nil];
}
/*
 进入屏幕后开启动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performBounceUpAnimationOnView:cell duration:0.5f delay:indexPath.row*0.5f];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"term"];
    [cell setBackgroundColor:[UIColor colorWithRed:[[self.redList objectAtIndex:indexPath.row] intValue]/255.0
                                            green:[[self.greenList objectAtIndex:indexPath.row] intValue]/255.0
                                             blue:[[self.blueList objectAtIndex:indexPath.row] intValue]/255.0
                                            alpha:1]];
    return cell;
}


#pragma mark 动画
- (void)performBounceUpAnimationOnView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    [view setHidden:NO];
    // Start
    view.transform = CGAffineTransformMakeTranslation(0, 600);
    [UIView animateKeyframesWithDuration:duration delay:delay options:0 animations:^{
        // End
        view.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
       
    }];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"gradeDetail"]) {
        GradeDetailVC* nextVC = (GradeDetailVC*)segue.destinationViewController;
        [nextVC setTerm:@"2222"];
    }
}


@end

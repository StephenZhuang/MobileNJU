//
//  MyBaseTableViewController.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "MyBaseTableViewController.h"

#import "MainMenuViewController.h"
#import "SelfInfoVC.h"
#import "ExerciseVC.h"
#import "EcardVC.h"
#import "MyLibraryVC.h"
#import "ExerciseVC.h"
#import "WelcomeViewController.h"
#import "RDVTabBarController.h"

@interface MyBaseTableViewController ()

@end

@implementation MyBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*Show Alert*/
- (void) showAlert:(NSString*)msg
{
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] ;
    //    [alert show];
    [ProgressHUD showError:msg];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([self.navigationController.navigationBar
        respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar  setBackgroundImage:[[UIImage imageNamed:@"navigationBack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]   forBarMetrics:UIBarMetricsDefault];
        //        [self.navigationController.navigationBar setBackgroundColor:RGB(143, 60, 133)];
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [UIColor colorWithRed:1 green:1 blue:1 alpha:1], NSForegroundColorAttributeName,
                                                                         [UIColor colorWithRed:1 green:1 blue:1 alpha:1], UITextAttributeTextShadowColor,
                                                                         [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                                         UITextAttributeTextShadowOffset,
                                                                         [UIFont fontWithName:@"Helvetica" size:24.0],
                                                                         UITextAttributeFont,
                                                                         nil]];
        
        if([self.navigationController respondsToSelector:@selector(backIcons)]){
            _backIcons=[self.navigationController performSelector:@selector(backIcons)];
        }
        if([self.navigationController viewControllers].count>1){
            UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
            NSString *iconname=DEFAULTBACKICON;
            if(_backIcons!=nil && _backIcons.count>0){
                if ([self.navigationController viewControllers].count-2<_backIcons.count) {
                    iconname=[_backIcons objectAtIndex:[self.navigationController viewControllers].count-2];
                }else{
                    iconname=[_backIcons objectAtIndex:_backIcons.count-1 ];
                }
            }
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_n",iconname]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",iconname]] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
            NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
            self.navigationItem.leftBarButtonItems = myButtonArray;
        }
    }
    //    [self addTitleView];
}

- (void)addTitleView
{
    self.titleView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:self options:nil] firstObject];
    [self.navigationItem setTitleView:self.titleView];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeSelf)];
    [self.titleView.touchView addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.loginIndicator setHidden:YES];
    [self.loginIndicator removeFromSuperview];
}

-(void)closeSelf{
    if (self.loginIndicator) {
        [self.loginIndicator setHidden:YES];
        [self.loginIndicator removeFromSuperview];
    }
    if([self.navigationController viewControllers].count>0){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[self.navigationItem.leftBarButtonItems objectAtIndex:0] hidesBackButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
UIView* view;
- (void)addMask
{
    //    if (!_view) {
    [self.maskView setHidden:NO];
    CGRect frame = CGRectMake(0, -20, 0, 0);
    frame.size = self.navigationController.navigationBar.frame.size;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<7.0) {
        frame.size.height = frame.size.height+21;
    }
    frame.size.height = frame.size.height+20;
    view = [[UIView alloc]initWithFrame:frame];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [self.navigationController.navigationBar addSubview:view];
    //    } else{
    //        [view setHidden:NO];
    //    }
    
}


- (void) waiting:(NSString*)msg
{
    [self.loginIndicator removeFromSuperview];
    CGRect frame = CGRectMake(100, 100, self.view.center.x-50, self.view.center.y);
    self.loginIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    
	[self.loginIndicator setTintColor:[UIColor greenColor]];
    [self.loginIndicator setColor:[UIColor greenColor]];
    [self.navigationController.view addSubview:self.loginIndicator];
    [self.navigationController.view bringSubviewToFront:self.loginIndicator];
    [self.loginIndicator startAnimating];
    [self.loginIndicator setHidden:NO];
}

- (void)disposMessage:(Son *)son
{
    
}
- (void)removeMask
{
    [self.maskView setHidden:YES];
    [view setHidden:YES];
    [view removeFromSuperview];
}
#pragma mark -UINavigationDelegate,UINavigationBarDelegate
/*
 设置rootViewController的NavigationBar 不可见
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (
        [viewController class]==[WelcomeViewController class]||
        [viewController class] == [MainMenuViewController class]
        || [viewController class]==[SelfInfoVC class]
        || [viewController class]== [ExerciseVC class]
        || [viewController class]==[EcardVC class]
        || [viewController class]==[ExerciseVC class]
        ) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

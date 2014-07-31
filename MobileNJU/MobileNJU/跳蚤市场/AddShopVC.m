//
//  AddShopVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AddShopVC.h"
#import "PageDelegate.h"
#import "FirstPage.h"
@interface AddShopVC ()<PageDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *scrollerView;

@property (strong,nonatomic)UIView* secondPage;
@end

@implementation AddShopVC

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
//    [self addViews];
    if (self.currentPage==1) {
        self.pageControl.currentPage=1;
    }
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self scrollerView] addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self scrollerView] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self scrollerView] addGestureRecognizer:recognizer];
    
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self scrollerView] addGestureRecognizer:recognizer];
    
    
    if (self.pageControl.currentPage==0) {
        [self.firstPage initial];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightButton;

    } else {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightButton;
        
//        
//        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
//        [button setTitle:@"上一步" forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//        self.navigationItem.leftBarButtonItem = leftButton;
    }
    
    // Do any additional setup after loading the view.
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        //执行程序
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"swipe up");
        //执行程序
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        //执行程序
        if (self.pageControl.currentPage==0) {
            [self pageChange];
        }
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        NSLog(@"swipe right");
        //执行程序
        if (self.pageControl.currentPage==1) {
            [self pageChange];
        }

    }
    
}


-(void)pageChange
{
    if (self.pageControl.currentPage==0) {
        [self performSegueWithIdentifier:@"next" sender:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark- pageDelegate
- (void)showView:(UIViewController *)view
{
    [self presentViewController:view animated:YES completion:^{

    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"next"]) {
        AddShopVC* nextVC = (AddShopVC*) segue.destinationViewController;
        nextVC.currentPage = 1;
    }
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

//
//  BaseViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-21.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setTitle:(NSString*)title{
    [self.titleView setTitle:title];
}

- (void)setSubTitle:(NSString*)subTitle{
    [self.titleView setSubTitle:subTitle];
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
                                                                         [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                         nil]];
        
        if([self.navigationController respondsToSelector:@selector(backIcons)]){
            _backIcons=[self.navigationController performSelector:@selector(backIcons)];
        }
        
        if([self.navigationController viewControllers].count>1){
            UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
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
    [self addTitleView];
}

- (void)addTitleView
{
    self.titleView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:self options:nil] firstObject];
    [self.navigationItem setTitleView:self.titleView];
}

-(void)closeSelf{
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
- (void)removeMask
{
    [view setHidden:YES];
    [view removeFromSuperview];
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

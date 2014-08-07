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
#import "RDVTabBarController.h"
@interface AddShopVC ()<PageDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *scrollerView;
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
- (void)viewWillAppear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:YES];
    if ([self shoudReturn]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shoudReturn = NO;
    if (self.market==nil) {
        self.market = [[MAddMarket_Builder alloc]init];
    }
    //    [self addViews];
    if (self.currentPage==1) {
        self.secondPage.myController = self;
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
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = rightButton;
        
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
- (void)complete
{
 
    
    
    
    SecondPage* page = self.secondPage;
    if (page.typeField.text.length==0) {
        [ToolUtils showMessage:@"请选择分类"];
        return;
    }
    if (page.locationField.text.length==0) {
        [ToolUtils showMessage:@"请选择交易地点"];
        return;
    }
    if (page.phoneField.text.length+page.QQField.text.length==0) {
        [ToolUtils showMessage:@"请至少留下手机号和qq号的其中一个"];
        return;
    
    }
    if (![ToolUtils checkTel:page.phoneField.text]) {
        return;
    }
    [page.QQField resignFirstResponder];
    [page.phoneField resignFirstResponder];
    self.market.type = page.typeId;
    self.market.address = page.locationField.text;
    self.market.qq = page.QQField.text;
    self.market.phone = page.phoneField.text;
 
    
       UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddMarket" params:self.market  delegate:self selecter:@selector(disposMessage:)];
    [updateone setShowLoading:NO];
    [self waiting:@"正在发布"];
    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:self];
    
}
- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        MRet_Builder* ret = (MRet_Builder*)[son getBuild];
        [ToolUtils showMessage:ret.msg];
        self.myLast.shoudReturn=YES;
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [super disposMessage:son];
    }
}

-(void)pageChange
{
    if (self.pageControl.currentPage==0) {
        FirstPage *page = self.firstPage;
        if (page.titleField.text.length==0) {
            [ToolUtils showMessage:@"标题不能为空"];
            return;
        }
        if(page.priceFIeld.text.length==0)
        {
            [ToolUtils showMessage:@"售价不能为空"];
            return;
        }
        if(page.originPriceField.text.length==0)
        {
            [ToolUtils showMessage:@"原价不能为空"];
            return;
        }
        if(page.discriptionField.text.length<=15)
        {
            [ToolUtils showMessage:@"描述字数不得少于15字"];
            return;
        }
        if (page.photoArray.count==0)
        {
            [ToolUtils showMessage:@"请提供至少一张照片"];
            return;
        }
        if(page.priceFIeld.text.length==0)
        {
            [ToolUtils showMessage:@"售价不能为空"];
            return;
        }
        self.market.name = page.titleField.text;
        self.market.price = page.priceFIeld.text;
        self.market.priceOriginal = page.originPriceField.text;
        self.market.description = page.discriptionField.text;
        for (UIImage* img in page.photoArray) {
            [self.market addImgs:UIImagePNGRepresentation(img)];
        }
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
        nextVC.market = self.market;
        nextVC.myLast = self;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.firstPage!=nil) {
        [self.firstPage resignAll];
    } else if (self.secondPage!=nil)
    {
        [self.secondPage resignAll];
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
- (IBAction)resignAll:(id)sender {
    if (self.firstPage!=nil) {
        [self.firstPage resignAll];
    }
}

@end

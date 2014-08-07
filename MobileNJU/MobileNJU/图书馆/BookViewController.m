//
//  BookViewController.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BookViewController.h"
#import "Book.h"
#import "BookCell.h"
#import "BookDetailScrollerView.h"
#import "AlertCloseDelegate.h"
#import "BookChooseDelegate.h"
#import "BookCollectionCell.h"
#import "ZsndLibrary.pb.h"
#import "UtilMethods.h"
#import "MyLibraryVC.h"
#import "AlertViewWithPassword.h"
@interface BookViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AlertCloseDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray* books;
@property (strong, nonatomic)  AlertViewWithPassword *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic)  UITextField *schIdField;
@property (strong, nonatomic)  UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong,nonatomic)BookDetailScrollerView* bookDetail;
//@property (nonatomic)int page;
@property (nonatomic,strong)NSString* selectedBookName;
@property(nonatomic)BOOL loading;
@property (strong, nonatomic)  UISwitch *rememberSwitch;
@property (nonatomic)int isRe;
@property (nonatomic)CGRect frame;
@end

@implementation BookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAlert];
    [self initNavigationBar];
    [self initBookDetail];
    [self.passwordField setText:[ToolUtils getLibraryPassword]==nil?@"":[ToolUtils getLibraryPassword]];
    [self.schIdField setText:[ToolUtils getLibraryId]==nil?@"":[ToolUtils getLibraryId]];
    self.loading=NO;
    self.isRe=0;
    self.books = [[NSMutableArray alloc]init];
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
    self.schIdField =self.alertView.schIdField;
    self.schIdField.delegate = self;
    self.rememberSwitch = self.alertView.autoSwitch;
    self.passwordField = self.alertView.passwordField;
    self.schIdField.delegate = self;
    self.passwordField.delegate = self;
    self.schIdField.placeholder = @"请输入图书馆账号";
    self.passwordField.placeholder =@"请输入图书馆密码";
    [self.alertView.searchBt addTarget:self action:@selector(gotoMyLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView.closeBt addTarget:self action:@selector(cancelAlert:) forControlEvents:UIControlEventTouchUpInside];
}


- (void) initBookDetail
{
    self.bookDetail = [[[NSBundle mainBundle] loadNibNamed:@"BookDetailView" owner:self options:nil] objectAtIndex:1];
    [self.bookDetail setFrame:CGRectMake(30, 100,260,180)];
    [self.bookDetail setHidden:YES];
    [self.bookDetail setDelegate:self];
    [self.view addSubview:self.bookDetail];

    
}


- (void)initNavigationBar
{
    [self setTitle:@"图书馆"];
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"self_right_barButton"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 40, 36);
    button.frame = frame;
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* selfItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = selfItem;
}


- (void)loadData{
    [[[[ApisFactory getApiMSearchBook]setPage:page pageCount:20] load:self selecter:@selector(disposMessage:) keyword:self.searchField.text]showLoading];
}
-(void)addHeader
{
    
}

#pragma mark 网络回调
- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MSearchBook"]) {
            MBookList_Builder* bookList = (MBookList_Builder*)[son getBuild];
            if (page>1) {
                [self.books addObjectsFromArray:bookList.newsList];
                [self doneWithView:_footer];
            } else if (page==1)
            {
                [self.books removeAllObjects];
                [self.books addObjectsFromArray:bookList.newsList];
            }
            [self.resultLabel setText:[NSString stringWithFormat:@"共找到%d个结果",bookList.cnt]];
            [self.myCollectionView reloadData];
            
        }else if ([[son getMethod] isEqualToString:@"MBookDetail"])
        {
            self.loading=NO;
            MBook_Builder* books = (MBook_Builder*)[son getBuild];
            NSMutableArray* myBooks = [[NSMutableArray alloc]init];
            for (MBookDetail* detail in books.detailsList) {
                Book* book = [[Book alloc]init];
                book.location = detail.address;
                book.barCode = detail.code;
                book.state = detail.state;
                book.borrowId = detail.num;
                book.bookName = self.selectedBookName;
                [myBooks addObject:book];
            }
            if (myBooks.count==0) {
                [ToolUtils showMessage:@"该书不存在"];
                return;
            }
            [self.bookDetail addBooks:myBooks];
            [self.bookDetail setHidden:NO];
            [self.maskView setHidden:NO];
            [self addMask];
        } else if ([[son getMethod] isEqualToString:@"MMyLibrary"]){
            [ToolUtils setIsVeryfy:1];
            [self.loginIndicator removeFromSuperview];
            [self setOK:YES];
            MBookList_Builder* myBookList = (MBookList_Builder*)[son getBuild];
            [self cancelAlert:nil];
            [self performSegueWithIdentifier:@"myLibrary" sender:myBookList.newsList];
            
        }
    } else {
        [super disposMessage:son];
    }
}


#pragma mark -按钮监听
- (IBAction)searchBook:(id)sender {
    
    if ([self.searchField.text isEqualToString:@""]) {
        [UtilMethods showMessage:@"关键字不能为空"];
    } else {
        
        [self.searchField resignFirstResponder];
        [self.passwordField resignFirstResponder];
        
        if (sender!=nil) {
            page=1;
        }
        [self waiting:@"正在搜索"];
        [[[[ApisFactory getApiMSearchBook]setPage:page pageCount:20] load:self selecter:@selector(disposMessage:) keyword:self.searchField.text]showLoading];
    }
}
- (IBAction)showSelf:(id)sender {
    [self showAlert];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelAlert:(id)sender {
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    [self.passwordField resignFirstResponder];
    [self.schIdField resignFirstResponder];
    [self.searchField resignFirstResponder];
    [self.maskView setHidden:YES];
    [self.alertView setHidden:YES];
    [self.bookDetail setHidden:YES];
    [super removeMask];
    
}

- (void)showAlert
{
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}
- (IBAction)gotoMyLibrary:(id)sender {
    [self.passwordField resignFirstResponder];
    [self.schIdField resignFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
    if (self.schIdField.text.length==0) {
        [ToolUtils showMessage:@"学工号不能为空"];
    } else if (self.passwordField.text.length==0)
    {
        [ToolUtils showMessage:@"密码不能为空"];
    } else {
        [self waiting:@"加载中"];
        if (self.rememberSwitch.isOn) {
            [ToolUtils setLibraryId:self.schIdField.text];
            [ToolUtils setLibraryPassword:self.passwordField.text];
        }
         
         [self load:self selecter:@selector(disposMessage:) account:self.schIdField.text password:self.passwordField.text];
    }
    
}

         /**
          *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
          * @param delegate 回调类
          * @param select  回调函数
          * @param account * account
          * @param password * password
          * @callback MBookList_Builder
          */
         -(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
             NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
             [array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
             [array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
             [array addObject:[NSString stringWithFormat:@"isReInput=%d",self.isRe]];
             [array addObject:[NSString stringWithFormat:@"isV=%d",[ToolUtils getIsVeryfy]]];
             
             UpdateOne *updateone=[[UpdateOne alloc] init:@"MMyLibrary" params:array  delegate:delegate selecter:select];
             [updateone setShowLoading:NO];
             [DataManager loadData:[[NSArray alloc]initWithObjects:updateone,nil] delegate:delegate];
             return updateone;
         }


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"myLibrary"]) {
        MyLibraryVC* nextVC = (MyLibraryVC*)segue.destinationViewController;
        nextVC.myBookList = sender;
        nextVC.password = self.passwordField.text;
        nextVC.account = self.schIdField.text;
    }
}


#pragma mark delegateTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    if (textField==self.searchField) {
        [self searchBook:nil];
    } else if (textField==self.schIdField)
    {
        [self.passwordField becomeFirstResponder];
    } else if (textField==self.passwordField){
        [self gotoMyLibrary:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
            CGFloat offset= self.frame.origin.y+self.frame.size.height-(self.view.bounds.size.height-216);
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -offset);
        } completion:^(BOOL finished) {
        }];
}
#pragma mark delegate_AlertChoose
- (void)closeAlert{
    [self cancelAlert:nil];
}

#pragma mark - chooseBookDelegate
- (void)chooseBook:(Book *)book
{
    
    [self waiting:@"加载中"];
    [[[ApisFactory getApiMBookDetail]load:self selecter:@selector(disposMessage:) id:book.id] setShowLoading:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.books count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    BookCollectionCell* bookView = [collectionView dequeueReusableCellWithReuseIdentifier:@"result" forIndexPath:indexPath];
    MBook* book = [self.books objectAtIndex:indexPath.row];
    Book* myBook = [[Book alloc]init];
    myBook.id = book.id;
    myBook.hasCount = [NSString stringWithFormat:@"%d",book.total];
    myBook.canLentCount = [NSString stringWithFormat:@"%d",book.canBorrow];
    myBook.press = book.publish;
    myBook.bookName = book.title;
    myBook.author = book.author;
    [bookView setBook:myBook];
    return bookView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.loading) {
        self.loading=YES;
        self.selectedBookName = ((MBook*)[self.books objectAtIndex:indexPath.row]).title;
        [self chooseBook:[self.books objectAtIndex:indexPath.row]];
    }}
@end

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
@interface BookViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AlertCloseDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSArray* books;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong,nonatomic)BookDetailScrollerView* bookDetail;
@property (nonatomic)int page;
@property (nonatomic,strong)NSString* selectedBookName;
@property(nonatomic)BOOL loading;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@end

@implementation BookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self initBookDetail];
    self.page = 1;
    self.loading=NO;
    // Do any additional setup after loading the view.
}

- (void) initBookDetail
{
     self.bookDetail = [[[NSBundle mainBundle] loadNibNamed:@"BookDetailView" owner:self options:nil] objectAtIndex:1];
    [self.bookDetail setFrame:CGRectMake(30, 100,260,180)];
    [self.bookDetail setHidden:YES];
    [self.bookDetail setDelegate:self];
    [self.view addSubview:self.bookDetail];
    
}
- (IBAction)searchBook:(id)sender {
    if ([self.searchField.text isEqualToString:@""]) {
        [UtilMethods showMessage:@"关键字不能为空"];
    } else {
        [self.searchField resignFirstResponder];
        [self waiting:@"正在搜索"];
        [[[[ApisFactory getApiMSearchBook]setPage:self.page pageCount:100] load:self selecter:@selector(disposMessage:) keyword:self.searchField.text]showLoading];
    }
}

- (void)disposMessage:(Son *)son
{
    self.OK=YES;
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MSearchBook"]) {
            MBookList_Builder* bookList = (MBookList_Builder*)[son getBuild];
            self.books = bookList.newsList;
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
            [self.bookDetail addBooks:myBooks];
            [self.bookDetail setHidden:NO];
            [self.maskView setHidden:NO];
            [self addMask];
        } else if ([[son getMethod] isEqualToString:@"MMyLibrary"]){
            
            [self.loginIndicator removeFromSuperview];
            
            MBookList_Builder* myBookList = (MBookList_Builder*)[son getBuild];
            [self cancelAlert:nil];
            [self performSegueWithIdentifier:@"myLibrary" sender:myBookList.newsList];
            
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"myLibrary"]) {
        MyLibraryVC* nextVC = (MyLibraryVC*)segue.destinationViewController;
        nextVC.myBookList = sender;
    }
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
//    [selfItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = selfItem;
}

- (void)showAlert
{
    [self.alertView setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}
- (IBAction)gotoMyLibrary:(id)sender {
    
    if (self.schIdField.text.length==0) {
        [ToolUtils showMessage:@"学工号不能为空"];
    } else if (self.passwordField.text.length==0)
    {
        [ToolUtils showMessage:@"密码不能为空"];
    } else {
        [self waiting:@"加载中"];
        [[ApisFactory getApiMMyLibrary]load:self selecter:@selector(disposMessage:) account:self.schIdField.text password:self.passwordField.text];
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
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
        [self gotoMyLibrary:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.view.window.frame.size.height==480) {
        [UIView animateWithDuration:0.3f animations:^{
            //        self.alertView.center = newCenter;
        }];
        [UIView animateWithDuration:0.3f animations:^{
            self.alertView.transform = CGAffineTransformMakeTranslation(0, -40);
        } completion:^(BOOL finished) {
        }];
        
    }
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

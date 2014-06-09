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
#import "BookDetailView.h"
#import "AlertCloseDelegate.h"
#import "BookChooseDelegate.h"
#import "BookCollectionCell.h"
@interface BookViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,AlertCloseDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray* books;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITextField *schIdField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong,nonatomic)BookDetailView* bookDetail;
@end

@implementation BookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    [self loadBooks];
    [self initBookDetail];
    // Do any additional setup after loading the view.
}

- (void) initBookDetail
{
     self.bookDetail = [[[NSBundle mainBundle] loadNibNamed:@"BookDetailView" owner:self options:nil] firstObject];
    [self.bookDetail setFrame:CGRectMake(30, 100,260,180)];
    [self.bookDetail setHidden:YES];
    [self.bookDetail setDelegate:self];
    [self.view addSubview:self.bookDetail];
    
}

- (void)loadBooks
{
    self.books = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<20; i++){
        Book* book = [[Book alloc]init];
        book.bookName = @"三重门";
        book.location = @"鼓楼校区一样本库";
        book.borrowId = @"123456";
        book.barCode = @"2123123124";
        book.author = @"韩寒";
        book.press= @"作家出版社2000";
        book.canLentCount = @"6";
        book.hasCount=@"6";
        [self.books addObject:book];
    }
}
- (void)initNavigationBar
{
    [self setTitle:@"图书馆"];
    [self setSubTitle:@"搜索藏书和借阅情况"];
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
    [self cancelAlert:nil];
    [self performSegueWithIdentifier:@"myLibrary" sender:nil];
}
#pragma mark delegateTextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark delegate_AlertChoose
- (void)closeAlert{
    [self cancelAlert:nil];
}

#pragma mark - chooseBookDelegate
- (void)chooseBook:(Book *)book
{
    [self.bookDetail setBook:book];
    [self.bookDetail setHidden:NO];
    [self.maskView setHidden:NO];
    [self addMask];
}

- (IBAction)cancelAlert:(id)sender {
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
    [bookView setBook:[self.books objectAtIndex:indexPath.row ]];
    return bookView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self chooseBook:[self.books objectAtIndex:indexPath.row]];
}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//


//#pragma mark -table
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.books count]/3+1;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 142;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    BookCell* cell = [tableView dequeueReusableCellWithIdentifier:@"book"];
//    NSMutableArray* myBook = [[NSMutableArray alloc]init];
//    for (int i = 0; i<3; i++) {
//        if (indexPath.row*3+i<[self.books count]) {
//            [myBook addObject:[self.books objectAtIndex:indexPath.row*3+i]];
//        }
//    }
//    [cell setBooks:myBook delegate:self];
//    return cell;
//}

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

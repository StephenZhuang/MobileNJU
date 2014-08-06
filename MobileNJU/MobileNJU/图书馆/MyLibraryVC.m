//
//  MyLibraryVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "MyLibraryVC.h"
#import "Book.h"
#import "MyBookCell.h"
#import "ZsndLibrary.pb.h"
@interface MyLibraryVC ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation MyLibraryVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"我的借阅"];
    // Do any additional setup after loading the view.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myBookList count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBookCell* cell = [tableView dequeueReusableCellWithIdentifier:@"myBook"];
    Book* myBook = [[Book alloc]init];
    MBook* book = [self.myBookList objectAtIndex:indexPath.row];
    myBook.bookName = book.title;
    myBook.borrowDate = book.borrowTime;
    myBook.returnDate = book.backTime;
    if (!book.canRenew) {
        [cell.continueBt setEnabled:NO];
    }
    [cell setBook:myBook];
    cell.continueBt.tag = 200+indexPath.row;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
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
- (IBAction)continueBorrow:(id)sender {
    [self waiting:@"正在续借"];
    UIButton* button = (UIButton*)sender;
    MBook* book = [self.myBookList objectAtIndex:button.tag-200];
    [[ApisFactory getApiMBookRenew]load:self selecter:@selector(disposMessage:) id:book.id account: self.account password:self.password];
}

- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod]isEqualToString:@"MBookRenew"]) {
            MRet_Builder* ret = (MRet_Builder*)[son getBuild];
            [ToolUtils showMessage:ret.msg];
        }
    }
}

@end

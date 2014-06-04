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
@interface MyLibraryVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray* myBooks;
@end

@implementation MyLibraryVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMyBooks];
//    [self initNavigationBar];
   
    // Do any additional setup after loading the view.
}
//- (void)initNavigationBar
//{
//    [self setTitle:@"个人登录"];
//    [self setSubTitle:@"借阅信息"];
//}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMyBooks
{
    self.myBooks = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < 10 ; i ++){
        Book* book = [[Book alloc]init];
        book.bookName = @"乌合之众，大众心理研究：a study of the popular mind";
        book.returnDate = @"2014-4-20";
        book.borrowDate = @"2014-5-20";
        [self.myBooks addObject:book];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myBooks count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBookCell* cell = [tableView dequeueReusableCellWithIdentifier:@"myBook"];
    [cell setBook:[self.myBooks objectAtIndex:indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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

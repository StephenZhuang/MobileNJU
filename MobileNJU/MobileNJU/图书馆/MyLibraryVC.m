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
    [cell setBook:myBook];
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

@end

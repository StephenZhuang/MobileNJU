//
//  NewsListTVC.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "NewsListTVC.h"
#import "NewsDetailVC.h"
#import "NewsCell.h"
@interface NewsListTVC ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation NewsListTVC
#pragma viewController

- (IBAction)backToMain:(UIBarButtonItem *)sender {
    if (self.jump) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.currentUrl = self.navigationController.title;
    if (self.jump) {
        [self performSegueWithIdentifier:@"detail" sender:nil];
        
        [self setTitle:@""];
        [self setSubTitle:@""];
    } else {
        [self setTitle:@"新闻列表"];
        [self setSubTitle:@"官方新闻"];
    }
   
}
    
//       // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail"]) {
        NewsDetailVC* destinationVC = (NewsDetailVC*)segue.destinationViewController;
        [destinationVC setUrl:self.currentUrl];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentUrl = [NSString stringWithFormat:@"%d",indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:nil];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news" forIndexPath:indexPath];
    
    return cell;
}


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


#pragma mark - Navigation


@end

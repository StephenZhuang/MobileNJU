//
//  TreeHoleDetailViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleDetailViewController.h"
#import "TreeHoleCell.h"
#import "CommentCell.h"
#import "FaceAndTextLabel.h"

@interface TreeHoleDetailViewController ()

@end

@implementation TreeHoleDetailViewController

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
    // Do any additional setup after loading the view.
    [self setTitle:@"树洞详情"];
    [self setSubTitle:@"您可以回复和点赞"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"http://img0.bdstatic.com/img/image/shouye/dengni36.jpg",@"http://imgt8.bdstatic.com/it/u=2,3094647973&fm=19&gp=0.jpg",@"http://imgt8.bdstatic.com/it/u=2,3096148905&fm=19&gp=0.jpg", nil];
        //    NSMutableArray *array = [[NSMutableArray alloc] init];
        [cell setImageArray:array];
        return CGRectGetMaxY(cell.zanButton.frame) + 10;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        if (!cell.commentLabel) {
            cell.commentLabel = [[FaceAndTextLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
        }
//        FaceAndTextLabel * label  = [[FaceAndTextLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
        cell.commentLabel.font = [UIFont systemFontOfSize:14];
        [cell.commentLabel  setFaceAndText:@"姑妈[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗]"];
        return cell.commentLabel.frame.size.height + 20;
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
        
        //    NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"http://img0.bdstatic.com/img/image/shouye/dengni36.jpg",@"http://img0.bdstatic.com/img/image/shouye/mnwlmn-9569205918.jpg",@"http://img0.bdstatic.com/img/image/shouye/mvznns.jpg",@"http://img0.bdstatic.com/img/image/shouye/fsfss001.jpg", nil];
        [cell setImageArray:array];
        return cell;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
//        for (UIView *view in cell.contentView.subviews) {
//            [view removeFromSuperview];
//        }
        
        if (!cell.commentLabel) {
            cell.commentLabel = [[FaceAndTextLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
            [cell.contentView addSubview:cell.commentLabel];
        }
        //        FaceAndTextLabel * label  = [[FaceAndTextLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
        cell.commentLabel.font = [UIFont systemFontOfSize:14];
        [cell.commentLabel  setFaceAndText:@"姑妈[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗]"];
        
//        FaceAndTextLabel * label  = [[FaceAndTextLabel alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
//        label.font = [UIFont systemFontOfSize:14];
//        [label  setFaceAndText:@"姑妈[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗]"];
//        [cell.contentView addSubview:label];
        return cell;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

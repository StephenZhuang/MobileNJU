//
//  NewMessageListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NewMessageListViewController.h"
#import "NewMessageCell.h"

@interface NewMessageListViewController ()

@end

@implementation NewMessageListViewController

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
    [self setTitle:@"树洞的回复"];
    [self setSubTitle:@"吐槽您的生活"];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMessageCell"];
    [cell.titleLabel setText:@"食堂的饭菜真难吃！"];
//    [cell.nameLabel setText:@"姑妈 回复 南大树洞："];
    
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"姑妈"];
//    [attributeString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : [UIFont systemFontOfSize:14]} range:NSMakeRange(0, 2)];
    NSMutableAttributedString *fromString = [[NSMutableAttributedString alloc] initWithString:@"姑妈" attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    NSMutableAttributedString *replyString = [[NSMutableAttributedString alloc] initWithString:@" 回复 " attributes:@{NSForegroundColorAttributeName : RGB(162, 162, 162),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    NSMutableAttributedString *toString = [[NSMutableAttributedString alloc] initWithString:@"南大树洞：" attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    
    [fromString appendAttributedString:replyString];
    [fromString appendAttributedString:toString];
    cell.nameLabel.attributedText = fromString;
    
//    [cell.contentLabel  setAttributedText:@"姑妈[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗]"];
    [cell.contentLabel removeFromSuperview];
    cell.contentLabel = [[HBCoreLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), CGRectGetMinY(cell.nameLabel.frame)+ 0.5, 290 - CGRectGetWidth(cell.nameLabel.frame), CGRectGetHeight(cell.nameLabel.frame))];
    MatchParser * match=[[MatchParser alloc]init];
    match.width=290;
    [match match:@"姑妈[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗"];
    cell.contentLabel.match=match;
    [cell.contentView addSubview:cell.contentLabel];
    return cell;
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

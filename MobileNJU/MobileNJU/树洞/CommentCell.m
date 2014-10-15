//
//  CommentCell.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "CommentCell.h"
#import "NSString+unicode.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setComment:(MComment *)comment author:(NSString *)author
//{
//    if (!self.commentLabel) {
//        self.commentLabel = [[HBCoreLabel alloc]initWithFrame:CGRectMake(10, 5, 300, 500)];
//        [self.contentView addSubview:self.commentLabel];
//    }
//    
//    self.commentLabel.font = [UIFont systemFontOfSize:14];
//    
//    NSString *fromStr = comment.nickname1;
//    if ([comment.userid1 isEqualToString:author]) {
//        fromStr = @"南大树洞";
//    }
//    
//    if (comment.userid2.length == 0) {
//        fromStr = [fromStr stringByAppendingString:@"："];
//    }
//    NSMutableAttributedString *fromString = [[NSMutableAttributedString alloc] initWithString:fromStr attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//    
//    if (comment.userid2.length > 0) {
//        NSString *toStr = comment.nickname2;
//        if ([comment.userid2 isEqualToString:author]) {
//            toStr = @"南大树洞";
//        }
//        toStr = [toStr stringByAppendingString:@"："];
//        NSMutableAttributedString *replyString = [[NSMutableAttributedString alloc] initWithString:@" 回复 " attributes:@{NSForegroundColorAttributeName : RGB(162, 162, 162),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//        NSMutableAttributedString *toString = [[NSMutableAttributedString alloc] initWithString:toStr attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//        
//        [fromString appendAttributedString:replyString];
//        [fromString appendAttributedString:toString];
//    }
//    
//    
//    MatchParser * match=[[MatchParser alloc]init];
//    match.width=290;
////    [match match:@"[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗" ];
//    [match match:comment.content atCallBack:^BOOL(NSString *string) {
//        return YES;
//    }title:fromString];
//    self.commentLabel.match=match;
//    CGRect rect = self.commentLabel.frame;
//    rect.size.height = match.height;
//    [self.commentLabel setFrame:rect];
//}
//
//- (CGFloat)matchContent:(MComment *)comment author:(NSString *)author
//{
//    NSString *fromStr = comment.nickname1;
//    if ([comment.userid1 isEqualToString:author]) {
//        fromStr = @"南大树洞";
//    }
//    
//    if (comment.userid2.length == 0) {
//        fromStr = [fromStr stringByAppendingString:@"："];
//    }
//    NSMutableAttributedString *fromString = [[NSMutableAttributedString alloc] initWithString:fromStr attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//    
//    if (comment.userid2.length > 0) {
//        NSString *toStr = comment.nickname2;
//        if ([comment.userid2 isEqualToString:author]) {
//            toStr = @"南大树洞";
//        }
//        toStr = [toStr stringByAppendingString:@"："];
//        NSMutableAttributedString *replyString = [[NSMutableAttributedString alloc] initWithString:@" 回复 " attributes:@{NSForegroundColorAttributeName : RGB(162, 162, 162),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//        NSMutableAttributedString *toString = [[NSMutableAttributedString alloc] initWithString:toStr attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//        
//        [fromString appendAttributedString:replyString];
//        [fromString appendAttributedString:toString];
//    }
//    
//    
//    MatchParser * match=[[MatchParser alloc]init];
//    match.width=290;
////    [match match:@"[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗" ];
//    [match match:comment.content atCallBack:^BOOL(NSString *string) {
//        return YES;
//    }title:fromString];
//    return match.height;
//}

+ (CGFloat)getHeightByComment:(MComment *)comment
{
    CGFloat height = 13;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(227,2000);
//    NSMutableString* str = [[NSMutableString alloc]initWithString:comment.content];
//    if (comment.content.length>16) {
//        int space = 16-comment.content.length%16;
//        for (int i = 0 ; i < space ; i ++)
//        {
//            [str appendString:@"    "];
//        }
//    }
//    [str appendString:@"。"];
    CGSize labelsize = [comment.content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    height += labelsize.height;
    
//    if (comment.replyid.length > 0 || comment.isLz == 1) {
        height += 53;
//    } else {
//        height += 36;
//    }
    
    return height;
}
@end

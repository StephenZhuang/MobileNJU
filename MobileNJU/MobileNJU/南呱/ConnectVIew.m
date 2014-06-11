//
//  ConnectVIew.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ConnectVIew.h"
#import "TreeHoleImageCell.h"

@implementation CardView

- (void)drawRect:(CGRect)rect
{
//    self.layer.borderColor = [UIColor blackColor].CGColor;
//    self.layer.borderWidth = 1;
}

- (void)setMatch:(MMatch_Builder *)match
{
    [self setHidden:NO];
    [_collegeLabel setText:match.school];
    [_gradeLabel setText:match.belong];
    [_flowerLabel setText:[NSString stringWithFormat:@"鲜花数：%i",match.flower]];
    [UIView animateWithDuration:1 animations:^(void) {
        [_collegeLabel setAlpha:1];
        [_gradeLabel setAlpha:1];
        [_flowerLabel setAlpha:1];
    }];
}
@end

@implementation ConnectVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.cancelButton.layer.borderWidth = 1;
    self.cancelButton.layer.cornerRadius = 5;
    
    self.logoImage.layer.cornerRadius = 24;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TreeHoleImageCell" forIndexPath:indexPath];
    int i =  indexPath.row % 8 + 100;
    [cell.contentImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"f%i" , i]]];
    return cell;
}

- (void)startConnecting
{
    time = 0;
    [_collectionView setHidden:NO];
    [_tipLabel setText:@"正在为您匹配南呱，请您稍等……"];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setFrame:CGRectMake(126, 352, 68, 30)];
    [_fruitImage setImage:[UIImage imageNamed:@"fruit_0"]];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollAnimation) userInfo:nil repeats:YES];
}

- (void)scrollAnimation
{
    time ++;
    [_collectionView setContentOffset:CGPointMake(56 * time, 0) animated:YES];
    int i = time % 6;
    [UIView animateWithDuration:0.2 animations:^(void) {
        [_fruitImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i" , i]]];
    }];
    
//    if (time == 5) {
//        [self timedout];
//    }
    
    if (time == 20) {
        [self stopAnimation];
    }
}

- (void)timedout
{
    [_collectionView setHidden:YES];
    [self stopAnimation];
    [_fruitImage setImage:[UIImage imageNamed:@"nangua_connect_timedout@2x"]];
    [_tipLabel setText:@"连接超时"];
    [_cancelButton setTitle:@"重新匹配" forState:UIControlStateNormal];
    [_cancelButton setFrame:CGRectMake(0, 0, 100, 30)];
}

- (void)stopAnimation
{
    [timer invalidate];
    time = 0;
    [_collectionView setContentOffset:CGPointMake(0, 0)];
}

@end

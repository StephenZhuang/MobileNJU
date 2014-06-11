//
//  ConnectVIew.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ConnectVIew.h"
#import "TreeHoleImageCell.h"

@implementation ConnectVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
    
    if (time == 90) {
        [self stopAnimation];
    }
}

- (void)stopAnimation
{
    [timer invalidate];
    time = 0;
    [_collectionView setContentOffset:CGPointMake(0, 0)];
}

@end

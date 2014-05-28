//
//  TreeHoleCell.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleCell.h"
#import "TreeHoleImageCell.h"

@implementation TreeHoleCell

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
    _imageArray = [[NSMutableArray alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma - mark collectionview delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TreeHoleImageCell" forIndexPath:indexPath];
    
    NSString *imageUrl = [_imageArray objectAtIndex:indexPath.row];
    [cell.contentImage setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    cell.contentImage.layer.contentsGravity = kCAGravityResizeAspectFill;
    
    return cell;
}

- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    [_collectionView reloadData];
    
    CGRect rect = _collectionView.frame;
    if (_imageArray.count == 0) {
        rect.size.height = 0;
    } else if (_imageArray.count < 3) {
        rect.size.height = 110;
    } else {
        rect.size.height = 230;
    }
//    rect.size = _collectionView.contentSize;
    [_collectionView setFrame:rect];
}

@end

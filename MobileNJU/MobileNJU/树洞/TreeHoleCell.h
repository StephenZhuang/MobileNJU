//
//  TreeHoleCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreeHoleCell : UITableViewCell<UICollectionViewDataSource , UICollectionViewDelegate>
@property (nonatomic , strong) IBOutlet UIImageView *logoImage;
@property (nonatomic , strong) IBOutlet UILabel *titleLabel;
@property (nonatomic , strong) IBOutlet UILabel *timeLabel;
@property (nonatomic , strong) IBOutlet UILabel *contentLabel;
@property (nonatomic , strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic , strong) IBOutlet UIButton *zanButton;
@property (nonatomic , strong) IBOutlet UIButton *commentButton;
@property (nonatomic , strong) IBOutlet UIButton *deleteButton;
@end

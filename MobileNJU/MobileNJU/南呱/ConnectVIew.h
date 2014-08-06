//
//  ConnectVIew.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZsndChat.pb.h"

@interface CardView : UIView
@property (nonatomic , weak) IBOutlet UILabel *gradeLabel;
@property (nonatomic , weak) IBOutlet UILabel *collegeLabel;
@property (nonatomic , weak) IBOutlet UILabel *flowerLabel;
//- (void)setMatch:(MMatch_Builder *)match;
@end

@interface ConnectVIew : UIView<UICollectionViewDataSource , UICollectionViewDelegate>
{
    NSTimer *timer;
    int time;
}
@property (nonatomic , weak) IBOutlet UIImageView *logoImage;
@property (nonatomic , weak) IBOutlet UILabel *nameLabel;
@property (nonatomic , weak) IBOutlet UILabel *flowerLabel;

@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic , weak) IBOutlet UIImageView *fruitImage;
@property (nonatomic , weak) IBOutlet UILabel *tipLabel;
@property (nonatomic , weak) IBOutlet UIButton *cancelButton;
@property (nonatomic , weak) IBOutlet CardView *cardView;
@property (nonatomic , assign) BOOL isCall;
- (void)startConnecting;
- (void)stopAnimation;
@end

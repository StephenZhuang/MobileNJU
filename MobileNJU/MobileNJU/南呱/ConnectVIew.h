//
//  ConnectVIew.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectVIew : UIView<UICollectionViewDataSource , UICollectionViewDelegate>
{
    NSTimer *timer;
    int time;
}
@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic , weak) IBOutlet UIImageView *fruitImage;
- (void)startConnecting;
- (void)stopAnimation;
@end

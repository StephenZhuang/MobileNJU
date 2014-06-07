//
//  EmojiViewController.h
//  MallTemplate
//
//  Created by Stephen Zhuang on 14-4-18.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^EmojiBlock)(NSString *string);

@interface EmojiViewController : BaseViewController<UICollectionViewDataSource , UICollectionViewDelegate>
@property (nonatomic , copy) EmojiBlock emojiBlock;
@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
+ (EmojiViewController *)shareInstance;
@end
